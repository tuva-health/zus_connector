select
    cast(encounter_participant_type_id as {{ dbt.type_string() }}) as encounter_participant_type_id
    , cast(system as {{ dbt.type_string() }}) as system
    , cast(code as {{ dbt.type_string() }}) as code
    , cast(display as {{ dbt.type_string() }}) as display
from {{ source('zus_raw', 'encounter_participant_type_coding') }}
