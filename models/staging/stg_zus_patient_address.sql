with base as (
    select
        patient_id
        , line_1
        , line_2
        , city
        , state
        , postal_code
    from {{ source('zus_raw', 'patient_address') }}
    -- Zus doesn't give information on the most up-to-date address
    -- and because we want the grain of patient / address to be 1:1,
    -- we have this in place as a safeguard for downstream consumption.
    qualify row_number() over (
        partition by patient_id
        order by line_1, line_2, city, state, postal_code
    ) = 1
)

final as (
    select
        cast(patient_id as {{ dbt.type_string() }}) as patient_id
        , cast(line_1 as {{ dbt.type_string() }}) as line_1
        , cast(line_2 as {{ dbt.type_string() }}) as line_2
        , cast(city as {{ dbt.type_string() }}) as city
        , cast(state as {{ dbt.type_string() }}) as state
        , cast(postal_code as {{ dbt.type_string() }}) as postal_code
    from base
)
