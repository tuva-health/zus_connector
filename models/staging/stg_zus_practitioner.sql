select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(identifier_npi as {{ dbt.type_string() }}) as identifier_npi
    , cast(name_family as {{ dbt.type_string() }}) as name_family
    , cast(name_given_1 as {{ dbt.type_string() }}) as name_given_1
    , cast(name_given_2 as {{ dbt.type_string() }}) as name_given_2
    , cast(address_line_1 as {{ dbt.type_string() }}) as address_line_1
    , cast(address_line_2 as {{ dbt.type_string() }}) as address_line_2
    , cast(address_city as {{ dbt.type_string() }}) as address_city
    , cast(address_state as {{ dbt.type_string() }}) as address_state
    , cast(address_postal_code as {{ dbt.type_string() }}) as address_postal_code
    , cast(practitioner_qualification_id as {{ dbt.type_string() }}) as practitioner_qualification_id
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
    , cast(data_source as {{ dbt.type_string() }}) as data_source
from {{ source('zus_raw', 'practitioner') }}
