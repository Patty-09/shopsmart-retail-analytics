DROP DATABASE IF EXISTS ShopSmart_Retail_Analytics;

CREATE DATABASE ShopSmart_Retail_Analytics;

USE ShopSmart_Retail_Analytics;

SELECT COUNT(*) AS total_rows
FROM global_superstore_raw;

SHOW COLUMNS FROM global_superstore_raw;

ALTER TABLE global_superstore_raw
ADD COLUMN transaction_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

# Customer table 
CREATE TABLE customer (
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(150),
    segment VARCHAR(50)
);

INSERT INTO customer
(customer_id, customer_name, segment)
SELECT DISTINCT
customer_id,
customer_name,
segment
FROM global_superstore_raw;

SELECT COUNT(*) AS total_customers
FROM customer;

#Category table
CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(100)
);

INSERT INTO category (category, sub_category)
SELECT DISTINCT
category,
sub_category
FROM global_superstore_raw;

SELECT COUNT(*) AS total_categories
FROM category;

SELECT
    product_name,
    COUNT(DISTINCT product_id) AS product_ids
FROM global_superstore_raw
GROUP BY product_name
HAVING COUNT(DISTINCT product_id) > 1;

SELECT
    COUNT(DISTINCT product_id) AS unique_product_ids,
    COUNT(DISTINCT product_name) AS unique_product_names
FROM global_superstore_raw;


DROP TABLE IF EXISTS product;

CREATE TABLE product (
       product_key INT AUTO_INCREMENT PRIMARY KEY,
       product_id VARCHAR(30),
	   product_name VARCHAR(255),
	   category_id INT,
       FOREIGN KEY (category_id) REFERENCES category(category_id)
);
INSERT INTO product
   (product_id, product_name, category_id)
   SELECT DISTINCT
   g.product_id,
   g.product_name,
   c.category_id
   FROM global_superstore_raw g
   JOIN category c
   ON g.category = c.category
   AND g.sub_category = c.sub_category;
   
SELECT COUNT(*) AS total_products
FROM product;

#Location Table
CREATE TABLE location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100),
    market VARCHAR(50)
);

INSERT INTO location
   (city,state,country,region,market)
   SELECT DISTINCT
   city,
   state,
   country,
   region,
   market
FROM global_superstore_raw;

SELECT COUNT(*) AS total_locations
FROM location;
SELECT * FROM location LIMIT 10;

#Order Table

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (

    order_key INT AUTO_INCREMENT PRIMARY KEY,

    order_id VARCHAR(30),

    order_date DATE,

    order_priority VARCHAR(20),

    customer_id VARCHAR(20),

    location_id INT,

    ship_date DATE,

    ship_mode VARCHAR(50),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (location_id)
        REFERENCES location(location_id)

);

INSERT INTO orders
(
    order_id,
    order_date,
    order_priority,
    customer_id,
    location_id,
    ship_date,
    ship_mode
)
SELECT DISTINCT
    g.order_id,
    STR_TO_DATE(g.order_date,'%d-%m-%Y'),
    g.order_priority,
    g.customer_id,
    l.location_id,
    STR_TO_DATE(g.ship_date,'%d-%m-%Y'),
    g.ship_mode
FROM global_superstore_raw g
JOIN location l
ON g.city=l.city
AND g.state=l.state
AND g.country=l.country
AND g.region=l.region
AND g.market=l.market;

SELECT
    COUNT(*) AS duplicate_orders
FROM (
    SELECT
        order_id,
        customer_id,
        order_date,
        ship_date
    FROM global_superstore_raw
    GROUP BY
        order_id,
        customer_id,
        order_date,
        ship_date
    HAVING COUNT(*) > 1
) t;

CREATE TABLE fact_sales (

    transaction_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id VARCHAR(20),

    product_key INT,

    category_id INT,

    location_id INT,

    order_id VARCHAR(30),

    order_date DATE,

    ship_date DATE,

    ship_mode VARCHAR(30),

    order_priority VARCHAR(20),

    quantity INT,

    sales DECIMAL(12,2),

    profit DECIMAL(12,2),

    discount DECIMAL(5,2),

    shipping_cost DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (product_key)
        REFERENCES product(product_key),

    FOREIGN KEY (category_id)
        REFERENCES category(category_id),

    FOREIGN KEY (location_id)
        REFERENCES location(location_id)

);

INSERT INTO fact_sales
(
customer_id,
product_key,
category_id,
location_id,
order_id,
order_date,
ship_date,
ship_mode,
order_priority,
quantity,
sales,
profit,
discount,
shipping_cost
)

SELECT

g.customer_id,

p.product_key,

c.category_id,

l.location_id,

g.order_id,

STR_TO_DATE(g.order_date,'%d-%m-%Y'),

STR_TO_DATE(g.ship_date,'%d-%m-%Y'),

g.ship_mode,

g.order_priority,

g.quantity,

g.sales,

g.profit,

g.discount,

g.shipping_cost

FROM global_superstore_raw g

JOIN product p
ON g.product_id = p.product_id
AND g.product_name = p.product_name

JOIN category c
ON g.category = c.category
AND g.sub_category = c.sub_category

JOIN location l
ON g.city = l.city
AND g.state = l.state
AND g.country = l.country
AND g.region = l.region
AND g.market = l.market;

SELECT COUNT(*) FROM fact_sales;