{#

    This macro takes in a numeric column and runs a try to cast macro based on
    the adapter type. Returns NULL casted as float if the try to cast fails.

    Casts to float rather than a fixed-precision numeric because FHIR decimals
    (Quantity.value, Range.low/high) are unbounded: values in scientific
    notation overflow numeric(28,6), and values smaller than 0.0000005 round
    away to zero.

#}

{%- macro try_to_cast_numeric(column_name) -%}

    {{ return(adapter.dispatch('try_to_cast_numeric')(column_name)) }}

{%- endmacro -%}

{%- macro bigquery__try_to_cast_numeric(column_name) -%}

    safe_cast( {{ column_name }} as float64 )

{%- endmacro -%}

{%- macro default__try_to_cast_numeric(column_name) -%}

    try_cast( cast( {{ column_name }} as {{ dbt.type_string() }} ) as {{ dbt.type_float() }} )

{%- endmacro -%}

{%- macro postgres__try_to_cast_numeric(column_name) -%}

    case
      when cast( {{ column_name }} as {{ dbt.type_string() }} ) similar to '[-+]?([0-9]+[.]?[0-9]*|[.][0-9]+)([eE][-+]?[0-9]+)?'
      then cast( {{ column_name }} as {{ dbt.type_float() }} )
      else cast(NULL as {{ dbt.type_float() }})
    end

{%- endmacro -%}

{%- macro redshift__try_to_cast_numeric(column_name) -%}

    case
      when cast( {{ column_name }} as {{ dbt.type_string() }} ) similar to '[-+]?([0-9]+[.]?[0-9]*|[.][0-9]+)([eE][-+]?[0-9]+)?'
      then cast( {{ column_name }} as {{ dbt.type_float() }} )
      else cast(NULL as {{ dbt.type_float() }})
    end

{%- endmacro -%}

{%- macro snowflake__try_to_cast_numeric(column_name) -%}

    try_cast( cast( {{ column_name }} as {{ dbt.type_string() }} ) as {{ dbt.type_float() }} )

{%- endmacro -%}
