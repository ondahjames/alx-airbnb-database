-- ===========================================================
-- performance.sql
-- Airbnb Clone - Initial Multi-Table Query for Performance Analysis
-- ===========================================================
-- Objective:
-- Retrieve all bookings along with related user, property, and payment details.
-- This serves as the baseline query to be optimized later using indexes.
-- ===========================================================

SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount AS booking_total,
    b.booking_status,
    b.created_at AS booking_created_at,

    -- User details (Guest)
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    u.user_type,

    -- Property details
    p.property_id,
    p.title AS property_title,
    p.location AS property_location,
    p.price_per_night,

    -- Payment details
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.status AS payment_status,
    pay.payment_date

FROM bookings AS b
-- Join with Users (Guest)
INNER JOIN users AS u
    ON b.guest_id = u.user_id

-- Join with Properties
INNER JOIN properties AS p
    ON b.property_id = p.property_id

-- Left join with Payments (some bookings may not have payments yet)
LEFT JOIN payments AS pay
    ON b.booking_id = pay.booking_id

ORDER BY 
    b.created_at DESC;

-- ===========================================================
-- Performance Check
-- Run this query using EXPLAIN ANALYZE to measure performance before optimization:
-- EXPLAIN ANALYZE SELECT ... (above query)
-- ===========================================================

