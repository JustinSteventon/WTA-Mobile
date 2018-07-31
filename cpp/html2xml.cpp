#include "cpp/Html2Xml.h"
#include <QQmlContext>
#include <QDebug>
#include <QVariant>
#include <QBuffer>
#include <../tidyhtml/tidy.h>
#include <../tidyhtml/tidybuffio.h>

static Html2Xml* s_instance = nullptr;

Html2Xml::Html2Xml(QObject* parent) : QObject(parent)
{
}

bool Html2Xml::RegisterSingleton(QQmlEngine* qmlEngine)
{
    bool Success;
    Html2Xml* LocalContext = nullptr;
    QQmlContext *rootContext = qmlEngine->rootContext();

    if (s_instance) {
        Success = true;
        goto Exit;
    }

    LocalContext = new Html2Xml(qmlEngine);
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

    rootContext->setContextProperty("Html2Xml", LocalContext);
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

bool Html2Xml::Initialize()
{
    return true;
}

QString Html2Xml::Execute(QString dirtyHTML)
{
    TidyBuffer output = {};
    TidyBuffer errbuf = {};
    bool ok;
    int rc;
    TidyDoc tdoc = tidyCreate();
    ok = tidyOptSetBool(tdoc, TidyXhtmlOut, yes);  // Convert to XHTML
    rc = tidySetErrorBuffer(tdoc, &errbuf);        // Capture diagnostics
    rc = tidyParseString(tdoc, dirtyHTML.toStdString().c_str()); // Parse the input
    rc = tidyCleanAndRepair(tdoc);                  // Tidy it up!
    rc = tidySaveBuffer(tdoc, &output);            // Pretty Print

    return QString((char *)output.bp);
}
