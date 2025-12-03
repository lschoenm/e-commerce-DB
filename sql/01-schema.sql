CREATE SCHEMA IF NOT EXISTS olist;

CREATE TABLE olist.orders (
    order_id CHAR(42) PRIMARY KEY,
    customer_id CHAR(42),
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

CREATE TABLE olist.order_items (
    order_id CHAR(42),
    order_item_id INTEGER,
    product_id CHAR(42),
    seller_id CHAR(42),
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,
    PRIMARY KEY (order_id, order_item_id),
    FOREIGN KEY (order_id) REFERENCES olist.orders(order_id)
);