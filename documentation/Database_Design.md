# Database Design

## Overview

After understanding the business requirements and assessing the dataset, the next step was to design a normalized relational database. Instead of importing the CSV file directly into multiple tables, the database structure was designed first by identifying business entities, defining their attributes, establishing relationships, and determining the appropriate keys.

The objective of this phase is to reduce data redundancy, maintain data integrity, and build a scalable database that accurately represents the retail business.

# Database Design Approach

The database was designed using the following steps:

1. Identify business entities from the dataset.
2. Define attributes for each entity.
3. Identify Candidate Keys and select Primary Keys.
4. Establish relationships between entities.
5. Determine Foreign Keys.
6. Define relationship cardinality.
7. Design the Entity Relationship (ER) Diagram.
8. Create the physical database in MySQL.


# Business Entities

Seven business entities were identified from the dataset.

| Entity     | Purpose                                                                   |
| ---------- | ------------------------------------------------------------------------- |
| Customer   | Stores customer information.                                              |
| Orders     | Stores order transaction details.                                         |
| Product    | Stores product information.                                               |
| Category   | Stores product categories and sub-categories.                             |
| Order_Item | Stores products purchased within each order along with business measures. |
| Location   | Stores geographical information related to order delivery.                |
| Shipping   | Stores available shipping methods.                                        |

# Entity Attributes

## Customer

| Attribute        | Description                                          |
| ---------------- | ---------------------------------------------------- |
| customer_id (PK) | Unique identifier for each customer.                 |
| customer_name    | Name of the customer.                                |
| segment          | Customer segment (Consumer, Corporate, Home Office). |

Customer information is stored separately because one customer can place multiple orders.

## Orders

| Attribute        | Description                                   |
| ---------------- | --------------------------------------------- |
| order_id (PK)    | Unique identifier for each order.             |
| order_date       | Date when the order was placed.               |
| order_priority   | Priority assigned to the order.               |
| customer_id (FK) | References the customer who placed the order. |
| location_id (FK) | References the delivery location.             |
| shipping_id (FK) | References the shipping method used.          |

The Orders table acts as the central transaction table connecting customers, shipping information, and delivery locations.


## Product

| Attribute        | Description                         |
| ---------------- | ----------------------------------- |
| product_id (PK)  | Unique identifier for each product. |
| product_name     | Product name.                       |
| category_id (FK) | References the product category.    |

Products are stored independently because the same product can appear in multiple customer orders.

## Category

| Attribute        | Description                 |
| ---------------- | --------------------------- |
| category_id (PK) | Unique category identifier. |
| category         | Product category.           |
| sub_category     | Product sub-category.       |

Categories are separated to avoid repeating category information for every product.


## Order_Item

| Attribute          | Description                            |
| ------------------ | -------------------------------------- |
| order_item_id (PK) | Unique identifier for each order line. |
| order_id (FK)      | References the associated order.       |
| product_id (FK)    | References the purchased product.      |
| quantity           | Quantity purchased.                    |
| sales              | Sales amount.                          |
| profit             | Profit generated.                      |
| discount           | Discount applied.                      |

This table resolves the many-to-many relationship between Orders and Products while storing transaction-level business measures.

## Location

| Attribute        | Description                 |
| ---------------- | --------------------------- |
| location_id (PK) | Unique location identifier. |
| city             | Delivery city.              |
| state            | Delivery state.             |
| country          | Delivery country.           |
| region           | Business region.            |
| market           | Business market.            |

Location information is separated because many orders can be delivered to the same location.

## Shipping

| Attribute        | Description                        |
| ---------------- | ---------------------------------- |
| shipping_id (PK) | Unique shipping identifier.        |
| ship_mode        | Shipping method used for delivery. |

Shipping methods are stored separately to eliminate repeated shipping mode values across multiple orders.


# Key Design

## Candidate Key

A Candidate Key is the minimum attribute (or combination of attributes) capable of uniquely identifying each record in a table.

Candidate Keys identified:

| Table      | Candidate Key |
| ---------- | ------------- |
| Customer   | customer_id   |
| Orders     | order_id      |
| Product    | product_id    |
| Category   | category_id   |
| Location   | location_id   |
| Shipping   | shipping_id   |
| Order_Item | order_item_id |

## Primary Key

Each Candidate Key was selected as the Primary Key because it uniquely identifies every record while maintaining simplicity and stability.

## Foreign Keys

| Table      | Foreign Key | References |
| ---------- | ----------- | ---------- |
| Orders     | customer_id | Customer   |
| Orders     | location_id | Location   |
| Orders     | shipping_id | Shipping   |
| Product    | category_id | Category   |
| Order_Item | order_id    | Orders     |
| Order_Item | product_id  | Product    |

Foreign Keys maintain referential integrity between related entities.


# Relationship Cardinality

| Relationship         | Cardinality | Reason                                                                                          |
| -------------------- | ----------- | ----------------------------------------------------------------------------------------------- |
| Customer → Orders    | 1 : M       | One customer can place multiple orders, but each order belongs to one customer.                 |
| Orders → Order_Item  | 1 : M       | One order can contain multiple products.                                                        |
| Product → Order_Item | 1 : M       | One product can appear in multiple orders.                                                      |
| Category → Product   | 1 : M       | One category contains multiple products.                                                        |
| Location → Orders    | 1 : M       | One location can receive many orders, while each order has one delivery location.               |
| Shipping → Orders    | 1 : M       | One shipping method can be used for multiple orders, while each order uses one shipping method. |

# Normalization

The database structure was designed following normalization principles.

* Customer, Product, Category, Location, and Shipping information were separated to eliminate redundancy.
* The many-to-many relationship between Orders and Products was resolved using the Order_Item table.
* Business measures such as Sales, Profit, Quantity, and Discount were stored in the Order_Item table because they are transaction-specific.

This design improves data integrity, reduces duplication, and supports efficient analytical queries.

# Next Phase

After completing the logical database design, the next phase is to:

1. Create the database in MySQL.
2. Import the cleaned dataset into a staging table.
3. Create normalized tables.
4. Populate each table using SQL.
5. Apply Primary Key and Foreign Key constraints.
6. Validate relationships before beginning SQL analysis.
