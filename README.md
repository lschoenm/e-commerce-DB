# Brazilian E-Commerce Database & Analysis

The public dataset of commercial data from a Brazilian store is available [from Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce/data). The data contains ~100,000 orders made from 2016 to 2018 on the Brazilian online store Olist. 

The data is anonymized and contains various features such as order status, customer and seller details, product attributes, and reviews. 

## Data Download

First, I only download the main table, `olist_orders_dataset.csv`, and table `olist_order_items_dataset.csv` with order product information. These tables form the core of the overall schema.  

## Preliminary EDA

I use the VS Code Data Wrangler extension to get a first overview of the tables and features. 

```text
ecommerce-postgres-project/
├─ sql/
│   ├─ 01_schema.sql
│   ├─ 02_load_data.sql
│   └─ 03_views.sql
├─ src/
│   ├─ db.py          # DB connection + helpers (Python)
│   ├─ queries.py     # Python functions wrapping SQL
│   └─ features.py    # optional: ML feature engineering
├─ notebooks/
│   ├─ exploration.ipynb   # Polars EDA / visualization
│   └─ ml_model.ipynb      # Bonus ML later
├─ data_raw/          # original CSVs
├─ scripts/
│   └─ init_db.sh
├─ .env
├─ .env.example
├─ docker-compose.yml
├─ pyproject.toml / requirements.txt
└─ README.md
```

## Starting the DB via Docker

Using the definition in `docker-compose.yaml`, I can start up a PostgreSQL container. I made sure to also mount the directory `sql/` containing my SQL schema and for loading the data, and the directory `data-raw/` containing the input CSV files. 

To make starting, setup, and logging into the DB easier, I made a small helper script `init-db.sh`. 

```bash
# Start docker detached in the background
docker compose up -d

# Use the container's bash
docker exec -it olist-postgres bash

# Wait for DB to start
sleep 5

# Login to the DB
psql -U "$POSTGRES_USER" -d "$POSTGRES_DB"
```

After working on the database, I can stop the container either preserving everything or deleting all volumes including the database with the `-v` flag: 

```bash
docker compose down
docker compose down -v
```

## Defining a Schema

In table `olist_order_items`, both `order_id` and `order_item_id` together form a composite primary key. That is because `order_id` does not uniquely identify a row and `order_item_id` resets for every order, but together they do. 

```bash
\i sql/01-schema.sql
\dn
\dt olist.*
```