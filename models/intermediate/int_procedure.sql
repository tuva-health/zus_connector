with mapped_data as (
    select
        id as procedure_id
        , upid as person_id
        , subject_patient_id as patient_id
        , encounter_id
        , null as claim_id
        , cast(performed_start as date) as procedure_date
        /*
        code_cpt and code_hcpcs can contain overlapping codes; here we encode them as the same source code type.
        */
        , case
            when zp.code_cpt is not null then 'hcpcs'
            when zp.code_loinc is not null then 'loinc'
            when zp.code_hcpcs is not null then 'hcpcs'
            when zp.code_snomed is not null then 'snomed-ct'
        end as source_code_type
        , source_code_type as normalized_code_type
        , coalesce(code_cpt, code_loinc, zp.code_hcpcs, code_snomed) as source_code
        , code_display as source_description
        /*
        normalized_code must follow the same priority as source_code_type, otherwise a procedure
        coded with both CPT and SNOMED is typed hcpcs but carries the SNOMED code.
        */
        , case
            when zp.code_cpt is not null then code_cpt
            when zp.code_loinc is not null then loinc.loinc
            when zp.code_hcpcs is not null then hcpcs.hcpcs
            when zp.code_snomed is not null then snomed.snomed_ct
        end as normalized_code
        , case
            when zp.code_cpt is not null then null
            when zp.code_loinc is not null then loinc.long_common_name
            when zp.code_hcpcs is not null then hcpcs.long_description
            when zp.code_snomed is not null then snomed.description
        end as normalized_description
        , null as modifier_1
        , null as modifier_2
        , null as modifier_3
        , null as modifier_4
        , null as modifier_5
        , null as practitioner_id
        , 'zus' as data_source
        , null as file_name
        , null as ingest_datetime
    from {{ ref('stg_zus_procedure') }} as zp
    left outer join {{ ref('terminology__hcpcs_level_2') }} as hcpcs
        on zp.code_hcpcs = hcpcs.hcpcs
    left outer join {{ ref('terminology__snomed_ct') }} as snomed
        on zp.code_snomed = snomed.snomed_ct
    left outer join {{ ref('terminology__loinc') }} as loinc
        on zp.code_loinc = loinc.loinc
)

select
      cast(procedure_id as {{ dbt.type_string() }}) as procedure_id
    , cast(person_id as {{ dbt.type_string() }}) as person_id
    , cast(patient_id as {{ dbt.type_string() }}) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }}) as encounter_id
    , cast(claim_id as {{ dbt.type_string() }}) as claim_id
    , cast(procedure_date as date) as procedure_date
    , cast(source_code_type as {{ dbt.type_string() }}) as source_code_type
    , cast(source_code as {{ dbt.type_string() }}) as source_code
    , cast(source_description as {{ dbt.type_string() }}) as source_description
    , cast(normalized_code_type as {{ dbt.type_string() }}) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }}) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }}) as normalized_description
    , cast(modifier_1 as {{ dbt.type_string() }}) as modifier_1
    , cast(modifier_2 as {{ dbt.type_string() }}) as modifier_2
    , cast(modifier_3 as {{ dbt.type_string() }}) as modifier_3
    , cast(modifier_4 as {{ dbt.type_string() }}) as modifier_4
    , cast(modifier_5 as {{ dbt.type_string() }}) as modifier_5
    , cast(practitioner_id as {{ dbt.type_string() }}) as practitioner_id
    , cast(data_source as {{ dbt.type_string() }}) as data_source
    , cast(file_name as {{ dbt.type_string() }}) as file_name
    , cast(ingest_datetime as {{ dbt.type_timestamp() }}) as ingest_datetime
from mapped_data
