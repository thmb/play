TARGET = "redshift"
VERSION = "1.5.0"

RUN = f"docker run --network=host --mount type=bind,source=/opt/analytics/transform,target=/usr/app --mount type=bind,source=/opt/analytics/transform/profiles.yml,target=/root/.dbt/profiles.yml ghcr.io/dbt-labs/dbt-{TARGET}:{VERSION} run"

SNAPSHOT = f"docker run --network=host --mount type=bind,source=/opt/analytics/transform,target=/usr/app --mount type=bind,source=/opt/analytics/transform/profiles.yml,target=/root/.dbt/profiles.yml ghcr.io/dbt-labs/dbt-{TARGET}:{VERSION} snapshot"

def run(select: str) -> str:
    return RUN + f" --select {select}" if len(select) else RUN

def snapshot(select: str) -> str:
    return SNAPSHOT + f" --select {select}" if len(select) else SNAPSHOT
