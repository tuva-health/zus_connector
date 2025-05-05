select
    cast(medication_statement_id as {{ dbt.type_string() }}) as medication_statement_id
    , cast(dosage_id as {{ dbt.type_string() }}) as dosage_id
from {{ source('zus_raw', 'medication_statement_dosage') }}
