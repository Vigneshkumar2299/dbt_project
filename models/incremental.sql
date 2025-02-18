{{ config(
    materialized='incremental',  
    unique_key='deviceID'        
) }}

SELECT 
    TIMESTAMP(_time) AS _time,  
    _value,
    _field,
    _measurement,
    deviceID
FROM {{ source('dbt_poc', 'iot_data') }}  

{% if is_incremental() %}
  WHERE _time > (SELECT MAX(_time) FROM {{ this }})  
{% endif %}
