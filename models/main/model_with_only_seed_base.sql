{{
  config({    
    "materialized": "view"
  })
}}

WITH country_classification AS (

  SELECT * 
  
  FROM {{ ref('country_classification')}}

),

SetOperation_1 AS (

  SELECT * 
  
  FROM country_classification AS in0
  
  UNION
  
  SELECT * 
  
  FROM country_classification AS in1

),

Reformat_1 AS (

  SELECT * 
  
  FROM SetOperation_1 AS in0

),

service_classification AS (

  SELECT * 
  
  FROM {{ ref('service_classification')}}

),

Join_1 AS (

  SELECT 
    in0.country_code AS country_code,
    in0.country_label AS country_label,
    in1.code_1 AS code_1,
    in1.service_label_1 AS service_label_1,
    {{ SQL_BaseGitDepProjectAllFinal.qa_macro_call_another_macro_base_column('in0.country_code') }} AS c_macro2
  
  FROM Reformat_1 AS in0
  INNER JOIN service_classification AS in1
     ON in0.country_code != in1.code_1

)

SELECT 
  Join_1.country_code,
  Join_1.country_label,
  Join_1.code_1,
  Join_1.service_label_1,
  Join_1.c_macro2

FROM Join_1, service_classification

WHERE service_classification.service_label_1 != Join_1.country_code

LIMIT 100
