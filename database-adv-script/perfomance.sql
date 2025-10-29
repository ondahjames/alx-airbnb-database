-- ==========================================
-- Retrieve filtered bookings with user, property, and payment details
-- ==========================================

SELECT
    b.id AS booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.status AS booking_status,
    
    -- User details
    u.id AS user_id,
    u.username,
    u.email,
    u.full_name,
    
    -- Property details
    p.id AS property_id,
    p.name AS property_name,
    p.city AS property_city,
    p.price AS property_price,
    
    -- Payment details
    pay.id AS payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status

FROM Booking b
INNER JOIN User u ON b.user_id = u.id
INNER JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id

-- Filters (example)
WHERE b.booking_date >= '2025-01-01'
  AND p.city = 'Lagos'
ORDER BY b.booking_date DESC;

-- ==========================================
-- Analyze query performance: Retrieve filtered bookings with user, property, and payment details
-- ==========================================

EXPLAIN ANALYZE
SELECT
    b.id AS booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.status AS booking_status,
    
    -- User details
    u.id AS user_id,
    u.username,
    u.email,
    u.full_name,
    
    -- Property details
    p.id AS property_id,
    p.name AS property_name,
    p.city AS property_city,
    p.price AS property_price,
    
    -- Payment details
    pay.id AS payment_id,
    pay.amount AS payment_amount,
    pay.payment_date,
    pay.status AS payment_status

FROM Booking b
INNER JOIN User u ON b.user_id = u.id
INNER JOIN Property p ON b.property_id = p.id
LEFT JOIN Payment pay ON b.id = pay.booking_id

-- Filters
WHERE b.booking_date >= '2025-01-01'
  AND p.city = 'Lagos'
ORDER BY b.booking_date DESC;

