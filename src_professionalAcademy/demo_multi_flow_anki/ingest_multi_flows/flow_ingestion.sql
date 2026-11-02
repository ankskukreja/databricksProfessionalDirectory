/**
create or replace streaming table multi_flow_1_bronze.orders_bronze_flows_demo
(
    'throw everything as a string
    and fix that going to silver layer'

    subsidiary_id STRING,
    order_id STRING,
    order_date STRING,
    order_number STRING,
    order_status STRING,
    customer_id STRING,
    order_purchase_timestamp STRING,
    order_approved_at STRING,
    order_delivered_carrier_date,

    source_file STRING, -- Added by the _metadata column to return the source file name
    file_mod_time TIMESTAMP -- Added by the _metadata column to return file modification time of the file. Returns a consistent value 
)
comment "Creates a single bronze streaming table with orders from all subsidiaries using multiple flows  "
TBLPROPERTIES (
'pipelines.reset.allowed' = false -- prevent full table refresh on the bronze table
);
**/


-- BRONZE FLOW - BRIGHT HOME
/**
CREATE FLOW bright_home_orders_flow
AS INSERT INTO multi_flow_1_bronze.orders_bronze_flows_demo BY NAME 
SELECT 

   CAST(subsidiary_id as STRING) AS subsidiary_id,
   ....
   _metadata.file_name AS source_file,
   _metadata.file_modification_time AS file_mod_time

FROM STREAM read_files(
   '${bright_home_orders_source}',
   format => 'csv',
   header => true
   );

FROM STREAM read_files(
   '${northstar_outfitters_orders_source}',
   format => 'json',
   );



**/