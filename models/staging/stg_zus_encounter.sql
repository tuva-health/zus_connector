select
    id
    , version
    , last_updated
    , status
    , class_code
    , class_display
    , encounter_type_id
    , subject_patient_id
    , period_start
    , period_end
    , length_minutes
    , encounter_hospitalization_discharge_disposition_id
    , location_id
    , service_provider_organization_id
    , builder_id
    , upid
    , created_at
    , resource_json
from {{ source('zus_raw', 'encounter') }}
