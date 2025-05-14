select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(medication_concept_id as {{ dbt.type_string() }}) as medication_concept_id
    , cast(dosage_id as {{ dbt.type_string() }}) as dosage_id
    , cast(code_ndc as {{ dbt.type_string() }}) as code_ndc
    , cast(code_rxnorm as {{ dbt.type_string() }}) as code_rxnorm
    , cast(code_display as {{ dbt.type_string() }}) as code_display
    , cast(subject_patient_id as {{ dbt.type_string() }}) as subject_patient_id
    , cast(context_encounter_id as {{ dbt.type_string() }}) as context_encounter_id
    , cast(effective_start as {{ dbt.type_timestamp() }}) as effective_start
    , cast(effective_end as {{ dbt.type_timestamp() }}) as effective_end
    , cast(date_asserted as {{ dbt.type_timestamp() }}) as date_asserted
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(upid as {{ dbt.type_string() }}) as upid
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
    , cast(data_source as {{ dbt.type_string() }}) as data_source
from {{ source('zus_raw', 'medication_statement') }}
