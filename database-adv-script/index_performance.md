-- User table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_username ON User(username);

-- Booking table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_date ON Booking(booking_date);

-- Property table
CREATE INDEX idx_property_city ON Property(city);
CREATE INDEX idx_property_price ON Property(price);
CREATE INDEX idx_property_owner_id ON Property(owner_id);
