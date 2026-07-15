#Advance Business SQL
use ShopSmart_Retail_Analytics;

#Find the Top 3 customers in each market based on revenue.
with customer_cte as 
(select c.customer_id,c.customer_name, l.market, sum(f.sales) as total_revenue
from fact_sales f
inner join customer c using(customer_id)
inner join location l using(location_id)
group by c.customer_id,c.customer_name, l.market),
rank_cte as(
 select *, dense_rank() over(partition by market
            order by total_revenue desc) as customer_rnk
from customer_cte)
select * from
rank_cte
where customer_rnk<=3;

#Find the Top 5 products in each category by revenue.
with product_cte as
(select p.product_id,p.product_name,c.category,sum(f.sales) as total_revenue
from fact_sales f 
inner join category c using(category_id)
inner join product p using(product_key)
group by p.product_id,p.product_name,c.category),
rank_cte as
(select *, dense_rank() over(partition by category
               order by total_revenue desc) as category_rnk
               from product_cte)
select * from rank_cte
where category_rnk<=5;

#Find customers who purchased from more than 3 different product categories.
select f.customer_id, cu.customer_name,
       count(distinct c.category) as category_count
       from fact_sales f 
       inner join customer cu using(customer_id)
       inner join category c using(category_id)
       group by f.customer_id, cu.customer_name
       having category_count>3;

#Find customers who have never generated a profit.
select c.customer_id,c.customer_name, round(sum(f.profit),2) as total_profit
from fact_sales f 
inner join customer c
using(customer_id)
group by c.customer_id,c.customer_name
having total_profit<=0;

#Identify repeat customers.
select c.customer_id, c.customer_name,round(sum(f.sales),2) as total_revenue,
count(distinct f.order_id) as order_count
from fact_sales f
inner join customer c using(customer_id)
group by c.customer_id, c.customer_name
having count(distinct f.order_id)>1
order by order_count desc;

#For every market, find the highest revenue transaction.
with transaction_cte as 
(select l.market, f.sales as total_revenue,
        row_number() over(partition by l.market
                   order by f.sales desc) as rnk
from fact_sales f
inner join location l
using(location_id))
select *
from transaction_cte
where rnk=1;

                   

#Find the contribution (%) of the Top 10 customers to total company revenue.
with customer_cte as 
(select c.customer_id, c.customer_name, sum(f.sales) as customer_revenue
        from fact_sales f 
        inner join customer c
        using(customer_id)
        group by c.customer_id, c.customer_name
        )
select customer_id ,customer_name, 
round(customer_revenue,2) as customer_revenue,
round((customer_revenue/(select sum(customer_revenue) from customer_cte))*100,2) as revenue_contribution
from customer_cte
order by revenue_contribution desc
limit 10;

#Calculate cumulative yearly revenue.
with year_cte as 
(select year(order_date) as yr, sum(sales) as total_revenue
from fact_sales 
group by yr)
select *,sum(total_revenue) over(order by yr ) as cum_revenue
from year_cte;

#Identify the best-selling product in every category.
with product_category as 
(select p.product_id, p.product_name, c.category_id,c.category,
        sum(sales) as total_revenue
        from fact_sales f
        inner join category c using(category_id)
        inner join product p using(product_key)
        group by p.product_id, p.product_name, c.category_id,c.category),
        rank_cte as (
            select *, row_number() over(partition by category 
            order by total_revenue desc) as product_rnk
            from product_category)
select *
from rank_cte
where product_rnk=1;

#Create one SQL query that returns the following KPIs in a single result:
select round(sum(sales),2) as total_revenue,
       round(sum(profit),2) as total_profit,
       round((sum(profit)/sum(sales))*100,2) as profit_margin,
       count(distinct customer_id) as total_customer,
       count(distinct order_id) as total_order,
       count(distinct product_key) as total_product,
       round(sum(sales)/count(distinct order_id),2) as avg_order_value,
       round(avg(discount),2) as avg_discount,
       round(avg(shipping_cost),2) as avg_shipping_cost
from fact_sales;
        
        
    




