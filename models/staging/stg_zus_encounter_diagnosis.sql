select
    cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(condition_id as {{ dbt.type_string() }}) as condition_id
    , cast(rank as {{ dbt.type_int() }}) as rank
    , cast(use_code as {{ dbt.type_string() }}) as use_code
from {{ source('zus_raw', 'encounter_diagnosis') }}
