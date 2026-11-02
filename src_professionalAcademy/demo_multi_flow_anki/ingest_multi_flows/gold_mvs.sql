/**
CREATE OR REPLACE MATERIALIZED VIEW multi_flow_3_gold.mv_daily_subsidiary_scorecard_demo
AS 
SELECT 
    order_date,
    subsidiary_id,
    COUNT(distinct order_id) AS order_count,
    ROUND(SUM(total_amount),2) AS total_revenue,
    SUM(qty)
FROM
    multi_flow_2_silver.orders_silver_flows_demo
WHERE
    order_date is not NULL
GROUP BY order_date, susidiary_id;
 


**/