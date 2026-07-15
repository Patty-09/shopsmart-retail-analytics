#Time Analysis
use ShopSmart_Retail_Analytics;

#How has total revenue changed from year to year?
select year(order_date) as sales_yr,
round(sum(sales),2) as total_revenue,
round(sum(profit),2) as total_profit
from fact_sales f
group by year(order_date)
order by sales_yr desc;

#Which quarter generates the highest revenue?
select quarter(order_date) as over_quarter,
round(sum(sales),2) as total_revenue,
round(sum(profit),2) as total_profit
from fact_sales f
group by quarter(order_date)
order by total_revenue desc;

#Which month generates the highest revenue?
select month(order_date) as month_number,
monthname(order_date) as month_name,
round(sum(sales),2) as total_revenue,
round(sum(profit),2) as total_profit
from fact_sales f
group by month(order_date), monthname(order_date)
order by total_revenue desc;

#What is the average revenue generated in each month across all years
with month_yr_revenue as 
		(select monthname(order_date) as month_name,
                year(order_date) as year_name,
                sum(sales) as month_revenue
                from fact_sales
                group by monthname(order_date),
                         year(order_date)
		)select month_name,year_name,
round(month_revenue,2) as avg_revenue
from month_yr_revenue 
group by month_name, year_name
order by year_name desc;

#Which weekday generates the highest revenue?
select weekday(order_date)  as week_day,
dayname(order_date) as day_name,
round(sum(sales),2) as total_revenue,
round(sum(profit),2) as total_profit
from fact_sales
group by weekday(order_date),dayname(order_date)
ORDER BY total_revenue DESC;

#How many orders were placed in each month?
select monthname(order_date) as month_name,
count(distinct order_id) as no_orders
from orders
group by monthname(order_date)
order by no_orders desc;


#How does revenue change month over month?
with month_yr_revenue as 
		(select 
                year(order_date) as year_name,
                 month(order_date) as month_no,
                monthname(order_date) as month_name,
                sum(sales) as month_revenue
                from fact_sales
                group by year(order_date),
                month(order_date),
                monthname(order_date)
		)
select year_name,month_name,round(month_revenue,2) month_revenue,
                 round(lag(month_revenue) over(order by year_name,month_no),2) as prev_month,
                 round(month_revenue - lag(month_revenue) over(order by year_name,month_no),2) as revenue_diff
                 from month_yr_revenue
                 order by year_name; 
                 

#Which Year-Month combination generated the highest revenue?
with month_yr_revenue as 
	(select monthname(order_date) as month_name,
                year(order_date) as year_name,
                sum(sales) as month_revenue
                from fact_sales
                group by monthname(order_date),
                         year(order_date)
	)
    select year_name, month_name, month_revenue
    from month_yr_revenue 
    order by month_revenue desc
    limit 1;
    

#Compare revenue across quarters and identify seasonal patterns.
with quarter_revenue as
(select quarter(order_date) as qtr,
sum(sales) as total_revenue
from fact_sales
group by quarter(order_date))
select qtr,total_revenue,
       round((total_revenue/(select sum(total_revenue)
                       from quarter_revenue))*100,2) as revenue_percent
from quarter_revenue
order by total_revenue desc;

#Calculate the cumulative (running) revenue over time.
with month_revenue as
 (select monthname(order_date) as month_name,
       month(order_date) as month_no,
	   year(order_date) as yr,
       round(sum(sales),2) as total_revenue
       from fact_sales
       group by year(order_date),month(order_date),monthname(order_date))
select month_name, yr, total_revenue,
	   sum(total_revenue) over (order by yr,month_no ) as running_revenue
from month_revenue;

