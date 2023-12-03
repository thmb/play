#!/bin/bash

host="${AIRBYTE_HOST:-localhost}"
port="${AIRBYTE_PORT:-8000}"

username="${AIRBYTE_USER:-airbyte}"
password="${AIRBYTE_PASS:-password}"

hostname="http://$host:$port/api/v1"

basic_auth="Authorization: Basic $(echo -ne $username:$password | base64)"
json_content="Content-Type: application/json"

inherit=""


function infer_type {
	local path="$(echo "$1" | tr '[:upper:]' '[:lower:]')"
	local -n kind="$2"  # use name reference and parameter position

	if [[ "$path" == *"source"* ]]
	then
		kind="source"
	elif [[ "$path" == *"destination"* ]]
	then
		kind="destination"
	else
		kind=""
		echo "Warning: unkown type!"
	fi
}


function fetch_workspace {
	local -n id="$1"  # use name reference and parameter position

	response=$(curl --request POST "$hostname/workspaces/list" \
		--header "$basic_auth" --header "$json_content" --silent)

	id=$(echo $response | jq -r '.workspaces' | jq -r '.[0].workspaceId')

	echo "Using workspace id: $id"
}


function update_definition {
	local definition="$1"
	
	infer_type "$definition" type

	response=$(curl --request POST "$hostname/${type}_definitions/update" \
		--header "$basic_auth" --header "$json_content" --data "@$definition" --silent)

	name=$(echo $response | jq -r '.name')
	tag=$(echo $response | jq -r '.dockerImageTag')
	stage=$(echo $response | jq -r '.releaseStage')

	echo "$name $type updated to version $tag [$stage]"
}


function create_definition {
	local workspace_id="$1"
	local specification="$2"
	local -n id="$3"  # use name reference and parameter position

	infer_type $specification type

	specification=$(jq --arg id $workspace_id '.workspaceId=$id' $specification)

	response=$(curl --request POST "$hostname/${type}_definitions/create_custom" \
		--header "$basic_auth" --header "$json_content" --data "$specification" --silent)

	name=$(echo $response | jq -r '.name')
	if [[ "$type" == "source" ]]
	then
		id=$(echo $response | jq -r '.sourceDefinitionId')
	elif [[ "$path" == "destination" ]]
	then
		id=$(echo $response | jq -r '.destinationDefinitionId')
	else
		echo "Warning: unkown definition!"
	fi

	echo "$name definition of type $type created with id: $id"
}


function create_operation {
	local workspace_id="$1"
	local specification="$2"
	local -n id="$3"  # use name reference and parameter position

	specification=$(jq --arg id $workspace_id '.workspaceId=$id' $specification)

	response=$(curl --request POST "$hostname/operations/create" \
		--header "$basic_auth" --header "$json_content" --data "$specification" --silent)

	name=$(echo $response | jq -r '.name')
	id=$(echo $response | jq -r '.operationId')

	echo "$name operation created with id: $id"
}


function create_source {
	local workspace_id="$1"
	local definition_id="$2"
	local specification="$3"
	local -n id="$4"  # use name reference and parameter position

	specification=$(jq --arg id $workspace_id '.workspaceId=$id' $specification)
	if [[ "$definition_id" != "" ]]
	then
		specification=$(echo $specification | jq --arg id $definition_id '.sourceDefinitionId=$id')
	fi

	response=$(curl --request POST "$hostname/sources/create" \
		--header "$basic_auth" --header "$json_content" --data "$specification" --silent)

	name=$(echo $response | jq -r '.name')
	type=$(echo $response | jq -r '.sourceName')
	id=$(echo $response | jq -r '.sourceId')

	echo "$name source of type $type created with id: $id"
}


function create_destination {
	local workspace_id="$1"
	local definition_id="$2"
	local specification="$3"
	local -n id="$4"  # use name reference and parameter position

	specification=$(jq --arg id $workspace_id '.workspaceId=$id' $specification)
	if [[ "$definition_id" != "" ]]
	then
		specification=$(echo $specification | jq --arg id $definition_id '.destinationDefinitionId=$id')
	fi

	response=$(curl --request POST "$hostname/destinations/create" \
		--header "$basic_auth" --header "$json_content" --data "$specification" --silent)

	name=$(echo $response | jq -r '.name')
	type=$(echo $response | jq -r '.destinationName')
	id=$(echo $response | jq -r '.destinationId')

	echo "$name destination of type $type created with id: $id"
}


function create_connection {
	local workspace_id="$1"
	local source_id="$2"
	local destination_id="$3"
	local operation_id="$4"
	local specification="$5"

	specification=$(jq --arg id $workspace_id '.workspaceId=$id' $specification)
	specification=$(echo $specification | jq --arg id $source_id '.sourceId=$id')
	specification=$(echo $specification | jq --arg id $destination_id '.destinationId=$id')
	specification=$(echo $specification | jq --arg id $operation_id '.operationIds += [$id]')

	response=$(curl --request POST "$hostname/connections/create" \
		--header "$basic_auth" --header "$json_content" --data "$specification" --silent)

	name=$(echo $response | jq -r '.name')
	id=$(echo $response | jq -r '.connectionId')

	echo "$name connection created with id: $id"
}
