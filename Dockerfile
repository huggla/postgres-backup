ARG TAG="20181106-edge"
ARG BUILDDEPS="postgresql-client"
ARG BUILDCMDS=\
"   cp -a /buildfs/usr/bin/pg_dump* /imagefs/usr/bin/ "\
"&& cp -a /buildfs/usr/lib/libldap* /buildfs/usr/lib/liblber* /buildfs/usr/lib/libsasl2* /buildfs/usr/lib/libpq* /imagefs/usr/lib/"

ARG EXECUTABLES="/usr/bin/pg_dumpall /usr/bin/pg_dump"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${BASEIMAGE:-huggla/base:$TAG} as base
FROM huggla/build:$TAG as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
COPY --from=build /imagefs /
#-----------------------------------------

ENV VAR_LINUX_USER="postgres" \
    VAR_PORT="5432" \
    VAR_FORMAT="directory" \
    VAR_JOBS="1" \
    VAR_COMPRESS="6" \
    VAR_DUMP_GLOBALS="yes"

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
