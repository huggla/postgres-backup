ARG TAG="20181101-edge"
ARG RUNDEPS="postgresql-client"
ARG EXECUTABLES="/usr/bin/pg_dumpall, /usr/bin/pg_basebackup, /usr/bin/pg_dump"

#---------------Don't edit----------------
FROM ${CONTENTIMAGE1:-scratch} as content1
FROM ${CONTENTIMAGE2:-scratch} as content2
FROM ${BASEIMAGE:-huggla/base:$TAG} as base
FROM huggla/build:$TAG as build
FROM ${BASEIMAGE:-huggla/base:$TAG} as image
COPY --from=build /imagefs /
#-----------------------------------------

FROM huggla/postgres-alpine:20180921-edge as stage1
FROM huggla/alpine-slim:20180921-edge as stage2

COPY --from=stage1 /usr/local/bin/pg_dump* /usr/local/bin/pg_restore /rootfs/usr/local/bin/
COPY --from=stage1 /usr/local/lib/* /rootfs/usr/lib/
COPY --from=stage1 /usr/lib/libldap* /usr/lib/liblber* /usr/lib/libsasl2* /usr/lib/libpq* /rootfs/usr/lib/
COPY ./rootfs /rootfs

RUN apk --no-cache add libressl2.7-libssl \
 && tar -cvp -f /apks-files.tar $(apk --no-cache --quiet manifest libressl2.7-libcrypto libressl2.7-libssl | awk -F "  " '{print $2;}') \
 && tar -xvp -f /apks-files.tar -C /rootfs/

FROM huggla/backup-alpine:20180921-edge

COPY --from=stage2 /rootfs /

ENV VAR_LINUX_USER="postgres" \
    VAR_PORT="5432" \
    VAR_FORMAT="directory" \
    VAR_JOBS="1" \
    VAR_COMPRESS="6" \
    VAR_DUMP_GLOBALS="yes"

USER starter

ONBUILD USER root
