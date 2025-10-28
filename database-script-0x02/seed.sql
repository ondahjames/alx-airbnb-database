-- Seed data for the Airbnb Database Project

-- Insert Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
('uuid-001', 'James', 'Ondah', 'james@example.com', 'hashed_pw_123', '08031234567', 'host'),
('uuid-002', 'Sarah', 'Okafor', 'sarah@example.com', 'hashed_pw_124', '08033445566', 'guest'),
('uuid-003', 'Michael', 'Ade', 'michael@example.com', 'hashed_pw_125', NULL, 'guest');

-- Insert Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES
('prop-001', 'uuid-001', 'Cozy Apartment', 'A beautiful space in Lagos', 'Lagos', 75.00),
('prop-002', 'uuid-001', 'Beach House', 'Relaxing getaway by the ocean', 'Lekki', 200.00);

-- Insert Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
('book-001', 'prop-001', 'uuid-002', '2025-11-10', '2025-11-15', 375.00, 'confirmed'),
('book-002', 'prop-002', 'uuid-003', '2025-12-01', '2025-12-05', 800.00, 'pending');

-- Insert Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_method)
VALUES
('pay-001', 'book-001', 375.00, 'credit_card'),
('pay-002', 'book-002', 800.00, 'paypal');

-- Insert Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment)
VALUES
('rev-001', 'prop-001', 'uuid-002', 5, 'Excellent host and clean apartment!'),
('rev-002', 'prop-002', 'uuid-003', 4, 'Great experience, loved the view!');

-- Insert Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body)
VALUES
('msg-001', 'uuid-002', 'uuid-001', 'Hi James, looking forward to my stay!'),
('msg-002', 'uuid-001', 'uuid-002', 'Thanks Sarah! Check-in details sent.');
