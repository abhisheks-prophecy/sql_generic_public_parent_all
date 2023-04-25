{% macro _qa_all_null_base(model, column_name='id') %}


select * from {{ model }} where {{ column_name }} is not null
{% endmacro %}

 {% macro qa_epl_data_macro_base(table_name, football_clubs=['Man United', 'Liverpool', 'Man City']) %}


{% set status = ['HomeTeam_1','AwayTeam_1'] %}
with summary as (
{% for club in football_clubs %}
    {% for st in status %}
    select 
        {{ st }} as team,
        {% if st == 'HomeTeam' %}
                case 
                    when FTR_1 = 'H' then 3
                    when FTR_1 = 'D' then 1
                    else 0 end points
        {% else %}
                case 
                    when FTR_1 = 'A' then 3
                    when FTR_1 = 'D' then 1
                    else 0 end points
        {% endif %}
    from {{ table_name }}
    where {{ st }} = '{{ club }}'
        {% if not loop.last %} UNION ALL {% endif %}
    {% endfor %}
    {% if not loop.last %} UNION ALL {% endif %}
{% endfor %}
)


select 
    team, 
    sum(points) as total_points
from summary
group by team
order by total_points desc
{% endmacro %}

 {% macro qa_test_relationship_base(model1, model2, model1_col, model2_col) %}


select count(*)
from (
    select {{ model1_col }} as id from {{ model1 }}
) as child
left join (
    select {{ model2_col }} as id from {{ model2 }}
) as parent on parent.id = child.id
where child.id is not null
  and parent.id is null
{% endmacro %}

 {% macro qa_all_not_null_base(model, column_name) %}


select * from {{ model }} where {{ column_name }} is not null
{% endmacro %}

 {% macro qa_model_all_above_given_id_base(model, col, id_min=2) %}

SELECT * from {{model}} where {{col}} > {{ id_min }}
{% endmacro %}

 {% macro qa_all_null_base(model='customers', column_name='id') %}




select * from {{ model }} where {{ column_name }} is not null
{% endmacro %}

 {% macro qa_get_unique_count_base(model, column_name) %}


select count(*)
from (
    select
        {{ column_name }}
    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having count(*) >= 1
) validation_errors
{% endmacro %}

 {% macro qa_multi_models_base(model1, col_model_1, model2, model3, model4, model5) %}

select {{model1}}.{{col_model_1}} from {{model1}},{{model2}},{{model3}},{{model4}},{{model5}}
{% endmacro %}

 {% macro qa_complex_macro_base(model, column_name_int, accepted_values=[1, 2]) %}


with all_values as (
    select distinct {{column_name_int}} as col_int from {{model}}
),
payments_validation_errors as (
    select
        col_int
    from all_values
    where col_int not in (
        {% for accepted_value in accepted_values %}
            {% if accepted_value >= 5 %}
            5
            {% else %}
            {{ accepted_value }}
            {% endif %}
            {% if not loop.last %},{% endif %}
        {% endfor %}
    )
)
select * from payments_validation_errors
{% endmacro %}

 