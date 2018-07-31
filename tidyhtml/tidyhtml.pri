CONFIG += warn_off

INCLUDEPATH += $$PWD

DEFINES += TIDY_STATIC

HEADERS += \
    $$PWD/access.h \
    $$PWD/attrdict.h \
    $$PWD/attrs.h \
    $$PWD/buffio.h \
    $$PWD/charsets.h \
    $$PWD/clean.h \
    $$PWD/config.h \
    $$PWD/entities.h \
    $$PWD/fileio.h \
    $$PWD/forward.h \
    $$PWD/gdoc.h \
    $$PWD/language.h \
    $$PWD/language_en.h \
    $$PWD/language_en_gb.h \
    $$PWD/language_es.h \
    $$PWD/language_es_mx.h \
    $$PWD/language_fr.h \
    $$PWD/language_pt_br.h \
    $$PWD/language_zh_cn.h \
    $$PWD/lexer.h \
    $$PWD/mappedio.h \
    $$PWD/message.h \
    $$PWD/messageobj.h \
    $$PWD/parser.h \
    $$PWD/platform.h \
    $$PWD/pprint.h \
    $$PWD/sprtf.h \
    $$PWD/streamio.h \
    $$PWD/tags.h \
    $$PWD/tidy-int.h \
    $$PWD/tidy.h \
    $$PWD/tidybuffio.h \
    $$PWD/tidyenum.h \
    $$PWD/tidyplatform.h \
    $$PWD/tmbstr.h \
    $$PWD/utf8.h \
    $$PWD/version.h \

SOURCES += \
    $$PWD/access.c \
    $$PWD/alloc.c \
    $$PWD/attrdict.c \
    $$PWD/attrs.c \
    $$PWD/buffio.c \
    $$PWD/charsets.c \
    $$PWD/clean.c \
    $$PWD/config.c \
    $$PWD/entities.c \
    $$PWD/fileio.c \
    $$PWD/gdoc.c \
    $$PWD/istack.c \
    $$PWD/language.c \
    $$PWD/lexer.c \
    $$PWD/mappedio.c \
    $$PWD/message.c \
    $$PWD/messageobj.c \
    $$PWD/parser.c \
    $$PWD/pprint.c \
    $$PWD/sprtf.c \
    $$PWD/streamio.c \
    $$PWD/tagask.c \
    $$PWD/tags.c \
    $$PWD/tidylib.c \
    $$PWD/tmbstr.c \
    $$PWD/utf8.c \
