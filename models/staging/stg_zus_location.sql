select
    id
    , version
    , last_updated
    , name
    , mode
    , location_type_id
    , address_line_1
    , address_line_2
    , address_city
    , address_state
    , address_postal_code
    , location_physical_type_id
    , builder_id
    , created_at
    , resource_json
from {{ source('zus_raw', 'location') }}
