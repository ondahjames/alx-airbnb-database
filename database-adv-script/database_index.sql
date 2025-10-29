-- ============================
-- Indexes for User Table
-- ============================

-- Index to speed up queries filtering by email
CREATE INDEX idx_user_email ON User(email);

-- Index to speed up queries filtering by username
CREATE INDEX idx_user_username ON User(username);


-- ============================
-- Indexes for Booking Table
-- ============================

-- Index to optimize queries joining with User table
CREATE INDEX idx_booking_user_id ON Booking(user_id);

-- Index to optimize queries joining with Property table
CREATE INDEX idx_booking_property_id ON Booking(property_id);

-- Index to speed up queries filtering or ordering by booking_date
CREATE INDEX idx_booking_date ON Booking(booking_date);


-- ============================
-- Indexes for Property Table
-- ============================

-- Index to speed up queries filtering by city
CREATE INDEX idx_property_city ON Property(city);

-- Index to speed up queries filtering or ordering by price
CREATE INDEX idx_property_price ON Property(price);

-- Index to optimize queries joining with User table (owner)
CREATE INDEX idx_property_owner_id ON Property(owner_id);
