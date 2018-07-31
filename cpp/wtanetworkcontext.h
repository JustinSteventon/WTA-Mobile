#ifndef WTANETWORKCONTEXT_H
#define WTANETWORKCONTEXT_H

#include <QObject>
#include <QQmlEngine>
#include <QNetworkAccessManager>
#include <QNetworkCookieJar>
#include <QVariant>

class WTANetworkContext : public QObject
{
    Q_OBJECT
    QNetworkAccessManager* networkManager;
    bool IsLoggedIn;

    WTANetworkContext(QObject* parent);
    bool Initialize();

public slots:
    void handleLoginResponse();
    void handleLogoutResponse();
    void handleBackpackResponse();

signals:
    void loginCompleted(bool loginSuccessful);
    void loggedOut();
    void backpackReady(QVariantMap map);

public:

    Q_INVOKABLE void Login(QString userName, QString password);
    Q_INVOKABLE void Logout();
    Q_INVOKABLE void getBackpack();
    static bool RegisterSingleton(QQmlEngine* engine);
};

#endif // WTANETWORKCONTEXT_H
