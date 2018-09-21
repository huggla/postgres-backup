FROM huggla/postgres-alpine:20180921-edge as stage1
FROM huggla/alpine-slim:20180921-edge as stage2

COPY --from=stage1 /usr/local/bin/pg_dump* /usr/local/bin/pg_restore /rootfs/usr/local/bin/
COPY --from=stage1 /usr/local/lib /rootfs/usr/local/
COPY --from=stage1 /usr/lib/libldap* /usr/lib/liblber* /usr/lib/libsasl2* /rootfs/usr/local/lib/
COPY ./rootfs /rootfs

RUN tar -cvp -f /apks-files.tar $(apk manifest libressl2.7-libcrypto libressl2.7-libssl | awk -F "  " '{print $2;}') \
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
