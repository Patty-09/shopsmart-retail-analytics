# Business Requirements

## Project Background
ShopSmart Retail is a global retail business that sells products across multiple countries, markets, and customer segments. Every customer order contains information related to products, shipping, location, discounts, sales, and profit.

The objective of this project is to transform raw transactional data into meaningful business insights by designing a structured database, performing SQL analysis, and building interactive dashboards.

# Business Objective

The primary objective is to help business stakeholders understand sales performance, customer purchasing behavior, product performance, and regional trends to support better business decisions.

The project aims to answer questions such as:

* Which products generate the highest sales?
* Which products generate the highest profit?
* Which regions contribute the most revenue?
* Which customer segments are the most valuable?
* Which products require marketing attention due to low demand?
* How do discounts affect profitability?
* Which shipping methods are most frequently used?

# Business Rules

The following business rules were identified during the requirement gathering phase.

1. One customer can place multiple orders.
2. Each order belongs to one customer.
3. One order can contain one or more products.
4. One product can appear in multiple customer orders.
5. Each order is shipped using one shipping mode.
6. Each order has one shipping destination.
7. One category contains multiple products.
8. Each sub-category belongs to one category.
9. Product profitability may vary across different regions and markets.
10. Sales, Quantity, Profit, Discount, and Shipping Cost are recorded for every product sold.

# Business Process

The business process followed by ShopSmart Retail can be summarized as:

Customer places an order → The order is created → One or more products are added to the order → A shipping method is assigned → The order is delivered to the customer → Sales and profit are recorded → Business performance is analyzed for reporting and decision-making.

# Candidate Business Entities

The following entities were identified from the dataset.

* Customer
* Orders
* Products
* Shipping
* Category
* Location
* Order Items (Bridge Entity)
* Sales Fact

These entities will later be normalized and converted into relational database tables.


# Candidate Measures

The project will analyze the following business measures:

* Sales
* Profit
* Quantity
* Discount
* Shipping Cost

These measures will form the Fact Table of the analytical model.

# Candidate Dimensions

The following descriptive dimensions were identified:

* Customer
* Product
* Category
* Order
* Shipping
* Location

These dimensions will provide context for analyzing the business measures.

# Expected Business KPIs

The project is expected to generate insights including:

### Product Performance

* Best-selling products
* Most profitable products
* Lowest-performing products
* Sales by category
* Sales by sub-category

### Customer Analysis

* Top customers by sales
* Customer purchasing behavior
* Sales by customer segment

### Regional Analysis

* Sales by country
* Sales by state
* Sales by city
* Sales by market
* Sales by region

### Shipping Analysis

* Most frequently used shipping mode
* Shipping cost by region
* Average shipping cost per order

### Financial Analysis

* Total Sales
* Total Profit
* Profit Margin
* Average Order Value
* Discount Analysis

# Proposed Database Design

Based on the business understanding, the database will be designed using normalization principles to reduce redundancy and improve data integrity.

The expected entities include:

* Customer
* Orders
* Products
* Order Items
* Shipping
* Location
* Category

These tables will later be connected using primary and foreign key relationships before building the analytical star schema.


# Deliverables

The final project will include:

* Normalized relational database
* SQL scripts for database creation
* Data cleaning and transformation
* Exploratory SQL analysis
* Business KPIs
* Excel dashboard
* Power BI dashboard
* Complete project documentation

# Conclusion

This requirement gathering phase helped identify the business entities, relationships, business rules, analytical measures, and reporting requirements before starting database design. Completing this step ensures that the database structure and analytical solution are aligned with real business needs rather than being driven only by the dataset.
