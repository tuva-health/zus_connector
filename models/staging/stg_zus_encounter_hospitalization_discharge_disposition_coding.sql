select
    encounter_hospitalization_discharge_disposition_id
    , system
    , code
    , display
from {{ source('zus_raw', 'stg_zus_encounter_hospitalization_discharge_disposition_coding') }}
