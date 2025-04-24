select
    encounter_id
    , condition_id
    , rank
    , use_code
from {{ source('zus_raw', 'encounter_diagnosis') }}
