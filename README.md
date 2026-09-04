# 🗄️ SQL — Database Guide

> 🇧🇷 **Portuguese version available:** See `READMEbr.md` for documentation in Portuguese / *Versão em português disponível em `READMEbr.md`*

A practical reference for **SQL and MySQL** to work with relational databases: from basic creation to JOINs, transactions, views, and indexes.

---

## What is SQL

**SQL** is the language for relational databases. With it you can:

- Create and modify tables
- Insert, query, update, and delete data
- Create relationships between tables
- Filter, group, and analyze information
- Control transactions and create views

---

## Basic structure

```text
Database
    │
    ├── Tables
    │      ├── Columns
    │      └── Records
    │
    └── Relationships (1:1, 1:N, N:N)
```

---

## Database

| Command           | What it does         |
| ----------------- | -------------------- |
| `CREATE DATABASE` | Creates a database   |
| `DROP DATABASE`   | Deletes a database   |
| `SHOW DATABASES`  | Lists databases      |
| `USE`             | Selects a database   |

Create and select:

```sql
CREATE DATABASE shop;
USE shop;
```

Delete (⚠️ removes everything):

```sql
DROP DATABASE shop;
```

---

## Tables

| Command             | Function                    |
| ------------------- | --------------------------- |
| `CREATE TABLE`      | Creates a table             |
| `ALTER TABLE`       | Modifies a table            |
| `DROP TABLE`        | Deletes a table             |
| `TRUNCATE`          | Clears all records          |
| `DESCRIBE`          | Shows table structure       |

Basic example:

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(150)
);
```

Add column:

```sql
ALTER TABLE users
ADD phone VARCHAR(20);
```

Modify column:

```sql
ALTER TABLE users
MODIFY name VARCHAR(200);
```

Rename column:

```sql
ALTER TABLE users
RENAME COLUMN name TO full_name;
```

Clear table (keeps structure):

```sql
TRUNCATE TABLE users;
```

### DELETE vs TRUNCATE vs DROP

| Command      | Removes data | Keeps structure |
| ------------ | -----------: | ---------------: |
| `DELETE`     |            ✅ |               ✅ |
| `TRUNCATE`   |            ✅ |               ✅ |
| `DROP TABLE` |            ✅ |               ❌ |

---

## Data types

| Type       | Use                    | Example              |
| ---------- | ---------------------- | -------------------- |
| `INT`      | Integers               | `100`                |
| `BIGINT`   | Large integers         | `999999999`          |
| `DECIMAL`  | Monetary values        | `199.90`             |
| `FLOAT`    | Decimals               | `10.5`               |
| `VARCHAR`  | Variable text          | `'Eduardo'`          |
| `TEXT`     | Long text              | `'Description...'`   |
| `DATE`     | Date                   | `'2026-09-03'`       |
| `DATETIME` | Date and time          | `'2026-09-03 13:30'` |
| `BOOLEAN`  | True/False             | `TRUE`               |
| `JSON`     | JSON data              | `'{"name":"Edu"}'`   |

---

## Constraints (Rules)

Ensure data integrity:

| Constraint       | What it does                     |
| ---------------- | -------------------------------- |
| `PRIMARY KEY`    | Identifies each record           |
| `FOREIGN KEY`    | Relates tables                   |
| `UNIQUE`         | Prevents duplicate values        |
| `NOT NULL`       | Requires a value                 |
| `DEFAULT`        | Default value if not provided    |
| `CHECK`          | Validates a condition            |
| `AUTO_INCREMENT` | Auto-increments value            |

Example:

```sql
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) CHECK (price > 0),
    stock INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'active'
);
```

---

## CRUD — The 4 basic operations

### CREATE — Insert

```sql
INSERT INTO users (name, email)
VALUES ('John', 'john@email.com');
```

Multiple records:

```sql
INSERT INTO users (name, email)
VALUES
('John', 'john@email.com'),
('Maria', 'maria@email.com'),
('Peter', 'peter@email.com');
```

### READ — Query

```sql
SELECT * FROM users;
```

Specific columns:

```sql
SELECT name, email FROM users;
```

With alias:

```sql
SELECT name AS user FROM users;
```

### UPDATE — Update

```sql
UPDATE users
SET name = 'Carlos'
WHERE id = 1;
```

Multiple fields:

```sql
UPDATE users
SET name = 'Carlos', email = 'carlos@email.com'
WHERE id = 1;
```

### DELETE — Delete

```sql
DELETE FROM users WHERE id = 5;
```

⚠️ Always use `WHERE` or you'll delete everything.

---

## Filters and queries

### WHERE

Filters records:

```sql
SELECT * FROM products
WHERE price > 100;
```

Combinations:

```sql
SELECT * FROM products
WHERE price >= 100 AND stock > 0;
```

### Operators

| Operator | Meaning           |
| -------- | ----------------- |
| `=`      | Equal             |
| `<>`     | Different         |
| `>`      | Greater           |
| `<`      | Less              |
| `>=`     | Greater or equal  |
| `<=`     | Less or equal     |
| `AND`    | And               |
| `OR`     | Or                |
| `NOT`    | Negation          |

### LIKE

Searches text patterns:

```sql
SELECT * FROM users
WHERE name LIKE 'Jo%';        -- starts with Jo

SELECT * FROM users
WHERE name LIKE '%Silva';     -- ends with Silva

SELECT * FROM users
WHERE name LIKE '%ana%';      -- contains ana
```

### IN

Values from a list:

```sql
SELECT * FROM products
WHERE category_id IN (1, 2, 3);
```

### BETWEEN

Range of values:

```sql
SELECT * FROM products
WHERE price BETWEEN 100 AND 500;
```

### NULL

```sql
SELECT * FROM users
WHERE phone IS NULL;

SELECT * FROM users
WHERE phone IS NOT NULL;
```

Never use `= NULL`.

### ORDER BY

Sorts results:

```sql
SELECT * FROM products
ORDER BY price ASC;      -- ascending

SELECT * FROM products
ORDER BY price DESC;     -- descending
```

### LIMIT

Limits results:

```sql
SELECT * FROM products
LIMIT 10;

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;  -- top 5 most expensive
```

### DISTINCT

Removes duplicates:

```sql
SELECT DISTINCT category_id FROM products;
```

---

## Relationships

### 1:1 — One to One

One record relates to only one record in another table.

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE profiles (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

The `UNIQUE` ensures each user has one profile.

### 1:N — One to Many

A customer can have multiple orders.

```sql
CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);
```

### N:N — Many to Many

Students and courses: one student takes multiple courses, one course has multiple students.

Use an intermediary table:

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
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);
```

---

## JOIN — Combine tables

### INNER JOIN

Returns only records that exist in both tables.

```sql
SELECT customers.name, orders.id
FROM customers
INNER JOIN orders
    ON orders.customer_id = customers.id;
```

### LEFT JOIN

All customers, even without orders.

```sql
SELECT customers.name, orders.id
FROM customers
LEFT JOIN orders
    ON orders.customer_id = customers.id;
```

### RIGHT JOIN

All orders, even without a customer.

```sql
SELECT customers.name, orders.id
FROM customers
RIGHT JOIN orders
    ON orders.customer_id = customers.id;
```

### Multiple JOINs

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

---

## Aggregation

Functions that work with multiple records:

| Function  | Result   |
| --------- | -------- |
| `COUNT()` | Count    |
| `SUM()`   | Sum      |
| `AVG()`   | Average  |
| `MAX()`   | Maximum  |
| `MIN()`   | Minimum  |

Examples:

```sql
SELECT COUNT(*) AS total FROM users;

SELECT SUM(price) AS total FROM products;

SELECT AVG(price) AS average FROM products;

SELECT MAX(price) AS highest FROM products;

SELECT MIN(price) AS lowest FROM products;
```

---

## GROUP BY and HAVING

Group and filter groups:

```sql
SELECT
    category_id,
    COUNT(*) AS quantity
FROM products
GROUP BY category_id;
```

Filter groups (use `HAVING`, not `WHERE`):

```sql
SELECT
    category_id,
    COUNT(*) AS quantity
FROM products
GROUP BY category_id
HAVING COUNT(*) > 5;
```

**Difference:** `WHERE` filters records before grouping. `HAVING` filters groups after.

---

## Subqueries

Query within a query:

```sql
SELECT * FROM products
WHERE price > (
    SELECT AVG(price) FROM products
);
```

Returns products above average.

### EXISTS

Checks if a subquery returns anything:

```sql
SELECT * FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.id
);
```

Customers who have at least one order.

---

## UNION

Combines results from two queries:

```sql
SELECT name FROM customers
UNION
SELECT name FROM suppliers;
```

`UNION` removes duplicates. Use `UNION ALL` to keep them.

---

## CASE

Conditions within SELECT:

```sql
SELECT
    name,
    price,
    CASE
        WHEN price < 100 THEN 'Cheap'
        WHEN price < 500 THEN 'Mid-range'
        ELSE 'Expensive'
    END AS classification
FROM products;
```

---

## COALESCE

Replaces `NULL` with a value:

```sql
SELECT
    name,
    COALESCE(phone, 'Not provided') AS phone
FROM users;
```

---

## INSERT INTO SELECT

Copy data from one table to another:

```sql
INSERT INTO users_backup (name, email)
SELECT name, email FROM users;
```

---

## Transactions

Executes operations as a single unit. If something fails, everything reverts.

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;

COMMIT;
```

If something went wrong:

```sql
ROLLBACK;
```

Concept: either everything works, or nothing works.

---

## VIEW

Stored query that works like a virtual table:

```sql
CREATE VIEW customers_orders AS
SELECT
    customers.name,
    orders.id
FROM customers
INNER JOIN orders
    ON orders.customer_id = customers.id;
```

Use it:

```sql
SELECT * FROM customers_orders;
```

Delete it:

```sql
DROP VIEW customers_orders;
```

---

## INDEX

Improves search speed:

```sql
CREATE INDEX idx_email ON users(email);
```

Unique:

```sql
CREATE UNIQUE INDEX idx_email ON users(email);
```

Remove:

```sql
DROP INDEX idx_email ON users;
```

⚠️ Indexes take space and cost in INSERT/UPDATE/DELETE. Use strategically, especially on columns in `WHERE`, `JOIN`, and `ORDER BY`.

---

## ON DELETE / ON UPDATE

Controls what happens with related records:

```sql
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE CASCADE
ON UPDATE CASCADE
```

| Action      | Does                           |
| ----------- | ------------------------------ |
| `CASCADE`   | Deletes dependent records      |
| `RESTRICT`  | Prevents the operation         |
| `SET NULL`  | Sets FK to `NULL`              |

---

## Command classification

| Type  | What it does            | Examples                      |
| ----- | ----------------------- | ----------------------------- |
| **DDL** | Defines structure | `CREATE`, `ALTER`, `DROP` |
| **DML** | Manipulates data | `INSERT`, `UPDATE`, `DELETE` |
| **DQL** | Queries data | `SELECT` |
| **TCL** | Controls transactions | `COMMIT`, `ROLLBACK` |

---

## Example: Online Shop

Model:

```
CUSTOMERS
    │
    ├─ ORDERS
         │
         ├─ ORDER_ITEMS
              │
              └─ PRODUCTS
                  │
                  └─ CATEGORIES
```

Create database and tables:

```sql
CREATE DATABASE shop;
USE shop;

CREATE TABLE categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

CREATE TABLE orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

Useful queries:

```sql
-- Products with category
SELECT p.name, c.name AS category, p.price
FROM products p
INNER JOIN categories c ON p.category_id = c.id;

-- Customers and orders
SELECT c.name, COUNT(o.id) AS total_orders
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.id;

-- Products above average
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products);

-- Classify products by price
SELECT
    name, price,
    CASE
        WHEN price < 100 THEN 'Budget'
        WHEN price < 500 THEN 'Mid-range'
        ELSE 'Premium'
    END AS tier
FROM products;
```

---

## Quick reference

| Task | Command |
| --- | --- |
| Create database | `CREATE DATABASE` |
| Select database | `USE` |
| Create table | `CREATE TABLE` |
| Modify table | `ALTER TABLE` |
| Delete table | `DROP TABLE` |
| Insert data | `INSERT` |
| Query | `SELECT` |
| Filter | `WHERE` |
| Update | `UPDATE` |
| Delete record | `DELETE` |
| Sort | `ORDER BY` |
| Limit | `LIMIT` |
| Group | `GROUP BY` |
| Filter groups | `HAVING` |
| Join tables | `JOIN` |
| Count | `COUNT()` |
| Sum | `SUM()` |
| Average | `AVG()` |
| Maximum | `MAX()` |
| Minimum | `MIN()` |
| Conditions | `CASE` |
| Replace NULL | `COALESCE()` |
| Commit transaction | `COMMIT` |
| Undo transaction | `ROLLBACK` |
| Create view | `CREATE VIEW` |
| Create index | `CREATE INDEX` |
