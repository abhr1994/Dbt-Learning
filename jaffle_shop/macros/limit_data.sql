{% macro limit_data(ts_name, no_of_days=3) %}
    {%- if target.name == 'dev' -%}
        where {{ts_name}} >= date_add('day', -{{ no_of_days }}, current_timestamp)
    {%- endif -%}
{%- endmacro -%}