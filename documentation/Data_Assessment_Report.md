# Data Assessment Report

## 1. Dataset Overview

**Dataset Name:** Global Superstore

**Source:** Kaggle

**File Format:** CSV

### Dataset Summary

* Total Rows: **51,291**
* Total Columns: **27**

This dataset contains transactional retail sales data collected from multiple countries and markets. Each record represents a product sold within a customer order and includes customer details, product information, shipping details, location, and sales-related measures.


# 2. Data Quality Assessment

The dataset was reviewed before any cleaning or database design. The following observations were made.

| Column                                                       | Observation                            | Action                                            |
| ------------------------------------------------------------ | -------------------------------------- | ------------------------------------------------- |
| order_date                                                   | Stored as text initially               | Converted to Date format                          |
| ship_date                                                    | Stored as text initially               | Converted to Date format                          |
| row_id                                                       | Sequential identifier only             | Removed                                           |
| è®°å½•æ•°                                                    | Contains only the value 1 in every row | Removed                                           |
| Customer, Product and Order IDs                              | Duplicate values found                 | Expected behaviour in transactional data          |
| International city names (e.g., Montréal, São Paulo, Zürich) | Valid Unicode characters               | Retained without modification                     |
| Data Types                                                   | Reviewed                               | All remaining columns have appropriate data types |

---

# 3. Duplicate Analysis

### Duplicate Rows

* No completely duplicated rows were found in the dataset.

### Customer ID

Duplicate values are expected because one customer can place multiple orders over time.

### Product ID

Duplicate values are expected because the same product can be purchased by different customers.

### Order ID

Duplicate values are expected because one order may contain multiple products.

### Combination of Customer ID, Order ID and Product ID

A small number of duplicate combinations (35 records) were identified.

These records will be investigated further during the data cleaning phase before deciding whether they represent duplicate transactions or valid business records.

---

# 4. Initial Observations

During the initial assessment, the following business observations were made:

* The dataset follows a **transactional sales model** rather than storing one record per order.
* One customer can place multiple orders.
* One order can contain multiple products.
* One product can be purchased by many customers.
* The dataset contains information from multiple countries and global markets.
* Sales, Profit, Quantity, Discount and Shipping Cost appear to be numerical business measures.
* Customer, Product, Location and Shipping information are mixed together in a single table and should later be normalized into separate entities.

---

# 5. Entity Identification

Based on the dataset structure, the following business entities have been identified.

### Customer

Contains information related to customers.

Possible attributes:

* customer_id
* customer_name
* segment

---

### Product

Contains product-related information.

Possible attributes:

* product_id
* product_name
* category
* sub_category

---

### Orders

Contains order-level information.

Possible attributes:

* order_id
* order_date
* order_priority

---

### Shipping

Contains shipping details.

Possible attributes:

* ship_date
* ship_mode
* shipping_cost

---

### Location

Contains geographical information.

Possible attributes:

* city
* state
* country
* region
* market
* market2

---

### Sales (Fact)

Contains business measures.

Possible measures:

* sales
* profit
* quantity
* discount

---

# 6. Dataset Statistics

| Attribute         | Unique Values |
| ----------------- | ------------: |
| Customers         |         4,873 |
| Products          |         3,788 |
| Cities            |         3,637 |
| States            |         1,094 |
| Countries         |           147 |
| Regions           |            13 |
| Markets           |             7 |
| Market2           |             6 |
| Customer Segments |             3 |
| Sub-Categories    |            17 |

Customer Segments:

* Consumer
* Corporate
* Home Office

---

# 7. Conclusion

The dataset is suitable for analytical reporting and data warehouse design. No fully duplicated records were found, and the duplicate IDs observed are consistent with transactional retail data.

The next phase of the project will focus on understanding the relationships between these business entities, designing a normalized database schema, and creating an Entity Relationship Diagram (ERD) before importing the data into MySQL.

