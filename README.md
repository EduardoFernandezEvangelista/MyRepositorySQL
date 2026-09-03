# 🗄️ SQL — Complete Database Guide

> A practical guide to **SQL and MySQL**, created for study, reference, and use in real database projects.

This material covers everything from creating a database to more advanced operations, such as **relationships, JOINs, aggregations, subqueries, transactions, views, indexes, and data transfer**.

---

# 🧠 1. Introduction

**SQL (Structured Query Language)** is a language used to work with relational databases.

With SQL, you can:

* Create databases
* Create and modify tables
* Insert information
* Query data
* Update records
* Delete records
* Create relationships
* Query data from multiple tables
* Group and analyze information
* Control transactions
* Create views and indexes

### Basic Flow

```text
Database
   │
   ├── Tables
   │      │
   │      ├── Columns
   │      └── Records
   │
   └── Relationships
          │
          ├── 1:1
          ├── 1:N
          └── N:N
```

---

# 🗃️ 2. Database

## Main Commands

| Command           | Function            | Example                  |
| ----------------- | ------------------- | ------------------------ |
| `CREATE DATABASE` | Creates a database  | `CREATE DATABASE store;` |
| `DROP DATABASE`   | Deletes a database  | `DROP DATABASE store;`   |
| `SHOW DATABASES`  | Lists the databases | `SHOW DATABASES;`        |
| `USE`             | Selects a database  | `USE store;`             |

### Create a Database

```sql
CREATE DATABASE store;
```

### Select a Database

```sql
USE store;
```

### List Databases

```sql
SHOW DATABASES;
```

### Delete a Database

```sql
DROP DATABASE store;
```

> ⚠️ `DROP DATABASE` deletes the database and all its tables.

---

# 📋 3. Tables

| Command             | Function                             |
| ------------------- | ------------------------------------ |
| `CREATE TABLE`      | Creates a table                      |
| `ALTER TABLE`       | Changes an existing table            |
| `DROP TABLE`        | Deletes a table                      |
| `TRUNCATE`          | Removes all records                  |
| `DESCRIBE`          | Shows the table structure            |
| `SHOW CREATE TABLE` | Shows the SQL used to create a table |

## CREATE TABLE

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(150)
);
```

## ALTER TABLE

Add a column:

```sql
ALTER TABLE users
ADD phone VARCHAR(20);
```

Change a column:

```sql
ALTER TABLE users
MODIFY name VARCHAR(200);
```

Rename a column:

```sql
ALTER TABLE users
RENAME COLUMN name TO full_name;
```

## DROP TABLE

```sql
DROP TABLE users;
```

Completely removes the table.

## TRUNCATE

```sql
TRUNCATE TABLE users;
```

Removes all records while keeping the table structure.

### DROP x TRUNCATE

| Command      | Removes Data | Removes Table |
| ------------ | ------------ | ------------- |
| `DELETE`     | ✅            | ❌             |
| `TRUNCATE`   | ✅            | ❌             |
| `DROP TABLE` | ✅            | ✅             |

## DESCRIBE

```sql
DESCRIBE users;
```

## SHOW CREATE TABLE

```sql
SHOW CREATE TABLE users;
```

---

# 🔤 4. Data Types

| Type       | Usage                | Example                 |
| ---------- | -------------------- | ----------------------- |
| `INT`      | Whole numbers        | `100`                   |
| `BIGINT`   | Large whole numbers  | `999999999`             |
| `DECIMAL`  | Monetary values      | `199.90`                |
| `FLOAT`    | Decimal numbers      | `10.5`                  |
| `CHAR`     | Fixed-length text    | `'BR'`                  |
| `VARCHAR`  | Variable-length text | `'Eduardo'`             |
| `TEXT`     | Long text            | `'Description...'`      |
| `DATE`     | Date                 | `'2026-09-03'`          |
| `DATETIME` | Date and time        | `'2026-09-03 13:30:00'` |
| `TIME`     | Time                 | `'13:30:00'`            |
| `BOOLEAN`  | True/False           | `TRUE`                  |
| `JSON`     | JSON data            | `'{"name":"Edu"}'`      |

### Example

```sql
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    created_at DATETIME
);
```

---

# 🔒 5. Constraints

Constraints are rules applied to columns to maintain **data integrity**.

| Constraint       | Function                              |
| ---------------- | ------------------------------------- |
| `PRIMARY KEY`    | Identifies each record                |
| `FOREIGN KEY`    | Creates a relationship between tables |
| `UNIQUE`         | Prevents duplicate values             |
| `NOT NULL`       | Prevents NULL values                  |
| `DEFAULT`        | Defines a default value               |
| `CHECK`          | Validates a condition                 |
| `AUTO_INCREMENT` | Generates numbers automatically       |

## PRIMARY KEY

```sql
id INT PRIMARY KEY AUTO_INCREMENT
```

Each record has a unique identifier.

## FOREIGN KEY

```sql
user_id INT,

FOREIGN KEY (user_id)
REFERENCES users(id)
```

Creates a relationship between tables.

## UNIQUE

```sql
email VARCHAR(150) UNIQUE
```

Does not allow two users to have the same email.

## NOT NULL

```sql
name VARCHAR(100) NOT NULL
```

The field must receive a value.

## DEFAULT

```sql
status VARCHAR(20) DEFAULT 'active'
```

If no value is provided:

```text
status = active
```

## CHECK

```sql
age INT CHECK (age >= 18)
```

## AUTO_INCREMENT

```sql
id INT AUTO_INCREMENT PRIMARY KEY
```

Example:

```text
1
2
3
4
5
...
```

---

# ➕ 6. INSERT

Used to insert records.

```sql
INSERT INTO users (name, email)
VALUES ('John', 'john@email.com');
```

Insert multiple records:

```sql
INSERT INTO users (name, email)
VALUES
('John', 'john@email.com'),
('Maria', 'maria@email.com'),
('Peter', 'peter@email.com');
```

---

# 🔎 7. SELECT

Used to query data.

```sql
SELECT * FROM users;
```

Select specific columns:

```sql
SELECT name, email
FROM users;
```

Create an alias:

```sql
SELECT name AS user
FROM users;
```

---

# 🎯 8. WHERE

Filters records.

```sql
SELECT *
FROM users
WHERE id = 1;
```

Another example:

```sql
SELECT *
FROM products
WHERE price > 100;
```

---

# ⚙️ 9. Operators

| Operator | Meaning          |
| -------- | ---------------- |
| `=`      | Equal            |
| `<>`     | Not equal        |
| `!=`     | Not equal        |
| `>`      | Greater than     |
| `<`      | Less than        |
| `>=`     | Greater or equal |
| `<=`     | Less or equal    |
| `AND`    | And              |
| `OR`     | Or               |
| `NOT`    | Negation         |

### Example

```sql
SELECT *
FROM products
WHERE price >= 100
AND stock > 0;
```

---

# 🔤 10. LIKE

Searches for text patterns.

| Symbol | Function                 |
| ------ | ------------------------ |
| `%`    | Any number of characters |
| `_`    | One single character     |

### Starts With

```sql
SELECT *
FROM users
WHERE name LIKE 'Jo%';
```

### Ends With

```sql
SELECT *
FROM users
WHERE name LIKE '%Silva';
```

### Contains

```sql
SELECT *
FROM users
WHERE name LIKE '%ana%';
```

---

# 📌 11. IN

Checks if a value belongs to a list.

```sql
SELECT *
FROM products
WHERE category_id IN (1, 2, 3);
```

Equivalent to:

```sql
WHERE category_id = 1
   OR category_id = 2
   OR category_id = 3;
```

---

# 📅 12. BETWEEN

Searches for values inside a range.

```sql
SELECT *
FROM products
WHERE price BETWEEN 100 AND 500;
```

It can also be used with dates:

```sql
SELECT *
FROM orders
WHERE order_date
BETWEEN '2026-01-01' AND '2026-12-31';
```

---

# ❓ 13. NULL

`NULL` represents the absence of a value.

### Find NULL Values

```sql
SELECT *
FROM users
WHERE phone IS NULL;
```

### Find Filled Values

```sql
SELECT *
FROM users
WHERE phone IS NOT NULL;
```

> Do not use `= NULL`.

Use:

```sql
IS NULL
```

or:

```sql
IS NOT NULL
```

---

# ↕️ 14. ORDER BY

Sorts the results.

### Ascending

```sql
SELECT *
FROM products
ORDER BY price ASC;
```

### Descending

```sql
SELECT *
FROM products
ORDER BY price DESC;
```

---

# 🔢 15. LIMIT

Limits the number of results.

```sql
SELECT *
FROM products
LIMIT 10;
```

Example with sorting:

```sql
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
```

---

# 🔀 16. DISTINCT

Removes duplicate values.

```sql
SELECT DISTINCT category_id
FROM products;
```

---

# ✏️ 17. UPDATE

Updates existing records.

```sql
UPDATE users
SET name = 'Carlos'
WHERE id = 1;
```

Updating multiple fields:

```sql
UPDATE users
SET name = 'Carlos',
    email = 'carlos@email.com'
WHERE id = 1;
```

> ⚠️ Always be careful with `UPDATE` without a `WHERE`.

---

# 🗑️ 18. DELETE

Removes records.

```sql
DELETE FROM users
WHERE id = 5;
```

Remove all records:

```sql
DELETE FROM users;
```

### DELETE x TRUNCATE

| Feature                       | DELETE | TRUNCATE |
| ----------------------------- | ------ | -------- |
| Removes records               | ✅      | ✅        |
| Can use `WHERE`               | ✅      | ❌        |
| Keeps the table               | ✅      | ✅        |
| Useful for specific deletions | ✅      | ❌        |

---

# 🔗 19. Relationships

Relationships describe how tables are connected.

---

## 1:1 — One to One

One record has a relationship with only one record in another table.

```text
USER
   │
   │ 1:1
   ▼
PROFILE
```

Example:

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE profiles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
);
```

The `UNIQUE` constraint prevents one user from having multiple profiles.

---

## 1:N — One to Many

One record can have several related records.

```text
CUSTOMER
   │
   ├── ORDER
   ├── ORDER
   └── ORDER
```

Example:

```sql
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,

    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
);
```

One customer can have multiple orders.

---

## N:1 — Many to One

This is the opposite view of the `1:N` relationship.

```text
ORDER ──────► CUSTOMER
  N              1
```

Many orders belong to one customer.

---

## N:N — Many to Many

Multiple records from one table can be related to multiple records from another table.

Example:

```text
STUDENTS
   │
   │
   ▼
ENROLLMENTS
   ▲
   │
   │
COURSES
```

Intermediate table:

```sql
CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES students(id),

    FOREIGN KEY (course_id)
    REFERENCES courses(id)
);
```

> In relational databases, an `N:N` relationship is normally implemented using an **associative/intermediate table**.

---

# 🔗 20. JOIN

`JOIN` combines information from different tables.

---

## INNER JOIN

Returns only records that have a match in both tables.

```sql
SELECT
    customers.name,
    orders.id
FROM customers
INNER JOIN orders
    ON orders.customer_id = customers.id;
```

```text
CUSTOMER ───── ORDER
    │             │
    └──── JOIN ───┘
```

---

## LEFT JOIN

Returns all records from the left table.

```sql
SELECT
    customers.name,
    orders.id
FROM customers
LEFT JOIN orders
    ON orders.customer_id = customers.id;
```

Even customers without orders will appear.

---

## RIGHT JOIN

Returns all records from the right table.

```sql
SELECT
    customers.name,
    orders.id
FROM customers
RIGHT JOIN orders
    ON orders.customer_id = customers.id;
```

---

## Multiple JOINs

It is possible to connect several tables.

```sql
SELECT
    customers.name,
    orders.id,
    products.name
FROM customers

INNER JOIN orders
    ON orders.customer_id = customers.id

INNER JOIN order_items
    ON order_items.order_id = orders.id

INNER JOIN products
    ON products.id = order_items.product_id;
```

### Structure

```text
CUSTOMER
   │
   ▼
ORDER
   │
   ▼
ORDER_ITEM
   │
   ▼
PRODUCT
```

---

# 📊 21. Aggregation

Aggregate functions work with multiple records.

| Function  | Purpose            |
| --------- | ------------------ |
| `COUNT()` | Counts records     |
| `SUM()`   | Adds values        |
| `AVG()`   | Calculates average |
| `MAX()`   | Highest value      |
| `MIN()`   | Lowest value       |

### COUNT

```sql
SELECT COUNT(*) AS total
FROM users;
```

### SUM

```sql
SELECT SUM(price) AS total
FROM products;
```

### AVG

```sql
SELECT AVG(price) AS average
FROM products;
```

### MAX

```sql
SELECT MAX(price) AS highest
FROM products;
```

### MIN

```sql
SELECT MIN(price) AS lowest
FROM products;
```

---

# 📦 22. GROUP BY

Groups records.

```sql
SELECT
    category_id,
    COUNT(*) AS quantity
FROM products
GROUP BY category_id;
```

Conceptual result:

```text
category | quantity
---------|----------
1        | 10
2        | 5
3        | 8
```

---

# 🎯 23. HAVING

Filters groups created by `GROUP BY`.

```sql
SELECT
    category_id,
    COUNT(*) AS quantity
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;
```

### WHERE x HAVING

| Command  | Filters                 |
| -------- | ----------------------- |
| `WHERE`  | Records before grouping |
| `HAVING` | Groups after grouping   |

---

# 🧩 24. Subqueries

A subquery is a query inside another query.

Example:

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

This query returns products whose price is above the average.

### Structure

```text
Main SELECT
      │
      └── Subquery
             │
             └── Calculates the average
```

---

# 🔍 25. EXISTS

Checks if a subquery returns any result.

```sql
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.id
);
```

Returns customers who have at least one order.

---

# 🔀 26. UNION

Combines the results of two queries.

```sql
SELECT name
FROM customers

UNION

SELECT name
FROM suppliers;
```

The queries must have a compatible number and type of columns.

### UNION ALL

```sql
SELECT name
FROM customers

UNION ALL

SELECT name
FROM suppliers;
```

`UNION` removes duplicates.

`UNION ALL` keeps duplicates.

---

# 🔀 27. CASE

Allows conditions inside a `SELECT`.

```sql
SELECT
    name,
    price,

    CASE
        WHEN price < 100 THEN 'Cheap'
        WHEN price < 500 THEN 'Medium'
        ELSE 'Expensive'
    END AS classification

FROM products;
```

Result:

```text
Product     Price     Classification
-------------------------------------
Mouse       50        Cheap
Keyboard    200       Medium
Monitor     900       Expensive
```

---

# 🧱 28. COALESCE

Returns the first value that is not `NULL`.

```sql
SELECT
    name,
    COALESCE(phone, 'Not informed') AS phone
FROM users;
```

If `phone` is `NULL`, the result will be:

```text
Not informed
```

---

# 📋 29. Copying Data

It is possible to copy data from one table to another.

## INSERT INTO SELECT

```sql
INSERT INTO users_backup
SELECT *
FROM users;
```

We can also select specific columns:

```sql
INSERT INTO users_backup (name, email)
SELECT name, email
FROM users;
```

### Practical Example

Original table:

```text
users
```

Backup table:

```text
users_backup
```

Process:

```text
users
   │
   │ SELECT
   ▼
users_backup
```

---

# 🚚 30. Data Transfer

It is possible to move records from one table to another.

First, copy the records:

```sql
INSERT INTO active_users (name, email)
SELECT name, email
FROM users
WHERE status = 'active';
```

Then remove the original records:

```sql
DELETE FROM users
WHERE status = 'active';
```

### Safe Approach

This type of operation is a good candidate for a **transaction**:

```sql
START TRANSACTION;

INSERT INTO active_users (name, email)
SELECT name, email
FROM users
WHERE status = 'active';

DELETE FROM users
WHERE status = 'active';

COMMIT;
```

If there is a problem:

```sql
ROLLBACK;
```

---

# 💳 31. Transactions

Transactions allow multiple operations to be executed as a single unit.

Main commands:

| Command             | Function               |
| ------------------- | ---------------------- |
| `START TRANSACTION` | Starts a transaction   |
| `COMMIT`            | Confirms changes       |
| `ROLLBACK`          | Undoes changes         |
| `SAVEPOINT`         | Creates a return point |

### Example

```sql
START TRANSACTION;

UPDATE accounts
SET balance = balance - 100
WHERE id = 1;

UPDATE accounts
SET balance = balance + 100
WHERE id = 2;

COMMIT;
```

If an error occurs:

```sql
ROLLBACK;
```

### Concept

```text
START TRANSACTION
       │
       ├── UPDATE
       ├── UPDATE
       ├── INSERT
       │
       ▼
    COMMIT
       │
       ▼
Changes confirmed
```

---

# 👁️ 32. VIEW

A `VIEW` is a stored query that can be used like a virtual table.

### Create

```sql
CREATE VIEW customer_orders AS

SELECT
    customers.name,
    orders.id
FROM customers

INNER JOIN orders
    ON orders.customer_id = customers.id;
```

Query:

```sql
SELECT *
FROM customer_orders;
```

Delete:

```sql
DROP VIEW customer_orders;
```

### Advantages

* Simplifies complex queries
* Allows query reuse
* Makes reports easier
* Helps control which columns are exposed

---

# ⚡ 33. INDEX

Indexes help the database find records more efficiently.

### Create an Index

```sql
CREATE INDEX idx_email
ON users(email);
```

### Unique Index

```sql
CREATE UNIQUE INDEX idx_email
ON users(email);
```

### Remove an Index

```sql
DROP INDEX idx_email
ON users;
```

### When Should You Use It?

Indexes are especially useful for columns frequently used in:

```sql
WHERE
JOIN
ORDER BY
```

> ⚠️ Indexes are not free: they use storage space and can increase the cost of `INSERT`, `UPDATE`, and `DELETE`. They should be used carefully.

---

# 🔄 34. ON DELETE / ON UPDATE

Control what happens to a `FOREIGN KEY` when the related record is changed or deleted.

### CASCADE

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

If the customer is deleted, its dependent records will also be deleted.

### RESTRICT

```sql
ON DELETE RESTRICT
```

Prevents deletion when related records exist.

### SET NULL

```sql
ON DELETE SET NULL
```

Sets the foreign key to `NULL`.

The column must allow `NULL` values.

### Summary

| Action      | Behavior                                  |
| ----------- | ----------------------------------------- |
| `CASCADE`   | Propagates changes/deletions              |
| `RESTRICT`  | Prevents the operation                    |
| `SET NULL`  | Sets the foreign key to `NULL`            |
| `NO ACTION` | Keeps the restriction behavior as defined |

---

# 🧩 35. CRUD

CRUD represents the four basic operations for working with data.

| CRUD       | SQL      | Operation |
| ---------- | -------- | --------- |
| **C**reate | `INSERT` | Create    |
| **R**ead   | `SELECT` | Read      |
| **U**pdate | `UPDATE` | Update    |
| **D**elete | `DELETE` | Delete    |

### CREATE

```sql
INSERT INTO users (name, email)
VALUES ('John', 'john@email.com');
```

### READ

```sql
SELECT *
FROM users;
```

### UPDATE

```sql
UPDATE users
SET name = 'Carlos'
WHERE id = 1;
```

### DELETE

```sql
DELETE FROM users
WHERE id = 1;
```

---

# 🏗️ 36. DDL / DML / DQL / TCL

SQL commands can be divided into different groups.

| Category | Meaning                      | Main Commands                         |
| -------- | ---------------------------- | ------------------------------------- |
| **DDL**  | Data Definition Language     | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML**  | Data Manipulation Language   | `INSERT`, `UPDATE`, `DELETE`          |
| **DQL**  | Data Query Language          | `SELECT`                              |
| **TCL**  | Transaction Control Language | `COMMIT`, `ROLLBACK`, `SAVEPOINT`     |

### DDL

Works with the database structure:

```sql
CREATE TABLE products (...);
ALTER TABLE products ...;
DROP TABLE products;
```

### DML

Works with the data:

```sql
INSERT INTO products ...;

UPDATE products ...;

DELETE FROM products ...;
```

### DQL

Queries information:

```sql
SELECT *
FROM products;
```

### TCL

Controls transactions:

```sql
START TRANSACTION;

UPDATE products
SET stock = stock - 1
WHERE id = 1;

COMMIT;
```

---

# 🚀 37. Final Project

To practice all these concepts, we can build a small **online store system**.

## Model

```text
                    ┌──────────────┐
                    │  CUSTOMERS   │
                    └──────┬───────┘
                           │
                           │ 1:N
                           ▼
                    ┌──────────────┐
                    │    ORDERS    │
                    └──────┬───────┘
                           │
                           │ 1:N
                           ▼
                  ┌──────────────────┐
                  │   ORDER_ITEMS    │
                  └────────┬─────────┘
                           │
                           │ N:1
                           ▼
                    ┌──────────────┐
                    │   PRODUCTS   │
                    └──────┬───────┘
                           │
                           │ N:1
                           ▼
                    ┌──────────────┐
                    │  CATEGORIES  │
                    └──────────────┘
```

---

## Create Database

```sql
CREATE DATABASE store;

USE store;
```

---

## Create Categories

```sql
CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);
```

---

## Create Products

```sql
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,

    FOREIGN KEY (category_id)
    REFERENCES categories(id)
);
```

---

## Create Customers

```sql
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);
```

---

## Create Orders

```sql
CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
    REFERENCES customers(id)
);
```

---

## Create Order Items

```sql
CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (order_id, product_id),

    FOREIGN KEY (order_id)
    REFERENCES orders(id),

    FOREIGN KEY (product_id)
    REFERENCES products(id)
);
```

---

# 📊 Project Queries

### Products and Their Categories

```sql
SELECT
    products.name AS product,
    categories.name AS category,
    products.price
FROM products

INNER JOIN categories
    ON products.category_id = categories.id;
```

### Customers and Their Orders

```sql
SELECT
    customers.name,
    orders.id AS order_id
FROM customers

LEFT JOIN orders
    ON orders.customer_id = customers.id;
```

### Number of Orders per Customer

```sql
SELECT
    customers.name,
    COUNT(orders.id) AS total_orders
FROM customers

LEFT JOIN orders
    ON orders.customer_id = customers.id

GROUP BY customers.id;
```

### Products More Expensive Than the Average

```sql
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
```

### Product Classification

```sql
SELECT
    name,
    price,

    CASE
        WHEN price < 100 THEN 'Economical'
        WHEN price < 500 THEN 'Intermediate'
        ELSE 'Premium'
    END AS price_category

FROM products;
```

---

# 🧭 Learning Path

```text
SQL
 │
 ├── Fundamentals
 │    ├── Database
 │    ├── Tables
 │    ├── Data Types
 │    └── Constraints
 │
 ├── Data Manipulation
 │    ├── INSERT
 │    ├── UPDATE
 │    └── DELETE
 │
 ├── Queries
 │    ├── SELECT
 │    ├── WHERE
 │    ├── LIKE
 │    ├── IN
 │    ├── BETWEEN
 │    ├── ORDER BY
 │    └── LIMIT
 │
 ├── Relationships
 │    ├── 1:1
 │    ├── 1:N
 │    ├── N:1
 │    └── N:N
 │
 ├── Advanced Queries
 │    ├── JOIN
 │    ├── GROUP BY
 │    ├── HAVING
 │    ├── Subqueries
 │    ├── EXISTS
 │    ├── UNION
 │    ├── CASE
 │    └── COALESCE
 │
 ├── Advanced Database
 │    ├── Transactions
 │    ├── Views
 │    ├── Indexes
 │    ├── ON DELETE
 │    └── ON UPDATE
 │
 └── Project
      └── Complete System
```

---

# 📌 Quick Summary

| Operation            | Command             |
| -------------------- | ------------------- |
| Create database      | `CREATE DATABASE`   |
| Select database      | `USE`               |
| Create table         | `CREATE TABLE`      |
| Modify table         | `ALTER TABLE`       |
| Delete table         | `DROP TABLE`        |
| Clear table          | `TRUNCATE`          |
| Insert               | `INSERT`            |
| Query                | `SELECT`            |
| Filter               | `WHERE`             |
| Update               | `UPDATE`            |
| Delete               | `DELETE`            |
| Sort                 | `ORDER BY`          |
| Limit                | `LIMIT`             |
| Group                | `GROUP BY`          |
| Filter groups        | `HAVING`            |
| Join tables          | `JOIN`              |
| Count                | `COUNT`             |
| Add values           | `SUM`               |
| Average              | `AVG`               |
| Highest value        | `MAX`               |
| Lowest value         | `MIN`               |
| Internal query       | `Subquery`          |
| Check existence      | `EXISTS`            |
| Combine queries      | `UNION`             |
| Conditions           | `CASE`              |
| Replace `NULL`       | `COALESCE`          |
| Copy data            | `INSERT ... SELECT` |
| Confirm transaction  | `COMMIT`            |
| Undo transaction     | `ROLLBACK`          |
| Create virtual query | `VIEW`              |
| Improve searches     | `INDEX`             |

---

# 🧠 Final Concept

A well-structured database does not depend only on knowing how to write SQL commands.

You also need to understand:

```text
        MODELING
            │
            ▼
        STRUCTURE
            │
            ▼
      RELATIONSHIPS
            │
            ▼
        INTEGRITY
            │
            ▼
         QUERIES
            │
            ▼
       PERFORMANCE
            │
            ▼
         SECURITY
```

The goal is to build databases that are:

* **Consistent**
* **Scalable**
* **Performant**
* **Secure**
* **Easy to maintain**
* **Well connected**

---

> **SQL is not only about querying data. It is about knowing how to structure, connect, manipulate, and protect information.**
