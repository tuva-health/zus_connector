select
    id
    , version
    , last_updated
    , status
    , procedure_code_id
    , code_cpt
    , code_loinc
    , code_snomed
    , code_display
    , subject_patient_id
    , encounter_id
    , performed_start
    , performed_end
    , location_id
    , body_site_concept_id
    , builder_id
    , upid
    , created_at
    , resource_json
    , data_source
from {{ source('zus_raw', 'procedure') }}
