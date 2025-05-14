with base as (
    select
        zp.upid as person_id
        , zp.id as patient_id
        , zp.name_given_1 as first_name
        , zp.name_family as last_name
        , zp.gender as sex
        , zp.race
        , zp.birth_date
        , null as social_security_number
        , zpa.line_1 as address
        , zpa.city
        , zpa.state
        , zpa.postal_code as zip_code
        , deceased_datetime as death_date
        , deceased = 1 as death_flag
        , null as county
        , null as latitude
        , null as longitude
        , null as phone
        , 'zus' as data_source
    from {{ ref('stg_zus_patient') }} as zp
    left outer join {{ ref('stg_zus_patient_address') }} as zpa
        on zp.id = zpa.patient_id
)

select
      cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(first_name as {{ dbt.type_string() }}) as first_name
    , cast(last_name as {{ dbt.type_string() }}) as last_name
    , cast(sex as {{ dbt.type_string() }}) as sex
    , cast(race as {{ dbt.type_string() }}) as race
    , cast(birth_date as date) as birth_date
    , cast(death_date as date) as death_date
    , cast(death_flag as {{ dbt.type_int() }}) as death_flag
    , cast(social_security_number as {{ dbt.type_string() }}) as social_security_number
    , cast(address as {{ dbt.type_string() }}) as address
    , cast(city as {{ dbt.type_string() }}) as city
    , cast(state as {{ dbt.type_string() }}) as state
    , cast(zip_code as {{ dbt.type_string() }}) as zip_code
    , cast(county as {{ dbt.type_string() }}) as county
    , cast(latitude as {{ dbt.type_float() }}) as latitude
    , cast(longitude as {{ dbt.type_float() }}) as longitude
    , cast(phone as {{ dbt.type_string() }}) as phone
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from base
