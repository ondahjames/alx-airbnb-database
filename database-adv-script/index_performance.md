-- database_index.sql

-- Indexes for User table
CREATE INDEX idx_user_email ON users(email);
CREATE INDEX idx_user_id ON users(user_id);

-- Indexes for Booking table
CREATE INDEX idx_booking_user_id ON bookings(user_id);
CREATE INDEX idx_booking_property_id ON bookings(property_id);
CREATE INDEX idx_booking_created_at ON bookings(created_at);

-- Indexes for Property table
CREATE INDEX idx_property_location ON properties(location);
CREATE INDEX idx_property_price ON properties(price);
CREATE INDEX idx_property_id ON properties(property_id);

EXPLAIN ANALYZE
SELECT u.user_id, u.email, COUNT(b.booking_id) AS total_bookings
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.created_at >= '2025-01-01'
GROUP BY u.user_id, u.email
ORDER BY total_bookings DESC;

