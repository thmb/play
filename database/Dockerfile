# syntax=docker/dockerfile:1

# Custom PostgreSQL image that includes PostGIS support.
# Reference settings at: https://hub.docker.com/_/postgres

FROM postgres:16

ENV POSTGIS_MAJOR 3

RUN apt-get update \
    && apt-get install --assume-yes --no-install-recommends \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
    postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5432
