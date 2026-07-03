# SQL Business Analysis

## Overview

After designing and implementing the normalized database, the next phase focused on answering business questions using SQL. Instead of writing queries only for practice, each query was written to solve a specific business problem that could help decision-makers understand business performance.

Throughout this phase, I gradually improved my SQL thinking by focusing on writing cleaner queries, reducing unnecessary joins, and choosing the most appropriate SQL functions for each problem.

---

# Chapter 1: Database Validation

## Objective

Before starting business analysis, I validated the database to ensure that the imported data was complete, consistent, and ready for analysis.

The validation included:

- Total sales transactions
- Total customers
- Total products
- Category and subcategory counts
- Location coverage
- Order date range
- Shipping date range
- Available customer segments
- Shipping modes
- Missing value checks

## Key Learning

Initially, I tried solving some validation tasks using more complex approaches such as joins and window functions. During review, I learned that many of these questions could be answered more efficiently using aggregate functions like `COUNT()`, `MIN()`, and `MAX()` directly on the fact table.

This helped me understand that writing SQL is not only about getting the correct result but also about choosing the simplest and most efficient solution.

---

# Chapter 2: Business KPI Analysis

## Objective

The purpose of this phase was to calculate the key business metrics that provide a quick overview of company performance.

The KPIs included:

- Total Revenue
- Total Profit
- Total Quantity Sold
- Average Transaction Value
- Average Profit per Transaction
- Profit Margin
- Average Discount
- Average Shipping Cost
- Highest Sales Transaction
- Highest Profit Transaction

## Key Learning

While calculating KPIs, I realized the importance of understanding the business meaning behind each metric instead of directly applying SQL functions.

One important example was **Average Order Value**. Since the source dataset contained duplicate Order IDs, calculating the traditional Average Order Value would produce misleading results. Instead, I calculated the **Average Transaction Value**, which better represents the available data.

This phase strengthened my understanding that business knowledge is just as important as SQL syntax.

---

# Chapter 3: Customer Analysis

## Objective

This chapter focused on understanding customer purchasing behavior and identifying the company's most valuable customers.

The analysis included:

- Top customers by revenue
- Top customers by profit
- Segment performance
- Average revenue per customer
- Customers generating losses
- Customers receiving the highest discounts
- Most active customers
- Customers purchasing the highest quantity
- Customer revenue ranking
- High-value customers

## Key Learning

This chapter required much more analytical thinking than the previous ones.

While writing these queries, I learned to:

- Decide when joins were actually required.
- Replace unnecessary subqueries with simpler solutions.
- Use Common Table Expressions (CTEs) to improve readability.
- Apply window functions such as `DENSE_RANK()` for customer ranking.
- Differentiate between transaction-level metrics and customer-level metrics.

I also realized that answering business questions correctly depends on understanding the business definition of each metric rather than simply writing SQL that executes successfully.

---

## Progress Reflection

Compared to the beginning of this project, my approach to SQL has changed significantly.

Initially, I focused mainly on writing queries that produced the correct output.

Now, I pay attention to:

- Query readability
- Business interpretation
- Efficient SQL logic
- Proper use of aggregate functions
- Reducing unnecessary joins
- Writing SQL that could be used in real business reporting

Each review helped me improve not only the correctness of my SQL but also the way I think about solving analytical problems.

# Chapter 4: Sales Analysis

## Objective

The goal of this chapter was to understand the company's overall sales performance by analyzing revenue, profit, shipping methods, customer segments, and transaction-level performance.

The analysis included:

- Revenue trend by year
- Profit trend by year
- Revenue by order priority
- Revenue by shipping mode
- Average transaction value by shipping mode
- Top revenue transactions
- Top profit transactions
- Revenue contribution by customer segment
- Profit contribution by customer segment
- High discount transactions

## Key Learning

This chapter helped me understand the difference between simply writing SQL queries and answering business questions correctly.

Initially, I made a few logical mistakes while calculating percentage contribution. I used ranking functions such as `CUME_DIST()` even though the business question required percentage contribution. During review, I learned that percentage contribution should always be calculated as:

`Part / Total × 100`

I also learned that ranking functions are only useful when the goal is to rank records rather than calculate business percentages.

Another improvement was understanding the importance of grouping data at the correct level. For example, I learned the difference between transaction-level metrics and overall business metrics.

By the end of this chapter, I became more comfortable using CTEs, aggregate functions, and writing queries that answered business questions more accurately.

---

# Chapter 5: Product Analysis

## Objective

This chapter focused on identifying the products and product categories that contribute the most to the company's sales and profit.

The analysis included:

- Top products by revenue
- Top products by profit
- Lowest profit products
- Category performance
- Subcategory performance
- Best-selling products by quantity
- Most frequently ordered products
- Products with the highest average discount
- Product revenue ranking
- High-value products

## Key Learning

This chapter improved my understanding of product-level analysis.

One important mistake I made was calculating profit percentage using total sales instead of total profit. After correcting it, I understood that every business percentage must use the correct denominator.

I also learned the difference between:

- Total quantity sold
- Number of sales transactions

These two metrics answer completely different business questions even though they use the same dataset.

Another improvement was learning to avoid rounding values inside CTEs. Instead, I now perform all calculations using original values and round only in the final output, which is a better practice for maintaining accuracy.

Overall, this chapter helped me write cleaner SQL queries while improving my understanding of business metrics.

---

# Chapter 6: Regional Analysis

## Objective

The purpose of this chapter was to identify the geographical areas that contribute the most to company revenue and profit.

The analysis included:

- Revenue by market
- Revenue by region
- Top countries by revenue
- Top states by revenue
- Top cities by revenue
- Lowest profit countries
- Average revenue by country
- Market ranking
- High-performing regions
- Revenue contribution by market

## Key Learning

This chapter strengthened my understanding of location-based business analysis.

One improvement I noticed was that I no longer added unnecessary table joins. Since all geographical information was available in the Location table, I learned to keep the queries simple by joining only the required tables.

I also made a small logical mistake while calculating average revenue by country. Initially, I calculated the average of already aggregated values, which did not provide meaningful business insight. After reviewing the query, I understood that I should calculate the average transaction revenue instead.

Compared to the earlier chapters, I also became more consistent in writing readable SQL by using meaningful aliases, CTEs, and proper ordering of results.

This chapter also reinforced the importance of understanding the business meaning behind every calculation instead of focusing only on SQL syntax.

---

## Progress Reflection

After completing these chapters, I can see a clear improvement in both my SQL skills and my analytical thinking.

At the beginning of this project, I mainly focused on writing queries that produced the expected output. Now, I spend more time understanding the business question before writing SQL.

Some areas where I improved include:

- Writing cleaner and more readable SQL queries.
- Using CTEs whenever they improve readability.
- Reducing unnecessary joins.
- Understanding the difference between ranking and percentage contribution.
- Choosing the correct aggregation level for each business question.
- Thinking about the business meaning of every metric before writing the query.

This project has helped me move beyond learning SQL syntax and start solving real business problems using SQL.
