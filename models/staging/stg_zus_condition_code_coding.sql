select
    cast(condition_category_id as {{ dbt.type_string() }}) as condition_category_id
    , cast(system as {{ dbt.type_string() }}) as system
    , cast(code as {{ dbt.type_string() }}) as code
    , cast(display as {{ dbt.type_string() }}) as display
from {{ source('zus_raw', 'condition_code_coding') }}
