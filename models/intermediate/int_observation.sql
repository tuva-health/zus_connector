with base as (
    select
        id as observation_id
        , upid as person_id
        , subject_patient_id as patient_id
        , encounter_id
        , null as panel_id
        , {{ try_to_cast_date(effective_start) }} as observation_date
        , {{ try_to_cast_date(effective_end) }} as collected_date
        , {{ try_to_cast_date(effective_end) }} as result_date
        , category as observation_type
        , case
            when code_loinc is not null then 'loinc'
            when code_snomed is not null then 'snomed-ct'
            when code_cpt is not null then 'hcpcs'
            when code_act is not null then 'actcode'
        end as source_code_type
        , code_display as source_description
        , null as accession_number
        , status
        , 
        , case 
            when source_code_type = 'loinc' then code_loinc
            when source_code_type = 'snomed' then code_snomed
            when source_code_type = 'hcpcs level 1' then code_cpt
            when source_code_type = 'actcode' then code_act
        end as source_code
        , null as normalized_code_type
        , null as normalized_code
        , null as normalized_description
        , null as normalized_component
        , coalesce(value_quantity_value, value_integer, value_string) as result
        , value_quantity_unit as source_units
        , reference_range_low as source_reference_range_low
        , reference_range_high as source_reference_range_high
        , null as normalized_units
        , null as normalized_reference_range_low
        , null as normalized_reference_range_high
        , null as source_abnormal_flag
        , null as normalized_abnormal_flag
        , null as specimen
        , null as ordering_practitioner_id
        , 'zus' as data_source
        , null as file_name
        , null as ingest_datetime
    from {{ ref('stg_zus_observation') }}
)

select
      cast(observation_id as {{ dbt.type_string() }}) as observation_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(panel_id as {{ dbt.type_string() }}) as panel_id
    , cast(observation_date as date) as observation_date
    , cast(result_date as date) as result_date
    , cast(collection_date as date) as collection_date
    , cast(observation_type as {{ dbt.type_string() }}) as observation_type
    , cast(source_code_type as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(source_description as {{ dbt.type_string() }}) as source_description
    , cast(normalized_code_type as {{ dbt.type_string() }}) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }}) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }}) as normalized_description
    , cast(result as {{ dbt.type_string() }}) as result
    , cast(source_units as {{ dbt.type_string() }}) as source_units
    , cast(normalized_units as {{ dbt.type_string() }}) as normalized_units
    , cast(source_reference_range_low as {{ dbt.type_string() }}) as source_reference_range_low
    , cast(source_reference_range_high as {{ dbt.type_string() }}) as source_reference_range_high
    , cast(normalized_reference_range_low as {{ dbt.type_string() }}) as normalized_reference_range_low
    , cast(normalized_reference_range_high as {{ dbt.type_string() }}) as normalized_reference_range_high
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(file_name as {{ dbt.type_string() }}) as file_name
    , cast(ingest_datetime as {{ dbt.type_timestamp() }}) as ingest_datetime
    , cast(accession_number as {{ dbt.type_string() }}) as accession_number
    , cast(source_component as {{ dbt.type_string() }}) as source_component
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(source_abnormal_flag as {{ dbt.type_int() }}) as source_abnormal_flag
    , cast(normalized_abnormal_flag as {{ dbt.type_int() }}) as normalized_abnormal_flag
    , cast(specimen as {{ dbt.type_string() }}) as specimen
    , cast(ordering_practitioner_id as {{ dbt.type_string() }}) as ordering_practitioner_id
from base
