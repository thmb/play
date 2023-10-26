from __future__ import annotations

from airflow import DAG
from airflow.providers.airbyte.operators.airbyte import AirbyteTriggerSyncOperator
from airflow.providers.ssh.operators.ssh import SSHOperator

from utils import airflow, airbyte, dbt

dag = DAG(
    dag_id="Sales",
    description="Take snapshot, syncronize stage, run business logic and compile features",
    default_args=airflow.default_dag_args,
    tags=["Salesforce", "SAP"],
    catchup=False,
)

snapshot = SSHOperator(
    task_id="snapshot",
    ssh_conn_id="transform",
    command=dbt.snapshot(""), # no selection
    cmd_timeout=600,  # 10 minutes
    dag=dag,
)

stage_salesforce = AirbyteTriggerSyncOperator(
    task_id="stage_salesforce",
    airbyte_conn_id="pipeline",
    connection_id=airbyte.connection(feature="Sales", source="Salesforce"),
    dag=dag,
)

stage_sap = AirbyteTriggerSyncOperator(
    task_id="stage_sap",
    airbyte_conn_id="pipeline",
    connection_id=airbyte.connection(feature="Sales", source="SAP"),
    dag=dag,
)

business = SSHOperator(
    task_id="business",
    ssh_conn_id="transform",
    command=dbt.run(""), # no selection
    cmd_timeout=600,  # 10 minutes
    dag=dag,
)

feature = SSHOperator(
    task_id="feature",
    ssh_conn_id="transform",
    command=dbt.run(""), # no selection
    cmd_timeout=600,  # 10 minutes
    dag=dag,
)

snapshot >> [stage_salesforce, stage_sap] >> business >> feature
