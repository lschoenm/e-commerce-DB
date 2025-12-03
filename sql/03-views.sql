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