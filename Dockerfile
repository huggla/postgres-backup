FROM huggla/postgres-alpine as pg
FROM huggla/alpine

USER root

COPY --from=pg /usr/local/bin/pg_dump* /usr/local/bin/
COPY --from=pg /usr/local/lib /usr/local/lib
COPY --from=pg /usr/lib/libldap* /usr/local/lib/
COPY --from=pg /usr/lib/liblber* /usr/local/lib/
COPY --from=pg /usr/lib/libsasl2* /usr/local/lib/
COPY ./start /start
COPY ./bin /usr/local/bin

ENV VAR_LINUX_USER="root" \
    VAR_FINAL_COMMAND="/usr/sbin/crond -s -n" \
    VAR_cron_weekdays="0 21 * * 1-5" \
    VAR_cron_weekly="0 19 * * 5" \
    VAR_cron_monthly="0 17 1 * *" \
    VAR_BACKUP_DIR="/pgbackup" \
    VAR_BACKUP_USER="postgres" \
    VAR_DATABASES="postgres" \
    VAR_PORT="5432" \
    VAR_FORMAT="directory" \
    VAR_JOBS="1" \
    VAR_COMPRESS="9" \
    VAR_DUMP_GLOBALS="yes" \
    VAR_weekdays="/bin/date +%a" \
    VAR_weekly="(( $(/bin/date +%d) + 6 ) / 7)" \
    VAR_monthly="/bin/date +%b"

USER starter
