# [DBT](https://www.getdbt.com)

[Quickstart for dbt Core](https://docs.getdbt.com/quickstarts/manual-install?step=1) from a manual install.

[Alternative quickstarts](https://docs.getdbt.com/quickstarts) include Redshift, BigQuery and Snowflake, among others.

## ANALYSES

## MACROS

## MODELS

## SEEDS

## SNAPSHOTS

## TESTS

## SETUP

### CREATE A PROJECT

docker run --rm -it -v $(pwd):/usr/src python bash

cd /usr/src

pip install dbt-core dbt-postgres

dbt init <project_name>


### RUN DBT COMMANDS

1. Create a Github token on menu: User -> Settings -> Developer Settings -> Personal Access Token

2. Save the token on .bashrc file as GITHUB_TOKEN variable and source the file to load the value.

3. Login the Docker demon to Github Container Registry to pull the DBT release image:

```console
echo "$GITHUB_TOKEN" | docker login ghcr.io -u thmb --password-stdin
```

4. Using Docker, pull latest stable DBT (driver) container image from:

https://github.com/dbt-labs/dbt-core/pkgs/container/dbt-postgres

```console
docker pull ghcr.io/dbt-labs/dbt-postgres:1.6.3
```

1. Run the image with desired command, as example

```console
docker run \
--user $(id -u):$(id -g) \
--network=host \
--mount type=bind,source=$(pwd),target=/usr/app \
--mount type=bind,source=$(pwd)/profiles.yml,target=/root/.dbt/profiles.yml \
ghcr.io/dbt-labs/dbt-postgres:1.6.3 \
debug
```


