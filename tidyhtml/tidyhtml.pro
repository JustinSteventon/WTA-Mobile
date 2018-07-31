TEMPLATE = lib
TARGET = tidyhtml
DEPENDPATH += .
INCLUDEPATH += .

CONFIG += -qt staticlib
# warn_off

DEFINES += TIDY_STATIC

HEADERS += \
    access.h \
    attrdict.h \
    attrs.h \
    buffio.h \
    charsets.h \
    clean.h \
    config.h \
    entities.h \
    fileio.h \
    forward.h \
    gdoc.h \
    language.h \
    language_en.h \
    language_en_gb.h \
    language_es.h \
    language_es_mx.h \
    language_fr.h \
    language_pt_br.h \
    language_zh_cn.h \
    lexer.h \
    mappedio.h \
    message.h \
    messageobj.h \
    parser.h \
    platform.h \
    pprint.h \
    sprtf.h \
    streamio.h \
    tags.h \
    tidy-int.h \
    tidy.h \
    tidybuffio.h \
    tidyenum.h \
    tidyplatform.h \
    tmbstr.h \
    utf8.h \
    version.h \

SOURCES += \
    access.c \
    alloc.c \
    attrdict.c \
    attrs.c \
    buffio.c \
    charsets.c \
    clean.c \
    config.c \
    entities.c \
    fileio.c \
    gdoc.c \
    istack.c \
    language.c \
    lexer.c \
    mappedio.c \
    message.c \
    messageobj.c \
    parser.c \
    pprint.c \
    sprtf.c \
    streamio.c \
    tagask.c \
    tags.c \
    tidylib.c \
    tmbstr.c \
    utf8.c \
