with base as (
    select
        zms.id as medication_id
        , zms.upid as person_id
        , zms.subject_patient_id as patient_id
        , zms.context_encounter_id as encounter_id
        , null as dispensing_date
        , zms.effective_start as prescribing_date
        , case
            when zms.code_rxnorm is not null then 'rxnorm'
            when zms.code_ndc is not null then 'ndc'
            else 'unknown'
        end as zms.source_code_type
        , coalesce(zms.code_rxnorm, zms.code_ndc) as source_code
        , zms.code_display as source_description
        , zms.code_ndc as ndc_code
        , zms.code_rxnorm as rxnorm_code
        , null as atc_code
        , null as atc_description
        , zrc.display as route
        , null as strength
        , zd.dose_quantity_value as quantity
        , zd.dose_quantity_unit as quantity_unit
        , null as days_supply
        , null as practitioner_id
        , 'zus' as data_source
    from {{ ref('stg_zus_medication_statement') }} as zms
    left outer join {{ ref('stg_zus_medication_statement_dosage') }} as zmd
        on zms.id = zmd.medication_statement_id
    left outer join {{ ref('stg_zus_dosage') }} as zd
        on zmd.dosage_id = zd.id
    left outer join {{ ref('stg_zus_route_concept') }} as zrc
        on zd.route_concept_id = zrc.id
)

select
      cast(medcation_id as {{ dbt.type_string() }}) as medication_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(dispensing_date as date) as dispensing_date
    , cast(prescribing_date as date) as prescribing_date
    , cast(source_code_type as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(source_description as {{ dbt.type_string() }}) as source_description
    , cast(ndc_code as {{ dbt.type_string() }}) as ndc_code
    , cast(ndc_description as {{ dbt.type_string() }}) as ndc_description
    , cast(rxnorm_code as {{ dbt.type_string() }}) as rxnorm_code
    , cast(rxnorm_description as {{ dbt.type_string() }}) as rxnorm_description
    , cast(atc_code as {{ dbt.type_string() }}) as atc_code
    , cast(atc_description as {{ dbt.type_string() }}) as atc_description
    , cast(route as {{ dbt.type_string() }}) as route
    , cast(strength as {{ dbt.type_string() }}) as strength
    , cast(quantity as {{ dbt.type_int() }}) as quantity
    , cast(quantity_unit as {{ dbt.type_string() }}) as quantity_unit
    , cast(days_supply as {{ dbt.type_int() }}) as days_supply
    , cast(practitioner_id as {{ dbt.type_string() }}) as practitioner_id
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from base
