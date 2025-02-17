SELECT * 
FROM {{ source('dbt_poc', 'iot_data') }}
