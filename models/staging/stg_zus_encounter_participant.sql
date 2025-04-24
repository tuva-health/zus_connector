select
    encounter_id
    , encounter_participant_type_id
    , period_start
    , period_end
    , individual_practitioner_id
from {{ source('zus_raw', 'encounter_participant') }}
