#Profitablility Analysis
use ShopSmart_Retail_Analytics;

#Which product categories generate the highest profit margin (%)?
with product_category as(select c.category, 
	   sum(f.profit) as total_profit,
       sum(f.sales) as total_revenue
       from fact_sales f
       inner join category c
       using(category_id)
       group by c.category)
select category, round(total_revenue,2) as total_revnue, round(total_profit,2) as total_profit,
       round((total_profit/total_revenue)*100,2) as profit_margin   
from product_category;


#Which subcategories have a negative total profit?
select c.sub_category, round(sum(f.profit),2) as total_profit
from category c
inner join fact_sales f
using(category_id)
group by sub_category
having total_profit<0;

#Which customers have the highest profit margin?
with customer_detail as 
(select c.customer_id,c.customer_name,
       sum(sales) as total_revenue,
       sum(f.profit)  as total_profit
from customer c
inner join fact_sales f
using(customer_id)
group by c.customer_id, customer_name)
select customer_id, customer_name,
	   round(total_revenue,2) as total_revenue,
       round(total_profit,2) as total_profit,
       round((total_profit/total_revenue)*100,2) as profit_margin
from customer_detail
order by profit_margin desc
limit 10;

#Which countries generate high revenue but low profit?
select l.country,
       round(sum(sales),2) as total_revenue,
       round(sum(profit),2) as total_profit
from location l
inner join fact_sales f
using(location_id)
group by l.country
ORDER BY total_revenue DESC,
         total_profit ASC;

#Which transactions resulted in a financial loss?
select f.transaction_id, c.customer_name, p.product_name,
	   round(sales) as revenue,
       round(profit) as profit
from fact_sales f 
inner join customer c
using(customer_id)
inner join product p
using(product_key)
having profit<0
limit 10;

#Which products have both high discounts and low profits?
with product_cte as
(select p.product_name,avg(f.discount) as high_discount, sum(f.profit) as low_profit
from fact_sales f 
inner join product p
using(product_key)
group by p.product_name
order by high_discount desc)
select product_name,high_discount,low_profit
from product_cte
order by high_discount desc,
low_profit asc;

#How does discount affect profit?
select case
	   when discount<0 then "0"
       when discount <=0.10 then "1-10"
       when discount <=0.20  then "11-20"
       when discount <=0.30 then "21-30"
       when discount <=0.40 then "31-40"
       else ">40"
       end as discount_range,
       round(sum(sales),2) as total_revenue,
       round(sum(profit),2) as total_profit
from fact_sales
group by discount_range;

#Top 10 most profitable transactions
select f.transaction_id,c.customer_name,
       round(sales,2) as total_revenue,
       round(profit,2) as total_profit
from fact_sales f
inner join customer c
using(customer_id)
group by f.transaction_id,c.customer_name
order by total_profit desc
limit 10;

#Bottom 10 least profitable transactions
select f.transaction_id,c.customer_name,
       round(sales,2) as total_revenue,
       round(profit,2) as total_profit
from fact_sales f
inner join customer c
using(customer_id)
group by f.transaction_id,c.customer_name
order by total_profit 
limit 10;

#Rank product categories by Profit Margin
with product_category as
(select c.category,sum(f.sales) as total_revenue,
		sum(f.profit) as total_profit
        from fact_sales f
        inner join category c 
        using(category_id)
        group by c.category),
        profitability_margin as
        (select category, total_revenue,total_profit,
                (total_profit/total_revenue)*100 as profit_margin
                from product_category)
 select category,
		round(total_revenue,2) as total_revenue,
        round(total_profit,2) as total_profit,
        round(profit_margin,2) as profit_margin,
        dense_rank() over(order by profit_margin desc) as product_rnk
        from profitability_margin;
 
