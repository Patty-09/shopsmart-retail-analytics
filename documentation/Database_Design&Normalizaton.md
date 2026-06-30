# Database Design & Normalization

## Objective

The objective of this phase was to transform the cleaned Global Superstore dataset into a well-structured relational database suitable for business analysis and reporting.

The database design process included:

- Identifying business entities
- Defining entity relationships
- Selecting primary and foreign keys
- Applying normalization principles
- Validating the design against the actual dataset
- Refining the model based on data quality observations

---

# Business Entity Identification

After understanding the retail business process and analyzing the dataset, the following entities were identified.

| Entity | Description |
|----------|------------|
| Customer | Stores customer information and customer segment. |
| Category | Stores product categories and subcategories. |
| Product | Stores product details and category information. |
| Location | Stores geographical information including city, state, country, region, and market. |
| Sales Fact | Stores every product-level sales transaction and business measures. |

---

# Initial Conceptual Design

The initial conceptual model consisted of the following entities:

- Customer
- Order
- Order Item
- Product
- Category
- Shipping
- Location

Relationships between entities were identified based on the business process and documented using an Entity Relationship Diagram (ERD).

---

# Database Normalization

The database design followed normalization principles to reduce redundancy and improve data integrity.

## First Normal Form (1NF)

The following activities were completed:

- Removed completely duplicate records
- Removed unnecessary columns
- Ensured atomic values
- Standardized data types
- Converted Order Date and Ship Date into proper DATE format

---

## Second Normal Form (2NF)

Business entities were separated into independent tables to eliminate partial dependencies.

Separate tables were created for:

- Customer
- Category
- Product
- Location

---

## Third Normal Form (3NF)

Transitive dependencies were removed by separating descriptive information from transactional data.

Business measures such as:

- Sales
- Profit
- Quantity
- Discount
- Shipping Cost

were stored only within the transactional table, while descriptive attributes remained inside their respective dimension tables.

---

# Data Quality Validation

During implementation, several inconsistencies were discovered within the source dataset.

These observations significantly influenced the final database design.

## Product ID Inconsistency

The same Product ID was associated with multiple Product Names.

Example:

| Product ID | Product Name |
|------------|--------------|
| OFF-AR-10002677 | BIC Pens, Water Color |
| OFF-AR-10002677 | BIC Pencil Sharpener, Easy-Erase |

Because Product ID was not unique, a surrogate key (**product_key**) was introduced as the Primary Key for the Product table.

---

## Order ID Inconsistency

Multiple business transactions shared the same Order ID while belonging to different customers and dates.

Example:

| Order ID | Customer | Order Date |
|----------|----------|------------|
| AG-2012-2220 | Customer A | 26-12-2012 |
| AG-2012-2220 | Customer B | 09-11-2012 |

This demonstrated that Order ID could not uniquely identify a business transaction.

Therefore, Order ID was retained as a business attribute instead of being used as the database Primary Key.

---

## Shipping Cost Observation

During validation, Shipping Cost was found to vary between products belonging to the same order.

This indicates that Shipping Cost exists at the transaction (line item) level rather than the order level.

As a result:

- Shipping was not implemented as a separate entity.
- Shipping Cost became part of the Sales Fact table.

---

# Final Database Design

The final database follows a dimensional design consisting of four dimension tables and one fact table.

---

## Customer

**Primary Key**

- customer_id

**Attributes**

- customer_name
- segment

---

## Category

**Primary Key**

- category_id

**Attributes**

- category
- sub_category

---

## Product

**Primary Key**

- product_key (Surrogate Key)

**Attributes**

- product_id
- product_name
- category_id (Foreign Key)

---

## Location

**Primary Key**

- location_id

**Attributes**

- city
- state
- country
- region
- market

---

## Fact Sales

The Fact Sales table stores one row for every product sold within a customer order.

Each record represents a single sales transaction.

**Primary Key**

- transaction_id

**Foreign Keys**

- customer_id
- product_key
- category_id
- location_id

**Business Attributes**

- order_id
- order_date
- ship_date
- ship_mode
- order_priority

**Business Measures**

- quantity
- sales
- profit
- discount
- shipping_cost

---

# Final Database Schema

```
Customer
│
├── customer_id (PK)
├── customer_name
└── segment

Category
│
├── category_id (PK)
├── category
└── sub_category

Product
│
├── product_key (PK)
├── product_id
├── product_name
└── category_id (FK)

Location
│
├── location_id (PK)
├── city
├── state
├── country
├── region
└── market

Fact_Sales
│
├── transaction_id (PK)
├── customer_id (FK)
├── product_key (FK)
├── category_id (FK)
├── location_id (FK)
├── order_id
├── order_date
├── ship_date
├── ship_mode
├── order_priority
├── quantity
├── sales
├── profit
├── discount
└── shipping_cost
```

---

# Key Design Decisions

- Removed duplicate records during data preparation.
- Eliminated unnecessary columns before database implementation.
- Introduced surrogate keys where source identifiers were unreliable.
- Implemented a dimensional database structure suitable for analytical workloads.
- Preserved original business identifiers as descriptive attributes.
- Designed the database to support efficient SQL querying and Power BI reporting.

---

# Lessons Learned

This phase demonstrated that real-world datasets rarely contain perfect business keys.

Instead of forcing the source data into an incorrect structure, the database design was validated and refined based on actual data behavior.

Key lessons include:

- Business keys should always be validated before being used as Primary Keys.
- Surrogate keys provide reliable identifiers when source systems contain inconsistent data.
- Database design should be driven by business rules and actual data rather than assumptions.
- Dimensional modeling provides a scalable foundation for business intelligence and reporting.
