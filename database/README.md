# [POSTGRES](https://www.postgresql.org)

PostgreSQL is a powerful, open source object-relational database system with a vibrant community and active development that has earned it a strong reputation for reliability, feature robustness, and performance. The database management system (DBMS) is very versatile and can be installed natively in several operationg systems using package managers and an official Docker image is also available to run localy in isolation.

For the purpose of this project, we will run PostgreSQL the Kubernetes way using [CloudNativePG](https://cloudnative-pg.io) as an open source operator that covers the full lifecycle of a highly available PostgreSQL database cluster with a primary/standby architecture, using native streaming replication and running in private, public, hybrid, or multi-cloud environments.

## SETUP

### Operator

Installation and upgrade [instructions](https://cloudnative-pg.io/documentation/1.18/installation_upgrade) covers three different approaches:

- Appling a YAML manifest via `kubectl`;
- Using the `cnpg` plugin for `kubectl`;
- Using the provided Helm chart.

In order to be consistent with the rest of this project we will use the chart alternative to install as follows:

```console
helm repo add cnpg https://cloudnative-pg.github.io/charts
helm install postgres --namespace data --create-namespace cnpg/cloudnative-pg
```

**NOTE**: supports only the latest point release of the CloudNativePG operator.

### Cluster

The (default) cluster setup uses custom [PostGIS](https://postgis.net) image with the following properties:

- instances: 1 (no replica)
- database: application
- username: restapi
- password: Pa$$w0rD

To install it, we just need to apply the `cluster.yaml` manifest file as follows:

```console
kubectl apply -f postgres.yaml
```