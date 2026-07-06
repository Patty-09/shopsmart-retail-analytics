use ShopSmart_Retail_Analytics;

#Top 10 customer by revenue
#Which 10 customers generated the highest total sales revenue?
select c.customer_id, c.customer_name, 
   round(sum(sales),2) as highes_total_sales
from customer c
inner join fact_sales f 
using(customer_id)
group by customer_id, customer_name
order by highes_total_sales desc
limit 10;

#Which customers generated the highest total profit?
select c.customer_id, c.customer_name, round(sum(profit),2) as highest_total_profit
from customer c
inner join fact_sales f 
using(customer_id)
group by c.customer_id, c.customer_name
order by sum(profit) desc; 

#Which customer segment contributes the highest revenue and profit
select c.segment, sum(f.sales) as highest_revenue, sum(f.profit) as highest_frofit
from customer c 
inner join fact_sales f 
using(customer_id)
group by c.segment
order by highest_revenue desc;

#On average, how much revenue does each customer generate?
SELECT
ROUND(AVG(total_revenue),2) AS average_revenue_per_customer
FROM
(
SELECT
customer_id,
SUM(sales) AS total_revenue
FROM fact_sales
GROUP BY customer_id
) t;

#Which customers have generated a negative total profit
with negative_total_profit as
( select c.customer_id,c.customer_name,
 sum(f.profit) as negative_profit
from customer c
inner join fact_sales f
using(customer_id)
group by c.customer_id,c.customer_name)
select customer_id,
customer_name,
negative_profit 
from negative_total_profit
where negative_profit<0;

#Which customers received the highest average discount?
select c.customer_id, c.customer_name, avg(f.discount) as high_avg_dis
from customer c
inner join fact_sales f
using(customer_id)
group by c.customer_id, c.customer_name
order by avg(f.discount) desc
limit 10;

#Which customers made the highest number of sales transactions?
select c.customer_id, c.customer_name, 
  count(*) as sales_transaction_count
  from customer c
  inner join fact_sales f
  using(customer_id)
  group by c.customer_id, c.customer_name
  order by sales_transaction_count desc; 
  
#Which customers purchased the largest quantity of products?
select c.customer_id, c.customer_name, 
  sum(f.quantity) as total_product_purchased
  from customer c
  inner join fact_sales f
  using(customer_id)
  group by c.customer_id, c.customer_name
  order by total_product_purchased desc; 
  
#Rank customers based on total sales revenue.
with total_sales as
  (select c.customer_id, customer_name, 
     sum(sales) as total_revenue
     from customer c
     inner join fact_sales f
     using(customer_id)
	 group by c.customer_id, customer_name)
select customer_id, customer_name,total_revenue, 
       dense_rank() over (order by total_revenue desc) as revenue_rank
from total_sales;
  
#Identify customers whose total sales are above the overall average customer sales.
with customer_sales as
	 (select customer_id,
     sum(sales) as total_revenue
     from fact_sales 
	 group by customer_id)
select c.customer_id, c.customer_name, s.total_revenue
from customer c 
inner join customer_sales s
using (customer_id)
where  total_revenue >
                  (
                  SELECT AVG(total_revenue)
                  FROM customer_sales
				  )
order by total_revenue DESC;
  
  

