-- macro check if values in model1.column1 is entirely contained 
-- in values of model2.colun2 

{% macro column_contains_values(model1, column1, model2, column2) %}

    select distinct {{ column1 }}
    from {{ model1 }} 
    where {{ column1 }} not in (
        select distinct {{ column2 }}
        from {{ model2 }} 
    )

{% endmacro %}
