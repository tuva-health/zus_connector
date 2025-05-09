select
   cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(encounter_participant_type_id as {{ dbt.type_string() }})
        as encounter_participant_type_id
    , cast(period_start as {{ dbt.type_timestamp() }}) as period_start
    , cast(period_end as {{ dbt.type_timestamp() }}) as period_end
    , cast(individual_practitioner_id as {{ dbt.type_string() }})
        as individual_practitioner_id
from {{ source('zus_raw', 'encounter_participant') }}
