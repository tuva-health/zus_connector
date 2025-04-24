select
    id
    , display
from {{ source('zus_raw', 'location_type') }}
