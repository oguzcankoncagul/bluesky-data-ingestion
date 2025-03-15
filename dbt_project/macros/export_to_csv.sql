{% macro export_all_analyses_to_csv() %}
{% set analyses = dbt_utils.get_relations_by_prefix(schema=target.schema, prefix="") %}

{% for analysis in analyses %}
    {% set analysis_name = analysis.identifier %}
    {% set file_path = "metrics/" ~ analysis_name ~ ".csv" %}
    
    COPY (SELECT * FROM {{ analysis }}) TO '{{ file_path }}' (HEADER, DELIMITER ',');
{% endfor %}
{% endmacro %}
