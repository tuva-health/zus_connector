select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(display as {{ dbt.type_string() }}) as display
from {{ source('zus_raw', 'encounter_type') }}
