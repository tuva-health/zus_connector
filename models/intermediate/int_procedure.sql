with mapped_data as (
    select
        id as procedure_id
        , upid as person_id
        , subject_patient_id as patient_id
        , encounter_id
        , null as claim_id
        , {{ try_to_cast_date(performed_start) }} as procedure_date
        /*
        code_cpt and code_hcpcs can contain overlapping codes; here we encode them as the same source code type.
        */
        , case
            when code_cpt is not null then 'hcpcs'
            when code_loinc is not null then 'loinc'
            when code_hcpcs is not null then 'hcpcs'
            when code_snomed is not null then 'snomed-ct'
        end as source_code_type
        , source_code_type as normalized_code_type
        , coalesce(code_cpt, code_loinc, code_hcpcs, code_snomed) as source_code
        , code_display as source_description
        , coalesce(
                hcpcs.hcpcs,
                snomed.snomed_ct,
                loinc.loinc,
                case when code_cpt is not null then code_cpt else null end
                ) as normalized_code
        , coalesce(
            hcpcs.long_description,
            snomed.description,
            loinc.long_common_name,
            code_display
        ) as normalized_description
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
    left join {{ref('terminology__hcpcs_level_2')}} as hcpcs
        on code_hcpcs = hcpcs.hcpcs
    left join {{ref('terminology__snomed_ct')}} as snomed
        on zp.code_snomed = snomed.snomed_ct
    left join {{ref('terminology__loinc')}} as loinc
        on zp.code_loinc = loinc.loinc
),

select
      cast(procedure_id as {{ dbt.type_string() }} ) as procedure_id
    , cast(person_id as {{ dbt.type_string() }} ) as person_id
    , cast(patient_id as {{ dbt.type_string() }} ) as patient_id
    , cast(encounter_id as {{ dbt.type_string() }} ) as encounter_id
    , cast(claim_id as {{ dbt.type_string() }} ) as claim_id
    , cast(procedure_date as date) as procedure_date
    , cast(source_code_type as {{ dbt.type_string() }} ) as source_code_type
    , cast(source_code as {{ dbt.type_string() }} ) as source_code
    , cast(source_description as {{ dbt.type_string() }} ) as source_description
    , cast(normlized_code_type as {{ dbt.type_string() }} ) as normalized_code_type
    , cast(normalized_code as {{ dbt.type_string() }} ) as normalized_code
    , cast(normalized_description as {{ dbt.type_string() }} ) as normalized_description
    , cast(modifier_1 as {{ dbt.type_string() }} ) as modifier_1
    , cast(modifier_2 as {{ dbt.type_string() }} ) as modifier_2
    , cast(modifier_3 as {{ dbt.type_string() }} ) as modifier_3
    , cast(modifier_4 as {{ dbt.type_string() }} ) as modifier_4
    , cast(modifier_5 as {{ dbt.type_string() }} ) as modifier_5
    , cast(practitioner_id as {{ dbt.type_string() }} ) as practitioner_id
    , cast(data_source as {{ dbt.type_string() }} ) as data_source
    , cast(file_name as {{ dbt.type_string() }} ) as file_name
    , cast(ingest_datetime as {{ dbt.type_timestamp() }} ) as ingest_datetime
from mapped_data
