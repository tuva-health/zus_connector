select
    id as practitioner_id
    , identifier_npi as npi
    , name_given_1 as first_name
    , name_family as last_name
    , coalesce(tuva_prov.provider_organization_name, tuva_prov.parent_organization_name)
        as practice_affiliation
    , null as sub_specialty
    , tuva_prov.primary_specialty_description as specialty
    , 'zus' as data_source
    , cast(null as {{ dbt.type_string() }}) as file_name
    , cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_zus_practitioner') }} as zp
left outer join {{ ref('terminology__provider') }} as tuva_prov
  on zp.identifier_npi = tuva_prov.npi
