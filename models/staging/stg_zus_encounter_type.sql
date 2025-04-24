select
    id
    , display
from {{ source('zus_raw', 'encounter_type') }}
