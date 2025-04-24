select
    id
    , display
from {{ source('zus_raw', 'condition_code') }}