# Airbnb Database Performance Monitoring Report

## Overview
This report documents the process of monitoring query performance in the Airbnb database using SQL tools such as **EXPLAIN ANALYZE** and **SHOW PROFILE**.  
It identifies key performance bottlenecks, details optimization strategies (indexing, schema refinement), and presents results before and after improvements.

---

## Tools and Methods Used
- **EXPLAIN ANALYZE** — to visualize query execution plans and cost estimates.
- **SHOW PROFILE** — to measure CPU usage, I/O operations, and query phases.
- **Query Log** — to identify slow and frequently executed queries.
- **Index Creation and Schema Tuning** — applied based on observed patterns.

---

## Step 1: Initial Performance Monitoring

### Query 1 — Retrieve All Bookings with User and Property Details
```sql
EXPLAIN ANALYZE
SELECT b.id, u.name AS user_name, p.title AS property_name, b.start_date, b.end_date
FROM Booking b
JOIN User u ON b.user_id = u.id
JOIN Property p ON b.property_id = p.id
WHERE b.start_date BETWEEN '2025-01-01' AND '2025-06-30';
