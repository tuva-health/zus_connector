with mapped_data as (
    select
        zc.id as condition_id
        , zc.upid as person_id
        , zc.subject_patient_id as patient_id
        , zc.encounter_id
        , zc.recorded_date
        , zc.onset as onset_date
        , zc.abatement as resolved_date
        , zc.clinical_status as status
        /*
        category_loinc is the condition's category (e.g. problem list item), not its diagnosis,
        so it only feeds condition_type and never the normalized code.
        */
        , case
            when icd10.icd_10_cm is not null then 'icd-10-cm'
            when snomed.snomed_ct is not null then 'snomed-ct'
            end as normalized_code_type
        , coalesce(
            icd10.icd_10_cm
            , snomed.snomed_ct
        ) as normalized_code
        , coalesce(
            icd10.long_description
            , snomed.description
        ) as normalized_description
        , case
            when loinc.loinc = '75326-9' or zc.code_snomed = '55607006' then 'problem'
            when loinc.loinc = '29308-4' or zc.code_snomed = '282291009' then 'diagnosis'
            when zc.code_snomed = '64572001' then 'disease'
          end as condition_type
        , null as condition_rank
    from {{ ref('stg_zus_condition') }} as zc
    left outer join {{ ref('stg_zus_condition_category') }} as zcat
        on zc.condition_category_id = zcat.id
    left outer join {{ ref('terminology__icd_10_cm') }} as icd10
        on replace(zc.code_icd10cm, '.', '') = icd10.icd_10_cm
    left outer join {{ ref('terminology__loinc') }} as loinc
        on zc.category_loinc = loinc.loinc
    left outer join {{ ref('terminology__snomed_ct') }} as snomed
        on zc.code_snomed = snomed.snomed_ct
)

select
    cast(condition_id as {{ dbt.type_string() }}) as condition_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(null as {{ dbt.type_string() }}) as claim_id
    , cast(recorded_date as date) as recorded_date
    , cast(onset_date as date) as onset_date
    , cast(resolved_date as date) as resolved_date
    , cast(status as {{ dbt.type_string() }}) as status
    , cast(condition_type as {{ dbt.type_string() }}) as condition_type
    , cast(null as {{ dbt.type_string() }}) as source_code_type
    , cast(null as {{ dbt.type_string() }}) as source_code
    , cast(null as {{ dbt.type_string() }}) as source_description
    , cast(normalized_code_type as {{ dbt.type_string() }}) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }}) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }}) as normalized_description
    , cast(condition_rank as int) as condition_rank
    , cast(null as {{ dbt.type_string() }}) as present_on_admit_code
    , cast(null as {{ dbt.type_string() }}) as present_on_admit_description
    , cast('zus' as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
