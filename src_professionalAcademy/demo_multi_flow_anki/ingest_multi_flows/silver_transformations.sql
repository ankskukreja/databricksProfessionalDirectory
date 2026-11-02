/**

CREATE OR REFRESH STREAMING TABLE multi_flow_2_silver.orders_silver_flows_demo
(
    susidiary_id STRING,
    order_id STRING,
    order_timestamp TIMESTAMP,
    order_date DATE,
    ......

    -- B: data quality constraints to drop or flag or drop invalid rows
    CONSTRAINT qty_valid            EXPECT (qty >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT total_amount_valid   EXPECT (total_amount >= 0) ON VIOLATION DROP ROW,
    CONSTRAINT timestamp_not_null   EXPECT (order_timestamp IS NOT NULL) ON VIOLATION FAIL UPDATE,

    -- C: Add comment
    "this is comment"

    -- D: Enable Liquid Clustering to improve performance on common filters
    CLUSTER BY AUTO

AS
    SELECT 
        susidiary_id,
        order_id,
        TRY_CAST(order_timestamp to TIMESTAMP) AS order_timestamp,
        TRY_CAST(order_date to DATE) AS order_date,
        customer_id,
        region,
        .....

    FROM STREAM multi_flow_1_bronze.orders_bronze_flows_demo;
)


or
dp.create_streaming_table(

name = "",
comment = "",
table_properties = ""
)

**/