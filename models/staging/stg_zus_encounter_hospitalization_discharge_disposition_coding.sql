select
    cast(encounter_hospitalization_discharge_disposition_id as {{ dbt.type_string() }})
        as encounter_hospitalization_discharge_disposition_id
    , cast(system as {{ dbt.type_string() }}) as system
    , cast(code as {{ dbt.type_string() }}) as code
    , cast(display as {{ dbt.type_string() }}) as display
from {{ source('zus_raw', 'encounter_hospitalization_discharge_disposition_coding') }}
