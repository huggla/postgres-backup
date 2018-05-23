FROM huggla/postgres-alpine as pg
FROM alpine:3.7

USER root

COPY --from=pg /usr/local/bin/pg_dump* /usr/local/bin/
COPY --from=pg /usr/local/lib/libecpg* /usr/local/lib/
COPY --from=pg /usr/local/lib/libpgtypes* /usr/local/lib/
