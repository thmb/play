import base64
import requests

from airflow.models import Variable

AIRBYTE_HOST = Variable.get("AIRBYTE_HOST", "pipeline-airbyte-webapp-svc")
AIRBYTE_PORT = Variable.get("AIRBYTE_PORT", 80)
AIRBYTE_USER = Variable.get("AIRBYTE_USER", "airbyte")
AIRBYTE_PASS = Variable.get("AIRBYTE_PASS", "password")

CREDENTIAL = f"{AIRBYTE_USER}:{AIRBYTE_PASS}"
WORKSPACES = f"http://{AIRBYTE_HOST}:{AIRBYTE_PORT}/api/v1/workspaces/list"
CONNECTIONS = f"http://{AIRBYTE_HOST}:{AIRBYTE_PORT}/api/v1/connections/list"

def connection(feature: str, source: str) -> str:
    """Fetch Airbyte connection unique identifier."""

    authorization = { "Authorization": "Basic " + base64.b64encode(CREDENTIAL.encode()).decode() }
    
    response = requests.post(WORKSPACES, headers=authorization).json()
    workspace = { "workspaceId": response["workspaces"][0]["workspaceId"] } # single workspace
    
    response = requests.post(CONNECTIONS, json=workspace, headers=authorization).json()
    connections = list(response.get("connections", '[]'))

    feature = feature.lower()
    source = source.lower()
    for connection in connections:
        name = connection.get("name", "").strip().lower()
        if feature in name and source in name:
            return connection.get("connectionId", "")
    
    return ""
