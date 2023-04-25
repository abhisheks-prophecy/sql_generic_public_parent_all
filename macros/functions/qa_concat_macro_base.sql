{% macro _qa_concat_string_cols(input_col1, input_col2) %}
concat({{input_col1}}, {{input_col2}})
{% endmacro %}

 {% macro qa_concat_macro_base(param1_string_only='hello') %}
concat('{{param1_string_only}}', 'hellomain')
{% endmacro %}

 {% macro _qa_concat_param_type_base(input_string='hello', int_param_or_col=10) %}
concat('{{input_string}}', {{int_param}})
{% endmacro %}

 {% macro multi_macro_expressions_base(param_float=12, param_array=[1, 2, 3], param_dict=[1, 2, 3]) %}
concat({{param_float}} + {{param_array[0]}}, 'hello')
{% endmacro %}

 {% macro _round_function_base(n1, scale=2) %}
ROUND({{n1}}, {{scale}})
{% endmacro %}

 {% macro qa_concat_macro_base_column(param1_column) %}
concat({{param1_column}}, 'hellomain')
{% endmacro %}

 {% macro qa_macro_call_another_macro_base_column(param_column) %}
concat({{ SQL_BaseGitDepProjectAllFinal.qa_concat_macro_base_column(param_column) }}, {{param_column}})
{% endmacro %}

 {% macro qa_macro_call_another_macro_base(final_param_string_only='random data') %}
concat({{ SQL_BaseGitDepProjectAllFinal.qa_concat_macro_base(final_param_string_only) }}, '{{final_param_string_only}}')
{% endmacro %}

 {% macro round_function_base(n1, scale=2) %}
ROUND({{n1}}, {{scale}})
{% endmacro %}

 