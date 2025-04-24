select
    id
    , version
    , last_updated
    , active
    , gender
    , birth_date
    , ethnicity
    , race
    , deceased
    , deceased_datetime
    , marital_status
    , marital_status_display
    , managing_organization_id
    , name_family
    , name_given_1
    , name_given_2
    , builder_id
    , upid
    , created_at
    , resource_json
    , data_source
from {{ source('zus_raw', 'patient') }}