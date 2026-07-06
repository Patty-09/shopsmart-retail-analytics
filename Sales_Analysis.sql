use ShopSmart_Retail_Analytics;

#How has total sales changed over the years?
select year(order_date) as sales_year,round(sum(sales),2) as total_sales
from fact_sales
group by year(order_date)
order by total_sales;

#How has total profit changed over the years?
select year(order_date) as profit_year,
round(sum(profit),2) as total_profit
from fact_sales
group by year(order_date)
order by profit_year;

#Which order priority contributes the most revenue
select order_priority, 
round(sum(sales),2) as total_revenue, 
round(sum(profit),2) as total_profit
from fact_sales
group by order_priority
order by total_revenue desc;

#Which shipping mode generates the highest revenue
select ship_mode,
round(sum(sales),2) as total_revenue, 
round(sum(profit),2) as total_profit, 
count(*) as total_transaction
from fact_sales
group by ship_mode
order by total_revenue desc;

#Which shipping mode has the highest average transaction value
select ship_mode, 
round(avg(sales),2) as transaction_value
from fact_sales
group by ship_mode
order by transaction_value desc;

#Which individual sales transactions generated the highest revenue?
select f.transaction_id, f.order_id, c.customer_name, f.sales
from fact_sales f
inner join customer c 
using(customer_id) 
order by f.sales desc
limit 10;

#Which individual transactions generated the highest profit?
select f.transaction_id, f.order_id, c.customer_name, f.profit
from fact_sales f
inner join customer c
using(customer_id) 
order by f.profit desc
limit 10;

#How is total revenue distributed across different customer segments?
with segment_sales as 
(select c.segment,
round(sum(sales),2) as total_revenue
from customer c
inner join fact_sales f
using(customer_id)
group by c.segment)
select segment,
total_revenue,
(total_revenue/(select sum(total_revenue)
from segment_sales))*100 as revenue_percentage
from segment_sales
order by revenue_percentage desc;


#How much does each customer segment contribute to the company's total profit?
with segment_profit as (
select c.segment,
round(sum(f.profit),2) as total_profit
from customer c 
inner join fact_sales f
using(customer_id) 
group by c.segment)
select segment, total_profit,
round((total_profit/
     (select sum(total_profit) 
           from segment_profit))*100) as profit_percent
from segment_profit
order by profit_percent desc;

#Which transactions received a discount higher than the overall average discount?
select f.transaction_id, c.customer_name, f.sales, f.profit, f.discount
from fact_sales f
inner join customer c 
using(customer_id)
where f.discount > (select avg(discount) 
                  from fact_sales)
order by f.discount desc;


