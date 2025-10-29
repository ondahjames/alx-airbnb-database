-- performance.sql

-- STEP 1: Initial Query
-- Retrieve all bookings along with user, property, and payment details
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.payment_method,
    pay.payment_status,
    pay.payment_date
FROM bookings b
JOIN users u 
    ON b.user_id = u.user_id
JOIN properties p 
    ON b.property_id = p.property_id
LEFT JOIN payments pay 
    ON b.booking_id = pay.booking_id
ORDER BY b.booking_date DESC;


-- STEP 2: Analyze Query Performance
-- Use EXPLAIN to evaluate query execution plan
EXPLAIN 
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.payment_method,
    pay.payment_status,
    pay.payment_date
FROM bookings b
JOIN users u 
    ON b.user_id = u.user_id
JOIN properties p 
    ON b.property_id = p.property_id
LEFT JOIN payments pay 
    ON b.booking_id = pay.booking_id
ORDER BY b.booking_date DESC;


-- STEP 3: Refactored Query for Better Performance
-- Optimization strategies:
-- 1. Select only needed columns instead of all fields.
-- 2. Add indexes on high-usage columns (user_id, property_id, booking_id).
-- 3. Use WHERE clause to limit results if applicable.
-- 4. Remove unnecessary ORDER BY if not required.

-- Example optimized query
SELECT 
    b.booking_id,
    b.booking_date,
    u.first_name,
    u.last_name,
    p.property_name,
    pay.payment_status
FROM bookings b
JOIN users u 
    ON b.user_id = u.user_id
JOIN properties p 
    ON b.property_id = p.property_id
LEFT JOIN payments pay 
    ON b.booking_id = pay.booking_id;

-- STEP 4: Analyze the optimized query performance
EXPLAIN 
SELECT 
    b.booking_id,
    b.booking_date,
    u.first_name,
    u.last_name,
    p.property_name,
    pay.payment_status
FROM bookings b
JOIN users u 
    ON b.user_id = u.user_id
JOIN properties p 
    ON b.property_id = p.property_id
LEFT JOIN payments pay 
    ON b.booking_id = pay.booking_id;
