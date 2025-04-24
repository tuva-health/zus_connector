select
    id
    , version
    , last_updated
    , clinical_status
    , verification_status
    , condition_category_id
    , condition_code_id
    , code_cci
    , code_ccs
    , code_hcc
    , code_icd10cm
    , code_snomed
    , code_display
    , category_loinc
    , subject_patient_id
    , encounter_id
    , onset
    , abatement
    , recorded_date
    , recorder_practitioner_id
    , asserter_practitioner_id
    , builder_id
    , upid
    , created_at
    , resource_json
    , data_source
from {{ source('zus_raw', 'condition') }}