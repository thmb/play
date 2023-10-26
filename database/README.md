# [POSTGRES](https://www.postgresql.org)

The database management system is very versatile and can be installed in several operationg systems using native package managers. Another alternative is to use offcial Docker images to run localy in isolation. For the purpose of this project, we will use StackGres, an open-source, full-stack Postgres platform also available as Helm Chart.

## SETUP

```console
helm install --create-namespace --namespace stackgres stackgres-operator --set-string adminui.service.type=LoadBalancer https://stackgres.io/downloads/stackgres-k8s/stackgres/latest/helm/stackgres-operator.tgz
```