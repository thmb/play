#!/bin/bash

source ./utils.sh


update_definition "./sources/postgres.json"
update_definition "./destinations/postgres.json"

fetch_workspace workspace_id

create_operation "${workspace_id}" \
    "./connections/normalization.json" normalization_id

create_source "${workspace_id}" "${inherit}" \
    "./sources/application.json" application_id

create_destination "${workspace_id}" "${inherit}" \
    "./destinations/warehouse.json" warehouse_id

create_connection "${workspace_id}" "${application_id}" "${warehouse_id}" "${normalization_id}" \
    "./connections/analytics.json"

exit 0 # success


# ========== CUSTOM SOURCE OR DESTINATION ==========

# create_definition "${workspace_id}" \
#     "./connectors/name/definition.json" definition_id

# create_[source|destination] "${workspace_id}" "${definition_id}" \
#     "./[source|destination].json" [source|destination]_id