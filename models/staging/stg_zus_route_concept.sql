select
    id
    , display
from {{ source('zus_raw', 'route_concept') }}
