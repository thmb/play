# syntax=docker/dockerfile:1

FROM apache/airflow:slim-2.7.2-python3.11

USER airflow

RUN pip install --no-cache-dir \
    apache-airflow-providers-airbyte[http] \
    apache-airflow-providers-airbyte \
    apache-airflow-providers-ssh

COPY ./dags/ ${AIRFLOW_HOME}/dags/
COPY ./plugins/ ${AIRFLOW_HOME}/plugins/

# custom configuration
LABEL org.opencontainers.image.source=https://github.com/storglobal/cmoc-analytics
LABEL org.opencontainers.image.description="Custom Airflow with SSH and Airbyte"
LABEL org.opencontainers.image.licenses=MIT