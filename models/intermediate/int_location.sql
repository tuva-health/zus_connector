with base as (
    select
        zl.id as location_id
        , null as npi
        , name
        , zlt.display as facility_type
        , null as parent_organization
        , address_line_1 as address
        , address_city as city
        , address_state as state
        , address_postal_code as zip_code
        , null as latitude
        , null as longitude
        , 'zus' as data_source
    from {{ ref('stg_zus_location') }} as zl
    left outer join {{ ref('stg_zus_location_type') }} as zlt
        on zl.location_type_id = zlt.id
)

select
      cast(location_id as {{ dbt.type_string() }}) as location_id
    , cast(npi as {{ dbt.type_string() }}) as npi
    , cast(name as {{ dbt.type_string() }}) as name
    , cast(facility_type as {{ dbt.type_string() }}) as facility_type
    , cast(parent_organization as {{ dbt.type_string() }}) as parent_organization
    , cast(address as {{ dbt.type_string() }}) as address
    , cast(city as {{ dbt.type_string() }}) as city
    , cast(state as {{ dbt.type_string() }}) as state
    , cast(zip_code as {{ dbt.type_string() }}) as zip_code
    , cast(latitude as {{ dbt.type_float() }}) as latitude
    , cast(longitude as {{ dbt.type_float() }}) as longitude
    , cast(null as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from base
