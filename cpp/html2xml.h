#ifndef HTML2XML_H
#define HTML2XML_H

#include <QObject>
#include <QQmlEngine>

class Html2Xml : public QObject
{
    Q_OBJECT
public:
    Html2Xml(QObject* parent);
    bool Initialize();

public slots:

signals:

public:
    Q_INVOKABLE QString Execute(QString dirtyHTML);

    static bool RegisterSingleton(QQmlEngine* engine);
};

#endif // HTML2XML
