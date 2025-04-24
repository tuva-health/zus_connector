select
    encounter_participant_type_id
    , system
    , code
    , display
from {{ source('zus_raw', 'encounter_participant_type_coding') }}
