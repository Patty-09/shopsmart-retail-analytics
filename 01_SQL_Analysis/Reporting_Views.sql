USE ShopSmart_Retail_Analytics;

#Sale Summary view
CREATE OR REPLACE VIEW vw_sales_summary AS
SELECT
    f.transaction_id,f.order_id,
    o.order_date,o.ship_date,o.ship_mode,o.order_priority,
    c.customer_id,c.customer_name,c.segment,
    p.product_id,p.product_name,
    cat.category,cat.sub_category,
    l.market,l.region,l.country,l.state,l.city,
    f.sales,f.profit,f.quantity,f.discount,f.shipping_cost

FROM fact_sales f
JOIN orders o
ON f.order_id = o.order_id
JOIN customer c
ON f.customer_id = c.customer_id
JOIN product p
ON f.product_key = p.product_key
JOIN category cat
ON f.category_id = cat.category_id
JOIN location l
ON f.location_id = l.location_id;


#Customer Summary View
CREATE OR REPLACE VIEW vw_customer_summary AS
SELECT
    c.customer_id,c.customer_name,c.segment,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.quantity) AS total_quantity,
    ROUND(SUM(f.sales),2) AS total_revenue,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND(AVG(f.discount),2) AS average_discount,
    ROUND(
        (SUM(f.profit)/SUM(f.sales))*100,
        2
    ) AS profit_margin
FROM customer c
JOIN fact_sales f
USING(customer_id)
GROUP BY
c.customer_id,
c.customer_name,
c.segment;

#Product Summary View
CREATE OR REPLACE VIEW vw_product_summary AS
SELECT
    p.product_id,p.product_name,
    c.category,c.sub_category,
    COUNT(*) AS total_transactions,
    SUM(f.quantity) AS quantity_sold,
    ROUND(SUM(f.sales),2) AS total_revenue,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND(AVG(f.discount),2) AS average_discount,
    ROUND(
        (SUM(f.profit)/SUM(f.sales))*100,
        2
    ) AS profit_margin
FROM product p
JOIN category c
USING(category_id)
JOIN fact_sales f
USING(product_key)
GROUP BY
p.product_id,
p.product_name,
c.category,
c.sub_category;

#Regional Summary View
CREATE OR REPLACE VIEW vw_regional_summary AS
SELECT
    l.market,l.region,l.country,l.state,l.city,
    COUNT(DISTINCT f.order_id) AS total_orders,
    SUM(f.quantity) AS total_quantity,
    ROUND(SUM(f.sales),2) AS total_revenue,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND(AVG(f.discount),2) AS average_discount
FROM location l
JOIN fact_sales f
USING(location_id)
GROUP BY
l.market,
l.region,
l.country,
l.state,
l.city;

#Time Summary View
CREATE OR REPLACE VIEW vw_time_summary AS
SELECT
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    MONTH(order_date) AS month_number,
    MONTHNAME(order_date) AS month_name,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS quantity_sold,
    ROUND(SUM(sales),2) AS total_revenue,
    ROUND(SUM(profit),2) AS total_profit
FROM fact_sales
GROUP BY
YEAR(order_date),
QUARTER(order_date),
MONTH(order_date),
MONTHNAME(order_date);

#KPI Summary View
CREATE OR REPLACE VIEW vw_kpi_summary AS
SELECT
ROUND(SUM(sales),2) AS total_revenue,
ROUND(SUM(profit),2) AS total_profit,
ROUND((SUM(profit)/SUM(sales))*100,2) AS profit_margin,
COUNT(DISTINCT customer_id) AS total_customers,
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT product_key) AS total_products,
SUM(quantity) AS quantity_sold,
ROUND(SUM(sales)/COUNT(DISTINCT order_id),2) AS average_order_value,
ROUND(AVG(discount),2) AS average_discount,
ROUND(AVG(shipping_cost),2) AS average_shipping_cost
FROM fact_sales;

#Validating Views
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

SELECT * FROM vw_sales_summary LIMIT 10;

SELECT * FROM vw_customer_summary LIMIT 10;

SELECT * FROM vw_product_summary LIMIT 10;

SELECT * FROM vw_regional_summary LIMIT 10;

SELECT * FROM vw_time_summary LIMIT 10;

SELECT * FROM vw_kpi_summary;

