#ifndef SESSION_H
#define SESSION_H

#include <QObject>
#include <QQmlEngine>

class Session : public QObject
{
    Q_OBJECT
public:
    explicit Session(QObject *parent = nullptr);
    static bool RegisterSingleton(QQmlEngine* engine);

signals:

public slots:

private:
    bool Initialize();
};

#endif // SESSION_H
