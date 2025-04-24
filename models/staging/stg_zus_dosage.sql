select
    id
    , display
    , timing_repeat_period_unit
    , timing_repeat_bounds_start
    , timing_repeat_bounds_end
    , timing_period
    , route_concept_id
    , dosage_method_id
    , additional_instruction_display
    , dose_quantity_unit
    , dose_quantity_value
from {{ source('zus_raw', 'dosage') }}