select
      cast(observation_id as {{ dbt.type_string() }}) as lab_result_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(accession_number as {{ dbt.type_string() }}) as accession_number
    , cast(null as {{ dbt.type_string() }}) as source_order_type
    , cast(null as {{ dbt.type_string() }}) as source_order_code
    , cast(null as {{ dbt.type_string() }}) as source_order_description
    , cast(source_code_type as {{ dbt.type_string() }}) as source_component_type
    , cast(source_code as {{ dbt.type_string() }}) as source_component_code
    , cast(source_description as {{ dbt.type_string() }}) as source_component_description
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(result as {{ dbt.type_string() }}) as result
    , cast(result_date as {{ dbt.type_timestamp() }}) as result_datetime
    , cast(collection_date as {{ dbt.type_timestamp() }}) as collection_datetime
    , cast(source_units as {{ dbt.type_string() }}) as source_units
    , cast(normalized_units as {{ dbt.type_string() }}) as normalized_units
    , cast(source_reference_range_low as {{ dbt.type_string() }}) as source_reference_range_low
    , cast(source_reference_range_high as {{ dbt.type_string() }}) as source_reference_range_high
    , cast(normalized_reference_range_low as {{ dbt.type_string() }}) as normalized_reference_range_low
    , cast(normalized_reference_range_high as {{ dbt.type_string() }}) as normalized_reference_range_high
    , cast(source_abnormal_flag as {{ dbt.type_string() }}) as source_abnormal_code
    , cast(normalized_abnormal_flag as {{ dbt.type_string() }}) as normalized_abnormal_code
    , cast(specimen as {{ dbt.type_string() }}) as specimen
    , cast(ordering_practitioner_id as {{ dbt.type_string() }}) as ordering_practitioner_id
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(file_name as {{ dbt.type_string() }}) as file_name
    , cast(ingest_datetime as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('int_observation') }}
where observation_type = 'laboratory'
