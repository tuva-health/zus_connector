with attending_provider as (
    select
        ep.encounter_id
        , ep.individual_practitioner_id
    from {{ ref('stg_zus_encounter_participant') }} as ep
    inner join {{ ref('stg_zus_encounter_participant_type_coding') }} as eptc
        on ep.encounter_participant_type_id = eptc.encounter_participant_type_id
    where eptc.system = 'urn:oid:2.16.840.1.113883.4.642.3.250'
    and eptc.code = 'ATND'
)

, base as (
    select
        e.id as encounter_id
        , e.subject_patient_id as patient_id
        , e.upid as person_id
        , e.display as encounter_type
        , period_start as encounter_start_date
        , period_end as encounter_end_date
        , {{ dbt.datediff(
            try_to_cast_date(encounter_start_date),
            try_to_cast_date(encounter_end_date),'day'
        ) }} as length_of_stay
        , null as admit_source_code
        , null as admit_source_description
        , ehddc.code as discharge_disposition_code
        , ehddc.display as discharge_disposition_description
        , ap.individual_practitioner_id as attending_provider_id
        , coalesce(name_given_1 || ' ', '') ||
          coalesce(name_given_2 || ' ', '') ||
          coalesce(name_family, '') as attending_provider_name
        , e.location_id as facility_id
        , zl.name as facility_name
        , 'zus' as data_source
    from {{ ref('stg_zus_encounter') }} as e
    left outer join {{ ref('stg_zus_encounter_type') }} as et
        on e.encounter_type_id = et.id
    left outer join {{ ref('stg_zus_encounter_hospitalization_discharge_disposition_coding') }} as ehddc
        on e.encounter_hospitalization_discharge_disposition_id = ehddc.encounter_hospitalization_discharge_disposition_id
        and ehddc.system = 'urn:oid:2.16.840.1.113883.4.642.3.259'
    left outer join attending_provider as ap
        on e.encounter_id = ap.encounter_id
    left outer join {{ ref('stg_zus_practitioner') }} as zp
        on ap.individual_practitioner_id = zp.practitioner_id
    left outer join {{ ref('stg_zus_location') }} as zl
        on e.location_id = zl.id
)

select
    cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(encounter_type as {{ dbt.type_string() }}) as encounter_type
    , cast(encounter_start_date as date) as encounter_start_date
    , cast(encounter_end_date as date) as encounter_end_date
    , cast(length_of_stay as {{ dbt.type_int() }}) as length_of_stay
    , cast(admit_source_code as {{ dbt.type_string() }}) as admit_source_code
    , cast(admit_source_description as {{ dbt.type_string() }}) as admit_source_description
    , cast(admit_type_code as {{ dbt.type_string() }}) as admit_type_code
    , cast(admit_type_description as {{ dbt.type_string() }}) as admit_type_description
    , cast(discharge_disposition_code as {{ dbt.type_string() }}) as discharge_disposition_code
    , cast(discharge_disposition_description as {{ dbt.type_string() }}) as discharge_disposition_description
    , cast(attending_provider_id as {{ dbt.type_string() }}) as attending_provider_id
    , cast(attending_provider_name as {{ dbt.type_string() }}) as attending_provider_name
    , cast(facility_id as {{ dbt.type_string() }}) as facility_id
    , cast(facility_name as {{ dbt.type_string() }}) as facility_name
    , cast(null as {{ dbt.type_string() }}) as primary_diagnosis_code_type
    , cast(null as {{ dbt.type_string() }}) as primary_diagnosis_code
    , cast(null as {{ dbt.type_string() }}) as primary_diagnosis_description
    , cast(null as {{ dbt.type_string() }}) as drg_code_type
    , cast(null as {{ dbt.type_string() }}) as drg_code
    , cast(null as {{ dbt.type_string() }}) as drg_description
    , cast(null as {{ dbt.type_numeric() }}) as paid_amount
    , cast(null as {{ dbt.type_numeric() }}) as allowed_amount
    , cast(null as {{ dbt.type_numeric() }}) as charge_amount
    , cast(null as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from base
