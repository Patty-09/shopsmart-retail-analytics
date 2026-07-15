# Product Analysis
use ShopSmart_Retail_Analytics;

#Top 10 Product revenue
select p.product_key, p.product_name,
       c.category, c.sub_category,
       round(sum(f.sales),2) as product_revenue
from fact_sales f
inner join product p
on  f.product_key = p.product_key 
inner join category c
on p.category_id = c.category_id
group by p.product_name , p.product_key,
         c.category, c.sub_category
order by product_revenue desc
limit 10;

#Top 10 Products by Profit
select p.product_key, p.product_name,
round(sum(f.profit),2) as top_product_profit
from product p
inner join fact_sales f
on p.product_key = f.product_key
group by p.product_name , p.product_key
order by top_product_profit desc
limit 10;

#Worst 10 Products by Profit
select p.product_key, p.product_name,
round(sum(f.profit),2) as bottom_product_profit
from product p
inner join fact_sales f
on p.product_key = f.product_key
group by p.product_name , p.product_key
order by bottom_product_profit asc
limit 10;

#Which product category contributes the highest revenue and profit?
with product_category as (
select c.category,
round(sum(f.sales),2) as total_sales,
round(sum(f.profit),2) as total_profit
from fact_sales f
inner join category c
using(category_id)
group by c.category
)
select category,
total_sales,
total_profit,
round((total_sales/ (select sum(total_sales) 
	from product_category))*100, 2) as revenue_percent,
round((total_profit/ (select sum(total_profit) 
	 from product_category))*100, 2) as profit_percent
from product_category
order by total_sales desc;

#Which product subcategory contributes the highest revenue?
select c.sub_category, 
round(sum(f.sales),2) as total_revenue,
round(sum(f.profit),2) as total_profit
from category c
inner join fact_sales f
using(category_id)
group by c.sub_category
order by total_revenue desc;

#Which products sold the highest quantity?
select p.product_name, 
sum(quantity) as highest_qty
from product p 
inner join fact_sales f 
using(product_key)
group by p.product_name
order by highest_qty desc;

#Which products appeared in the highest number of sales transactions?
select p.product_name, 
count(f.transaction_id) as transaction_count
from product p 
inner join fact_sales f 
using(product_key)
group by p.product_name
order by transaction_count desc
limit 10;

#Which products receive the highest average discount?
select p.product_name, 
round(avg(f.discount),2) as avg_discount
from product p 
inner join fact_sales f 
using(product_key)
group by p.product_name
order by avg_discount desc
limit 10;

#Rank all products based on total revenue.
with product_revenue as (
select p.product_name, 
round(sum(f.sales),2) as total_revenue
from product p 
inner join fact_sales f 
using(product_key)
group by p.product_name
)
select product_name, total_revenue,
   dense_rank() over(order by total_revenue desc) as product_rnk
from product_revenue
order by product_rnk asc
limit 10;

#Identify products whose total revenue is above the average product revenue.
with product_revenue as 
    (select p.product_name, 
    round(sum(f.sales),2) as total_revenue
    from product p 
    inner join fact_sales f
    using(product_key)
    group by p.product_name)
select product_name, total_revenue
from product_revenue
where total_revenue >(select avg(total_revenue)
                       from product_revenue)
order by total_revenue desc
limit 10;
