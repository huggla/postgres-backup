FROM huggla/postgres-alpine as pg
FROM huggla/alpine

USER root

COPY --from=pg /usr/local/bin/pg_dump* /usr/local/bin/
COPY --from=pg /usr/local/lib /usr/local/lib
COPY --from=pg /usr/lib/libldap* /usr/local/lib/
COPY --from=pg /usr/lib/liblber* /usr/local/lib/
COPY --from=pg /usr/lib/libsasl2* /usr/local/lib/

ENV VAR_cron_weekdays="0 21 * * 1-5" \
    VAR_cron_weekly="0 19 * * 5" \
    VAR_cron_monthly="0 17 1 * *" \
    VAR_backup_weekdays=
