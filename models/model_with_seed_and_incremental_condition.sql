WITH economic_survey_manufacturing AS (

  SELECT * 
  
  FROM {{ ref('economic_survey_manufacturing')}}

),

business_financial_data AS (

  SELECT * 
  
  FROM {{ ref('business_financial_data')}}

),

Join_1 AS (

  SELECT 
    economic_survey_manufacturing.Period_1 AS Period_1,
    economic_survey_manufacturing.Suppressed_1 AS Suppressed_1,
    economic_survey_manufacturing.STATUS_1 AS STATUS_1,
    economic_survey_manufacturing.UNITS_1 AS UNITS_1,
    business_financial_data.Series_reference AS Series_reference,
    business_financial_data.Series_title_1 AS Series_title_1,
    business_financial_data.Series_title_3 AS Series_title_3,
    business_financial_data.Series_title_5 AS Series_title_5,
    business_financial_data.Data_value AS Data_value,
    business_financial_data.STATUS1 AS STATUS1,
    business_financial_data.Magnitude_1 AS Magnitude_1,
    business_financial_data.Suppressed1 AS Suppressed1,
    business_financial_data.Series_title_4 AS Series_title_4,
    business_financial_data.Period1 AS Period1,
    business_financial_data.UNITS1 AS UNITS1,
    business_financial_data.Group_1 AS Group_1,
    business_financial_data.Series_title_2 AS Series_title_2,
    business_financial_data.Subject_1 AS Subject_1
  
  FROM business_financial_data
  INNER JOIN economic_survey_manufacturing
     ON business_financial_data.Series_reference != economic_survey_manufacturing.Series_reference

)

SELECT *

FROM Join_1

{% if is_incremental() %}
  WHERE 
    Period_1 > 10 and Suppressed_1 IS NOT NULL
{% endif %}