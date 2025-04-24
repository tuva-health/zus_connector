select
    id
    , version
    , last_updated
    , identifier_npi
    , name_family
    , name_given_1
    , name_given_2
    , address_line_1
    , address_line_2
    , address_city
    , address_state
    , address_postal_code
    , practitioner_qualification_id
    , builder_id
    , created_at
    , resource_json
    , data_source
from {{ source('zus_raw', 'practitioner') }}
