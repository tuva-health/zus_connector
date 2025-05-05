select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(name as {{ dbt.type_string() }}) as name
    , cast(mode as {{ dbt.type_string() }}) as mode
    , cast(location_type_id as {{ dbt.type_string() }}) as location_type_id
    , cast(address_line_1 as {{ dbt.type_string() }}) as address_line_1
    , cast(address_line_2 as {{ dbt.type_string() }}) as address_line_2
    , cast(address_city as {{ dbt.type_string() }}) as address_city
    , cast(address_state as {{ dbt.type_string() }}) as address_state
    , cast(address_postal_code as {{ dbt.type_string() }}) as address_postal_code
    , cast(location_physical_type_id as {{ dbt.type_string() }}) as location_physical_type_id
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
from {{ source('zus_raw', 'location') }}
