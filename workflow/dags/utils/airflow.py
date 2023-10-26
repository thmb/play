from datetime import datetime, timedelta

default_dag_args = {
        "owner": "stor",
        "depends_on_past": False,
        "start_date": datetime(2023, 1, 1),
        "email": ["infra@storglobal.com"],
        "email_on_failure": True,
        "email_on_retry": False,
        "retries": 1,
        "retry_delay": timedelta(minutes=5),
        "schedule_interval": "@daily",  # run once a day at midnight
}