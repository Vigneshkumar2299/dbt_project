{{ config(
    materialized='incremental',  -- Enables incremental processing
    unique_key='deviceID'        -- Ensures updates instead of duplicates
) }}

SELECT 
    TIMESTAMP(_time) AS _time,   -- Convert _time to TIMESTAMP if needed
    _value,
    _field,
    _measurement,
    deviceID
FROM {{ source('dbt_poc', 'iot_data') }}  -- Ensure the source is correctly defined

{% if is_incremental() %}
  WHERE _time > (SELECT MAX(_time) FROM {{ this }})  -- Only insert new data
{% endif %}
