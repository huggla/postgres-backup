ARG TAG="20181108-edge"
ARG BASEIMAGE="huggla/backup-alpine:$TAG"
ARG RUNDEPS="libpq libldap"
ARG BUILDDEPS="postgresql-client"
ARG BUILDCMDS=\
"   mkdir -p /imagefs/usr/bin /imagefs/usr/lib "\
"&& cp -a /usr/bin/pg_dump* /imagefs/usr/bin/ "\
"&& cp -a /usr/lib/libsasl2* /imagefs/usr/lib/"
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
    VAR_FORMAT="custom" \
    VAR_JOBS="1" \
    VAR_COMPRESS="9" \
    VAR_DUMP_GLOBALS="yes" \
    VAR_KEEP_CAPS="cap_setgid"

#---------------Don't edit----------------
USER starter
ONBUILD USER root
#-----------------------------------------
