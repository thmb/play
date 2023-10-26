#!/bin/bash

source ./utils.sh


variables="./config/variables/airbyte.json"

keys=( $(cat "$variables" | jq -r '. | keys[]') )

for key in "${keys[@]}"
do
    value="$(jq -r ".$key" $variables)"
    create_variable "$key" "$value"
done

create_connection "./config/connections/airbyte.json"

create_connection "./config/connections/ssh.json"


exit 0 # success