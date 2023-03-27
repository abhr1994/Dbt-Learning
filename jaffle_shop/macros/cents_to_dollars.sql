{% macro cents_to_dollars(column_name='amount',decimal_places=2) -%}
    round( 1.0 * {{column_name}} / 100, {{decimal_places}} )
{%- endmacro %}