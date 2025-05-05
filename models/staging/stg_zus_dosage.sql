select
    cast(id as {{ dbt.type_string() }}) as id
    , cast(display as {{ dbt.type_string() }}) as display
    , cast(timing_repeat_period_unit as {{ dbt.type_string() }}) as timing_repeat_period_unit
    , cast(timing_repeat_bounds_start as {{ dbt.type_timestamp() }}) as timing_repeat_bounds_start
    , cast(timing_repeat_bounds_end as {{ dbt.type_timestamp() }}) as timing_repeat_bounds_end
    , cast(timing_period as {{ dbt.type_numeric() }}) as timing_period
    , cast(route_concept_id as {{ dbt.type_string() }}) as route_concept_id
    , cast(dosage_method_id as {{ dbt.type_string() }}) as dosage_method_id
    , cast(additional_instruction_display as {{ dbt.type_string() }}) as additional_instruction_display
    , cast(dose_quantity_unit as {{ dbt.type_string() }}) as dose_quantity_unit
    , cast(dose_quantity_value as {{ dbt.type_numeric() }}) as dose_quantity_value
from {{ source('zus_raw', 'dosage') }}