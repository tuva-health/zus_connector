select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(procedure_code_id as {{ dbt.type_string() }}) as procedure_code_id
    , cast(code_cpt as {{ dbt.type_string() }}) as code_cpt
    , cast(code_loinc as {{ dbt.type_string() }}) as code_loinc
    , cast(code_snomed as {{ dbt.type_string() }}) as code_snomed
    , cast(code_hcpcs as {{ dbt.type_string() }}) as code_hcpcs
    , cast(code_display as {{ dbt.type_string() }}) as code_display
    , cast(subject_patient_id as {{ dbt.type_string() }}) as subject_patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(performed_start as {{ dbt.type_timestamp() }}) as performed_start
    , cast(performed_end as {{ dbt.type_timestamp() }}) as performed_end
    , cast(location_id as {{ dbt.type_string() }}) as location_id
    , cast(body_site_concept_id as {{ dbt.type_string() }}) as body_site_concept_id
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(upid as {{ dbt.type_string() }}) as upid
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
    , cast(data_source as {{ dbt.type_string() }}) as data_source
from {{ source('zus_raw', 'procedure') }}
