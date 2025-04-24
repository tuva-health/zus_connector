select
    condition_category_id
    , system
    , code
    , display
from {{ source('zus_raw', 'condition_category_coding') }}