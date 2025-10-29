EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount AS booking_total,
    b.booking_status,
    b.created_at AS booking_created_at,
    u.user_id AS guest_id,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    u.email AS guest_email,
    u.user_type,
    p.property_id,
    p.title AS property_title,
    p.location AS property_location,
    p.price_per_night,
    pay.payment_id,
    pay.amount AS payment_amount,
    pay.payment_method,
    pay.status AS payment_status,
    pay.payment_date
FROM bookings AS b
INNER JOIN users AS u ON b.guest_id = u.user_id
INNER JOIN properties AS p ON b.property_id = p.property_id
LEFT JOIN payments AS pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- ===========================================================
-- Optimized Query - Improved Join Efficiency & Reduced Columns
-- ===========================================================

SELECT 
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.first_name AS guest_first_name,
    u.last_name AS guest_last_name,
    p.title AS property_title,
    pay.status AS payment_status
FROM bookings AS b
INNER JOIN users AS u
    ON b.guest_id = u.user_id
INNER JOIN properties AS p
    ON b.property_id = p.property_id
LEFT JOIN payments AS pay
    ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;

-- ===========================================================
-- Suggested Indexes for Better Performance
-- ===========================================================
-- These indexes help reduce Sequential Scans and improve join speed
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at DESC);

-- ===========================================================
-- Verify Performance Again
-- ===========================================================
-- Run EXPLAIN ANALYZE again to compare before and after:
-- 1. Check total execution time
-- 2. Look for "Index Scan" instead of "Seq Scan"
-- 3. Ensure fewer rows are scanned overall
-- ===========================================================
