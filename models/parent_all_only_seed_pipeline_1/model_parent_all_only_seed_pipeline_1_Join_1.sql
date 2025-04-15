{{
  config({    
    "materialized": "table",
    "alias": "prophecy__temp_parent_all_only_seed_pipeline_1_post_Join_1_0",
    "database": "hive_metastore",
    "schema": "qa_db_warehouse"
  })
}}

WITH annual_enterprise AS (

  SELECT * 
  
  FROM {{ ref('annual_enterprise')}}

),

service_classification AS (

  SELECT * 
  
  FROM {{ ref('service_classification')}}

),

Join_1 AS (

  SELECT 
    in0.Year_1 AS Year_1,
    in0.Industry_aggregation_NZSIOC AS Industry_aggregation_NZSIOC,
    in0.Industry_code_NZSIOC AS Industry_code_NZSIOC,
    in0.Industry_name_NZSIOC AS Industry_name_NZSIOC,
    in0.Units_1 AS Units_1,
    in0.Variable_code_1 AS Variable_code_1,
    in0.Variable_name_1 AS Variable_name_1,
    in0.Variable_category_1 AS Variable_category_1,
    in0.Value_1 AS Value_1,
    in0.Industry_code_ANZSIC06 AS Industry_code_ANZSIC06,
    in1.code_1 AS code_1,
    in1.service_label_1 AS service_label_1
  
  FROM annual_enterprise AS in0
  INNER JOIN service_classification AS in1
     ON in0.Industry_aggregation_NZSIOC != in1.code_1

)

SELECT *

FROM Join_1
