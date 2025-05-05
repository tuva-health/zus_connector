select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(clinical_status as {{ dbt.type_string() }}) as clinical_status
    , cast(verification_status as {{ dbt.type_string() }}) as verification_status
    , cast(condition_category_id as {{ dbt.type_string() }}) as condition_category_id
    , cast(condition_code_id as {{ dbt.type_string() }}) as condition_code_id
    , cast(code_cci as {{ dbt.type_string() }}) as code_cci
    , cast(code_ccs as {{ dbt.type_string() }}) as code_ccs
    , cast(code_hcc as {{ dbt.type_string() }}) as code_hcc
    , cast(code_icd10cm as {{ dbt.type_string() }}) as code_icd10cm
    , cast(code_snomed as {{ dbt.type_string() }}) as code_snomed
    , cast(code_display as {{ dbt.type_string() }}) as code_display
    , cast(category_loinc as {{ dbt.type_string() }}) as category_loinc
    , cast(subject_patient_id as {{ dbt.type_string() }}) as subject_patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(onset as {{ dbt.type_timestamp() }}) as onset
    , cast(abatement as {{ dbt.type_timestamp() }}) as abatement
    , cast(recorded_date as {{ dbt.type_timestamp() }}) as recorded_date
    , cast(recorder_practitioner_id as {{ dbt.type_string() }}) as recorder_practitioner_id
    , cast(asserter_practitioner_id as {{ dbt.type_string() }}) as asserter_practitioner_id
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(upid as {{ dbt.type_string() }}) as upid
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
    , cast('Zus' as {{ dbt.type_string() }}) as data_source
from { source('zus_raw', 'condition') }}
