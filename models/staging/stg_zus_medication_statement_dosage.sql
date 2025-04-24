select
    medication_statement_id
    , dosage_id
from {{ source('zus_raw', 'medication_statement_dosage') }}