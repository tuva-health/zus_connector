select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(class_code as {{ dbt.type_string() }}) as class_code
    , cast(class_display as {{ dbt.type_string() }}) as class_display
    , cast(encounter_type_id as {{ dbt.type_string() }}) as encounter_type_id
    , cast(subject_patient_id as {{ dbt.type_string() }}) as subject_patient_id
    , cast(period_start as {{ dbt.type_timestamp() }}) as period_start
    , cast(period_end as {{ dbt.type_timestamp() }}) as period_end
    , cast(length_minutes as {{ dbt.type_int() }}) as length_minutes
    , cast(encounter_hospitalization_discharge_disposition_id as {{ dbt.type_string() }}) as encounter_hospitalization_discharge_disposition_id
    , cast(location_id as {{ dbt.type_string() }}) as location_id
    , cast(service_provider_organization_id as {{ dbt.type_string() }}) as service_provider_organization_id
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(upid as {{ dbt.type_string() }}) as upid
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
from {{ source('zus_raw', 'encounter') }}
