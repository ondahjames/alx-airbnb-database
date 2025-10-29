# Partitioning Performance Report

## Overview
This report presents the results of performance testing after implementing **range partitioning** on the `Booking` table in the Airbnb database.  
The table was partitioned based on the `start_date` column to improve the performance of queries filtering bookings by date ranges.

---

## Test Objective
The goal was to measure how partitioning impacts query performance for large datasets, especially when retrieving bookings within specific date ranges.

---

## Test Setup
### Before Partitioning
- **Table:** `Booking`
- **Records:** ~1,000,000
- **Query Tested:**
  ```sql
  EXPLAIN ANALYZE
  SELECT *
  FROM Booking
  WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';

EXPLAIN ANALYZE
SELECT *
FROM Booking_Partitioned
WHERE start_date BETWEEN '2025-01-01' AND '2025-06-30';
