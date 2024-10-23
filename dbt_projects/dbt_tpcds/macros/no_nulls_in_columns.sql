/* macro check if specified columns values contains null */

{% macro no_nulls_in_columns(model, columns) %}
    SELECT * FROM {{ model }} WHERE
    {% for col in columns %}
        {{ col }} IS NULL {% if not loop.last %} OR {% endif %}
    {% endfor %}
{% endmacro %}