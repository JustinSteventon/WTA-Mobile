#include "session.h"
#include <QQmlContext>

static Session* s_instance = nullptr;

Session::Session(QObject *parent) : QObject(parent)
{

}

bool Session::Initialize()
{
    return true;
}

bool Session::RegisterSingleton(QQmlEngine* qmlEngine)
{
    bool success;
    Session* session = nullptr;
    QQmlContext *rootContext = qmlEngine->rootContext();

    if (s_instance) {
        success = true;
        goto exit;
    }

    session = new Session(qmlEngine);
    if (session == nullptr)
    {
        success = false;
        goto exit;
    }

    if (!session->Initialize())
    {
        success = false;
        goto exit;
    }

    rootContext->setContextProperty("Session", session);
    s_instance = session;
    session = nullptr;
    success = true;

exit:

    if (session != nullptr)
    {
        delete session;
    }

    return success;
}
