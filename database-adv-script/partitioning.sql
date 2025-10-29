-- ===========================================================
-- PARTITIONING IMPLEMENTATION ON BOOKINGS TABLE
-- ===========================================================
-- Description:
-- The Booking table has grown large, causing slow query performance.
-- To improve query speed, we implement RANGE partitioning based on 
-- the start_date (check_in_date) column.
--
-- Benefits:
-- - Faster query performance for time-based filters.
-- - Easier maintenance (archiving old data).
-- - Improved parallelism and vacuum performance.
-- ===========================================================


-- Step 1: Create a new partitioned table structure
-- ===========================================================
CREATE TABLE bookings_partitioned (
    booking_id SERIAL PRIMARY KEY,
    guest_id INT NOT NULL,
    property_id INT NOT NULL,
    check_in_date DATE NOT NULL,
    check_out_date DATE NOT NULL,
    total_amount DECIMAL(10,2),
    booking_status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
PARTITION BY RANGE (check_in_date);


-- Step 2: Create partitions for specific years
-- ===========================================================
-- You can adjust or add more partitions as needed for your dataset.

CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

CREATE TABLE bookings_future PARTITION OF bookings_partitioned
FOR VALUES FROM ('2026-01-01') TO (MAXVALUE);


-- Step 3: (Optional) Move existing data into the new table
-- ===========================================================
-- This step migrates data from the old 'bookings' table.
-- Ensure you back up data before running this!

INSERT INTO bookings_partitioned (
    booking_id, guest_id, property_id, check_in_date, check_out_date, 
    total_amount, booking_status, created_at
)
SELECT 
    booking_id, guest_id, property_id, check_in_date, check_out_date,
    total_amount, booking_status, created_at
FROM bookings;


-- Step 4: Create indexes on partitions
-- ===========================================================
-- Improves lookup and join performance on each partition.

CREATE INDEX idx_bookings_2023_guest_id ON bookings_2023 (guest_id);
CREATE INDEX idx_bookings_2024_guest_id ON bookings_2024 (guest_id);
CREATE INDEX idx_bookings_2025_guest_id ON bookings_2025 (guest_id);

CREATE INDEX idx_bookings_2023_check_in ON bookings_2023 (check_in_date);
CREATE INDEX idx_bookings_2024_check_in ON bookings_2024 (check_in_date);
CREATE INDEX idx_bookings_2025_check_in ON bookings_2025 (check_in_date);


-- Step 5: Verify partitioning
-- ===========================================================
-- This query shows how data is distributed across partitions.
SELECT 
    tableoid::regclass AS partition_name, COUNT(*) AS total_records
FROM bookings_partitioned
GROUP BY partition_name
ORDER BY partition_name;

-- ===========================================================
-- Step 6: Performance Check
-- ===========================================================
-- Use EXPLAIN ANALYZE to confirm that the database scans
-- only the relevant partition(s) for a given query.

EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE check_in_date BETWEEN '2025-01-01' AND '2025-06-30';

-- Expected Result:
-- - The query plan should show a "Partition Pruning" step,
--   meaning only the 2025 partition is scanned.
-- ===========================================================
