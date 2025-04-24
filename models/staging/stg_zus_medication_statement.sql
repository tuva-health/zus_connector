select
    id
    , version
    , last_updated
    , status
    , medication_concept_id
    , code_ndc
    , code_display
    , subject_patient_id
    , context_encounter_id
    , effective_start
    , effective_end
    , date_asserted
    , builder_id
    , upid
    , created_at
    , resource_json
    , data_source
from {{ source('zus_raw', 'medication_statement') }}
