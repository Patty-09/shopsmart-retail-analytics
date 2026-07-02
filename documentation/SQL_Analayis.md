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
