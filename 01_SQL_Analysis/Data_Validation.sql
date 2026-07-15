use ShopSmart_Retail_Analytics;

show tables from ShopSmart_Retail_Analytics;

# How many sales transactions are present in the Sales Fact table?
select count(*) as total_transaction
from fact_sales;

# How many unique customers have placed at least one order?
select count(distinct customer_id)
FROM fact_sales;

#How many unique products are sold by the company?
select count(distinct(product_key)) as unique_products
from fact_sales;

#How many product categories and subcategories exist?
select count(distinct(category)) as total_categories,
 count(distinct(sub_category)) as total_subcategory
from category;

#How many unique cities, states, countries, regions, and markets does the business operate in?
select count(distinct(city)) as total_city,
       count(distinct(state)) as total_state,
       count(distinct(country)) as total_country,
       count(distinct(region)) as total_region,
       count(distinct(market)) as total_market
from location;

#Find the earliest and latest order date in the dataset.
select
MIN(order_date) AS first_order_date,
MAX(order_date) AS last_order_date
from fact_sales;

#Find the earliest and latest shipping date.
select
MIN(ship_date) AS first_ship_date,
MAX(ship_date) AS last_ship_date
from fact_sales;

#List all available customer segments.
select distinct segment
from customer;

#List all available shipping modes.
select distinct ship_mode
from orders;

#Check for NULL values in every important business column of the fact_sales table.
SELECT
SUM(customer_id IS NULL) AS customer_nulls,
SUM(product_key IS NULL) AS product_nulls,
SUM(category_id IS NULL) AS category_nulls,
SUM(location_id IS NULL) AS location_nulls,
SUM(order_id IS NULL) AS orderid_nulls,
SUM(order_date IS NULL) AS orderdate_nulls,
SUM(ship_date IS NULL) AS shipdate_nulls,
SUM(ship_mode IS NULL) AS shipmode_nulls,
SUM(quantity IS NULL) AS quantity_nulls,
SUM(sales IS NULL) AS sales_nulls,
SUM(profit IS NULL) AS profit_nulls,
SUM(discount IS NULL) AS discount_nulls,
SUM(shipping_cost IS NULL) AS shippingcost_nulls
FROM fact_sales;







