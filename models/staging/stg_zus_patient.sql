select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(version as {{ dbt.type_int() }}) as version
    , cast(last_updated as {{ dbt.type_timestamp() }}) as last_updated
    , cast(active as {{ dbt.type_int() }}) as active
    , cast(gender as {{ dbt.type_string() }}) as gender
    , cast(birth_date as date) as birth_date
    , cast(ethnicity as {{ dbt.type_string() }}) as ethnicity
    , cast(race as {{ dbt.type_string() }}) as race
    , cast(deceased as {{ dbt.type_int() }}) as deceased
    , cast(deceased_datetime as {{ dbt.type_timestamp() }}) as deceased_datetime
    , cast(marital_status as {{ dbt.type_string() }}) as marital_status
    , cast(marital_status_display as {{ dbt.type_string() }}) as marital_status_display
    , cast(managing_organization_id as {{ dbt.type_string() }}) as managing_organization_id
    , cast(name_family as {{ dbt.type_string() }}) as name_family
    , cast(name_given_1 as {{ dbt.type_string() }}) as name_given_1
    , cast(name_given_2 as {{ dbt.type_string() }}) as name_given_2
    , cast(builder_id as {{ dbt.type_string() }}) as builder_id
    , cast(upid as {{ dbt.type_string() }}) as upid
    , cast(created_at as {{ dbt.type_timestamp() }}) as created_at
    , cast(resource_json as {{ dbt.type_string() }}) as resource_json
    , cast(data_source as {{ dbt.type_string() }}) as data_source
from {{ source('zus_raw', 'patient') }}
