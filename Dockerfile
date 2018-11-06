ARG TAG="20181106-edge"
ARG RUNDEPS="postgresql-client"
ARG EXECUTABLES="/usr/bin/pg_dumpall /usr/bin/pg_dump"
ARG BUILDCMDS=\
"   ls -laR /imagefs"

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
