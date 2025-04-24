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
