#include "cpp/wtanetworkcontext.h"
#include <QQmlContext>
#include <QNetworkReply>
#include <QDebug>
#include <QVariant>
#include <QUrlQuery>
#include <QList>
#include <QNetworkCookie>
#include <QNetworkCookieJar>
#include <QDomDocument>
#include <cpp/html2xml.h>

static WTANetworkContext* s_instance = nullptr;

WTANetworkContext::WTANetworkContext(QObject* parent) : QObject(parent)
{
    networkManager = nullptr;
    IsLoggedIn = false;
}

bool WTANetworkContext::RegisterSingleton(QQmlEngine* qmlEngine)
{
    bool Success;
    WTANetworkContext* LocalContext = nullptr;
    QQmlContext *rootContext = qmlEngine->rootContext();

    if (s_instance) {
        Success = true;
        goto Exit;
    }

    LocalContext = new WTANetworkContext(qmlEngine);
    if (LocalContext == nullptr)
    {
        Success = false;
        goto Exit;
    }

    if (!LocalContext->Initialize())
    {
        Success = false;
        goto Exit;
    }

    rootContext->setContextProperty("WTANetworkContext", LocalContext);
    s_instance = LocalContext;
    LocalContext = nullptr;
    Success = true;

Exit:
    if (LocalContext != nullptr)
    {
        delete LocalContext;
    }

    return Success;
}

bool WTANetworkContext::Initialize()
{
    bool Result;
    networkManager = new QNetworkAccessManager(this);
    if (networkManager == nullptr)
    {
        Result = false;
        goto Exit;
    }

    //
    // TODO: Refill the cookie jar with cookies that may have been serialized
    // in earlier sessions.
    //

    networkManager->setCookieJar(new QNetworkCookieJar(networkManager));

    Result = true;

Exit:
    return Result;
}

void WTANetworkContext::Login(QString userName, QString password)
{
    qInfo() << "Username:" + userName + " Password: " + password;

    QNetworkRequest req;
    req.setUrl(QUrl("https://www.wta.org/login"));

    QUrlQuery postData;
    postData.addQueryItem("__ac_name", userName);
    postData.addQueryItem("__ac_password", password);
    postData.addQueryItem("submit","Log in");
    postData.addQueryItem("form.submitted", "1");
    qInfo() << postData.query();

    req.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36");\
    req.setRawHeader("Content-Type", "application/x-www-form-urlencoded");
    req.setRawHeader("Connection", "keep-alive");
    req.setRawHeader("Origin","https://www.wta.org");
    req.setRawHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
    req.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);

    QNetworkReply* resp = networkManager->post(req, postData.toString(QUrl::FullyEncoded).toUtf8());
    connect(resp, SIGNAL(finished()), this, SLOT(handleLoginResponse ()));
    IsLoggedIn = false;
}

void WTANetworkContext::Logout()
{
    qInfo() << "Logging out";
    QNetworkRequest req;
    req.setUrl(QUrl("https://www.wta.org/logout"));

    req.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36");\
    req.setRawHeader("Connection", "keep-alive");
    req.setRawHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
    req.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);

    QNetworkReply* resp = networkManager->get(req);
    connect(resp, SIGNAL(finished()), this, SLOT(handleLogoutResponse()));
}

void WTANetworkContext::getBackpack()
{
    qInfo() << "getbackpack ";

    QNetworkRequest req;
    req.setUrl(QUrl("https://www.wta.org/backpack"));

    req.setRawHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36");\
    req.setRawHeader("Connection", "keep-alive");
    req.setRawHeader("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
    req.setAttribute(QNetworkRequest::FollowRedirectsAttribute, true);

    QNetworkReply* resp = networkManager->get(req);
    connect(resp, SIGNAL(finished()), this, SLOT(handleBackpackResponse()));
}

void
WTANetworkContext::handleLoginResponse()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());

    // returns the HttpCode
    int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    qInfo() << httpStatus;

    if (httpStatus == 200)
    {
        // Verify that we got the authentication cookie.
        QList<QNetworkCookie> cookies = networkManager->cookieJar()->cookiesForUrl(QUrl("https://www.wta.org/login"));

        QList<QNetworkCookie>::iterator i;
        for (i = cookies.begin(); i != cookies.end(); ++i)
        {
            if (QString(i->name().constData()) == "__ac")
            {
                IsLoggedIn = true;
                break;
            }
        }
    }

    //TODO: Serialize cookie jar so we can "remember" that the user is logged in even if
    // they quit and return to the app before the cookie expires.

    emit loginCompleted(IsLoggedIn);
    qInfo() << "signal emitted with" << IsLoggedIn;
}

void
WTANetworkContext::handleLogoutResponse()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    // returns the HttpCode
    int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    qInfo() << httpStatus;

    if (httpStatus != 200)
    {
        return;
    }

    IsLoggedIn = false;

    //TODO: Serialize cookie jar so we can "remember" that the user is logged out.

    emit loggedOut();
}

void
WTANetworkContext::handleBackpackResponse()
{
    QNetworkReply *reply = qobject_cast<QNetworkReply *>(sender());
    QVariantMap map;
    // returns the HttpCode
    int httpStatus = reply->attribute(QNetworkRequest::HttpStatusCodeAttribute).toInt();
    qInfo() << httpStatus;

    if (httpStatus != 200)
    {
        return;
    }

    QString responseHtml = QString::fromUtf8(reply->readAll());

    Html2Xml html2xml(nullptr);

    QString xml = html2xml.Execute(responseHtml);
    QDomDocument dom;
    QString error;

    int line, column;

    if(!dom.setContent(xml, true, &error, &line, &column)) {
       qDebug() << "Error:" << error << "in line " << line << "column" << column;
       return;
    }

    QDomNodeList nodes = dom.elementsByTagName("p");
    for(int i = 0; i < nodes.count(); i++)
    {
       QDomNode elm = nodes.at(i);
       if(!elm.isElement())
       {
           continue;
       }

       auto text = elm.toElement().text();
       if (text.endsWith("Completed Days", Qt::CaseInsensitive))
       {
           text.truncate(text.indexOf("Completed Days", 0, Qt::CaseInsensitive));
           map.insert("completedDays", text);
       }

       if (text.endsWith("Upcoming Days", Qt::CaseInsensitive))
       {
           text.truncate(text.indexOf("Upcoming Days", 0, Qt::CaseInsensitive));
           map.insert("upcomingDays", text);
       }
    }

    emit backpackReady(map);
}
