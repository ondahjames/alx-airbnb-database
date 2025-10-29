-- database_index.sql
-- Create indexes for high-usage columns in Users, Bookings, and Properties tables

-- USERS TABLE
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_user_id ON users(user_id);

-- PROPERTIES TABLE
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price_per_night);
CREATE INDEX idx_properties_host_id ON properties(host_id);

-- BOOKINGS TABLE
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_bookings_check_in_date ON bookings(check_in_date);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Optional composite index for performance boost in date-based property lookups
CREATE INDEX idx_bookings_property_date ON bookings(property_id, check_in_date);

-- Measure query before indexing
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    u.first_name,
    p.title,
    b.check_in_date,
    b.check_out_date
FROM bookings b
JOIN users u ON b.guest_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
WHERE p.location = 'Lagos'
  AND b.check_in_date BETWEEN '2025-01-01' AND '2025-12-31';

