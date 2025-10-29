-- ===========================================================
-- database_index.sql
-- Airbnb Clone - Database Index Optimization
-- ===========================================================

-- 🧩 USERS TABLE INDEXES
-- Index for quick email lookups during login/authentication
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Index on user_type to speed up filtering (e.g., show only hosts or guests)
CREATE INDEX IF NOT EXISTS idx_users_user_type ON users(user_type);

-- ===========================================================
-- 🧩 PROPERTIES TABLE INDEXES
-- Index on location for faster search/filter operations
CREATE INDEX IF NOT EXISTS idx_properties_location ON properties(location);

-- Index on price_per_night to improve sorting and range queries
CREATE INDEX IF NOT EXISTS idx_properties_price ON properties(price_per_night);

-- Index on host_id to speed up host-to-property joins
CREATE INDEX IF NOT EXISTS idx_properties_host_id ON properties(host_id);

-- ===========================================================
-- 🧩 BOOKINGS TABLE INDEXES
-- Index on property_id and guest_id for join operations
CREATE INDEX IF NOT EXISTS idx_bookings_property_id ON bookings(property_id);
CREATE INDEX IF NOT EXISTS idx_bookings_guest_id ON bookings(guest_id);

-- Composite index for date range filtering (common in search queries)
CREATE INDEX IF NOT EXISTS idx_bookings_dates ON bookings(check_in_date, check_out_date);

-- Index on booking_status to optimize reporting queries
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(booking_status);

-- ===========================================================
-- ✅ Performance Measurement Section
-- Measure before and after indexes using EXPLAIN ANALYZE

-- Example 1: Measure booking-user join performance
EXPLAIN ANALYZE
SELECT u.first_name, u.last_name, b.booking_id, b.check_in_date, b.total_amount
FROM users AS u
JOIN bookings AS b ON u.user_id = b.guest_id
WHERE b.booking_status = 'confirmed';

-- Example 2: Measure property search performance
EXPLAIN ANALYZE
SELECT p.property_id, p.title, p.location, p.price_per_night
FROM properties AS p
WHERE p.location = 'Lagos' AND p.price_per_night BETWEEN 50000 AND 100000
ORDER BY p.price_per_night ASC;

-- Run before creating indexes
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE booking_status = 'confirmed';

-- Create indexes
\i database_index.sql

-- Run again after indexing
EXPLAIN ANALYZE
SELECT * FROM bookings WHERE booking_status = 'confirmed';
