FROM huggla/postgres-alpine:20180627-edge as pg
FROM huggla/backup-alpine

USER root

COPY --from=pg /usr/local/bin/pg_dump* /usr/local/bin/
COPY --from=pg /usr/local/bin/pg_restore /usr/local/bin/
COPY --from=pg /usr/local/lib /usr/local/lib
COPY --from=pg /usr/lib/libldap* /usr/local/lib/
COPY --from=pg /usr/lib/liblber* /usr/local/lib/
COPY --from=pg /usr/lib/libsasl2* /usr/local/lib/
COPY ./bin /usr/local/bin

RUN apk --no-cache add libressl2.7-libcrypto libressl2.7-libssl

ENV VAR_LINUX_USER="postgres" \
    VAR_PORT="5432" \
    VAR_FORMAT="directory" \
    VAR_JOBS="1" \
    VAR_COMPRESS="6" \
    VAR_DUMP_GLOBALS="yes"

USER starter
