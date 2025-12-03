-- 1. Combined order-items view
CREATE VIEW olist.order_items_expanded AS
SELECT
    oi.*,
    o.order_status,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.customer_id
FROM olist.order_items oi
JOIN olist.orders o USING (order_id);

-- 2. Monthly revenue and order view
CREATE VIEW olist.monthly_revenue AS
SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS datetime_month,
    SUM(price + freight_value) AS total_revenue,
    COUNT(DISTINCT order_id) AS n_orders
FROM olist.order_items_expanded
WHERE order_status IN ('delivered', 'shipped')
GROUP BY datetime_month
ORDER BY datetime_month;