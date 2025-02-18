CREATE TABLE gwc-poc.dbt_poc_backup.iot_data_backup AS
SELECT * FROM gwc-poc.dbt_poc.iot_data;



{{ config(materialized='table') }}
SELECT * 
FROM {{ source('dbt_poc', 'iot_data') }}
