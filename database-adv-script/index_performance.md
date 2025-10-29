CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_property_city ON Property(city);
-- Before indexing
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = 123;

-- After indexing
EXPLAIN ANALYZE
SELECT * FROM Booking WHERE user_id = 123;
