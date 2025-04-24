select
      cast(observation_id as {{ dbt.type_string() }} ) as observation_id
    , cast(person_id as {{ dbt.type_string() }} ) as person_id
    , cast(patient_id as {{ dbt.type_string() }} ) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }} ) as encounter_id
    , cast(panel_id as {{ dbt.type_string() }} ) as panel_id
    , cast(observation_date as date) as observation_date
    , cast(observation_type as {{ dbt.type_string() }} ) as observation_type
    , cast(source_code_type as {{ dbt.type_string() }} ) as source_code_type
    , cast(source_code as {{ dbt.type_string() }} ) as source_code
    , cast(source_description as {{ dbt.type_string() }} ) as source_description
    , cast(normalized_code_type as {{ dbt.type_string() }} ) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }} ) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }} ) as normalized_description
    , cast(result as {{ dbt.type_string() }} ) as result
    , cast(source_units as {{ dbt.type_string() }} ) as source_units
    , cast(normalized_units as {{ dbt.type_string() }} ) as normalized_units
    , cast(source_reference_range_low as {{ dbt.type_string() }} ) as source_reference_range_low
    , cast(source_reference_range_high as {{ dbt.type_string() }} ) as source_reference_range_high
    , cast(normalized_reference_range_low as {{ dbt.type_string() }} ) as normalized_reference_range_low
    , cast(normalized_reference_range_high as {{ dbt.type_string() }} ) as normalized_reference_range_high
    , cast(data_source as {{ dbt.type_string() }} ) as data_source
    , cast(file_name as {{ dbt.type_string() }} ) as file_name
    , cast(ingest_datetime as {{ dbt.type_timestamp() }} ) as ingest_datetime
from {{ ref('int_observation') }}
where observation_type != 'laboratory'
