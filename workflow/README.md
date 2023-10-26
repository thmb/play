# [AIRFLOW](https://airflow.apache.org)

[Helm Chart for Apache Airflow](https://airflow.apache.org/docs/helm-chart/stable/index.html)
bootstraps an Airflow deployment on a Kubernetes cluster using the Helm package manager.

Alternative installation on local machine is also possible via [PyPI](https://airflow.apache.org/docs/apache-airflow/stable/installation/installing-from-pypi.html).

## CONFIG

## DAGS

## SETUP

```console
helm repo add airflow https://airflow.apache.org
helm upgrade --install airflow airflow/airflow # --namespace airflow --create-namespace
```

## CLI (Alternative)

```console
airflow connections add 'ssh' --conn-uri 'ssh://thiago:8462@airbyte-proxy:22'

airflow connections add 'airbyte' --conn-uri 'airbyte://airbyte:airbyte@airbyte-proxy:8000'
```