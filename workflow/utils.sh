
#!/bin/bash

host="${AIRFLOW_HOST:-localhost}"
port="${AIRFLOW_PORT:-8080}"

username="${AIRFLOW_USER:-admin}"
password="${AIRFLOW_PASS:-admin}"

hostname="http://$host:$port/api/v1"
basic_auth="Authorization: Basic $(echo -ne $username:$password | base64)"
json_content="Content-Type: application/json"


function create_connection {
	local specification="$1"

	local response=$(curl --request POST "$hostname/connections" \
		--header "$basic_auth" --header "$json_content" \
		--data "@$specification" --silent)

	local id=$(echo $response | jq -r '.connection_id')
	local type=$(echo $response | jq -r '.conn_type')
	local host=$(echo $response | jq -r '.host')

	if [[ "$id" != "null" ]]
	then
		echo "Connection $id [$type] created with host: $host"
	else
		local title=$(echo $response | jq -r '.title')
		echo "ERROR: connection $(cat $specification) not created due to: $title"
	fi
}


function create_variable {
	local variable=$(jq --null-input \
		--arg key "$1" --arg value "$2" \
		'{"key": $key, "value": $value}')

 	local response=$(curl --request POST "$hostname/variables" \
		--header "$basic_auth" --header "$json_content" \
		--data "${variable[@]}" --silent)

	local key=$(echo $response | jq -r '.key')
	local value=$(echo $response | jq -r '.value')

	if [[ "$key" != "null" ]]
	then
		echo "Variable $key created with value: $value"
	else
		local title=$(echo $response | jq -r '.title')
		echo "ERROR: variable $variable not created due to: $title"
	fi
}


function configure_connection {
	local specification="$1"

	local id=$(cat $specification | jq -r '.connection_id')
	local type=$(cat $specification | jq -r '.conn_type')
	local login=$(cat $specification | jq -r '.login')
	local password=$(cat $specification | jq -r '.password')
	local host=$(cat $specification | jq -r '.host')
	local port=$(cat $specification | jq -r '.port')

	local key="AIRFLOW_CONN_${id^^}"
	local value="'$type://$login:$password@$host:$port'"

	echo "$key=$value" >> "/etc/environment"

	echo "Connection $id [$type] set up as: $value"
}


function configure_variable {
	local label="${1^^}"
	local key="AIRFLOW_VAR_$label"
	local value="'$2'"

	echo "$key=$value" >> "/etc/environment"

	echo "Variable $label set up as: $value"
}
