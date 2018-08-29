FROM huggla/postgres-alpine as stage1

COPY ./rootfs /rootfs

RUN mkdir -p /rootfs/usr/local/bin \
 && cp -a /usr/local/bin/pg_dump* /usr/local/bin/pg_restore /rootfs/usr/local/bin/ \
 && cp -a /usr/local/lib /rootfs/usr/local/ \
 && cp -a /usr/lib/libldap* /usr/lib/liblber* /usr/lib/libsasl2* /rootfs/usr/local/lib/ \
 && apk --no-cache add libressl2.7-libcrypto libressl2.7-libssl \
 && tar -cvp -f /installed_files.tar $(apk manifest libressl2.7-libcrypto libressl2.7-libssl | awk -F "  " '{print $2;}') \
 && tar -xvp -f /installed_files.tar -C /rootfs/

FROM huggla/backup-alpine

COPY --from=stage1 /rootfs /

ENV VAR_LINUX_USER="postgres" \
    VAR_PORT="5432" \
    VAR_FORMAT="directory" \
    VAR_JOBS="1" \
    VAR_COMPRESS="6" \
    VAR_DUMP_GLOBALS="yes"

USER starter

ONBUILD USER root
