COPY olist.orders
FROM '/data-raw/olist_orders_dataset.csv'
WITH (FORMAT csv, HEADER true);

COPY olist.order_items
FROM '/data-raw/olist_order_items_dataset.csv'
WITH (FORMAT csv, HEADER true);