-- Звёздная схема для ETL-пайплайна на Spark.
-- Суррогатные ключи типа BIGINT: генерируются Spark через row_number().
-- FK-ограничения намеренно отсутствуют — это упрощает Spark JDBC write (TRUNCATE + INSERT).

CREATE TABLE IF NOT EXISTS public.dim_location (
    location_id  BIGINT PRIMARY KEY,
    country      VARCHAR(255),
    state        VARCHAR(255),
    city         VARCHAR(255),
    postal_code  VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.dim_category (
    category_id   BIGINT PRIMARY KEY,
    category_name VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.dim_pet (
    pet_id       BIGINT PRIMARY KEY,
    pet_type     VARCHAR(255),
    pet_category VARCHAR(255),
    pet_breed    VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.dim_customer (
    customer_id BIGINT PRIMARY KEY,
    first_name  VARCHAR(255),
    last_name   VARCHAR(255),
    age         INTEGER,
    email       VARCHAR(255),
    location_id BIGINT,
    pet_id      BIGINT,
    pet_name    VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.dim_seller (
    seller_id   BIGINT PRIMARY KEY,
    first_name  VARCHAR(255),
    last_name   VARCHAR(255),
    email       VARCHAR(255),
    location_id BIGINT
);

CREATE TABLE IF NOT EXISTS public.dim_store (
    store_id         BIGINT PRIMARY KEY,
    store_name       VARCHAR(255),
    location_address VARCHAR(255),
    location_id      BIGINT,
    phone            VARCHAR(255),
    email            VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS public.dim_supplier (
    supplier_id      BIGINT PRIMARY KEY,
    supplier_name    VARCHAR(255),
    contact_name     VARCHAR(255),
    email            VARCHAR(255),
    phone            VARCHAR(255),
    location_address VARCHAR(255),
    location_id      BIGINT
);

CREATE TABLE IF NOT EXISTS public.dim_product (
    product_id   BIGINT PRIMARY KEY,
    product_name VARCHAR(255),
    category_id  BIGINT,
    supplier_id  BIGINT,
    price        NUMERIC(10,2),
    weight       NUMERIC(10,3),
    color        VARCHAR(255),
    size         VARCHAR(255),
    brand        VARCHAR(255),
    material     VARCHAR(255),
    description  TEXT,
    rating       NUMERIC(3,1),
    reviews      INTEGER,
    release_date DATE,
    expiry_date  DATE
);

CREATE TABLE IF NOT EXISTS public.fact_sales (
    sale_id     BIGINT PRIMARY KEY,
    sale_date   DATE,
    customer_id BIGINT,
    seller_id   BIGINT,
    product_id  BIGINT,
    store_id    BIGINT,
    quantity    INTEGER,
    total_price NUMERIC(12,2)
);
