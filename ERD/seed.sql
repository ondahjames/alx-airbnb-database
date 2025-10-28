-- seed.sql
-- Sample data for Airbnb-like application (PostgreSQL)

-- USERS (hosts and guests)
INSERT INTO users (user_id, first_name, last_name, email, phone, user_type)
VALUES
(uuid_generate_v4(), 'Alice', 'Johnson', 'alice.johnson@example.com', '+15550001', 'host'),
(uuid_generate_v4(), 'Bob', 'Smith', 'bob.smith@example.com', '+15550002', 'guest'),
(uuid_generate_v4(), 'Carol', 'Ng', 'carol.ng@example.com', '+15550003', 'host'),
(uuid_generate_v4(), 'David', 'Lee', 'david.lee@example.com', '+15550004', 'guest'),
(uuid_generate_v4(), 'Eve', 'Miller', 'eve.miller@example.com', '+15550005', 'guest');

-- Capture user ids for deterministic seed in apps you'd normally SELECT after insert.
-- For a simple seed, we'll insert properties referencing hosts by selecting user ids:
-- PROPERTIES
INSERT INTO properties (property_id, host_id, title, description, location, price_per_night)
VALUES
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='alice.johnson@example.com'), 'Cozy Downtown Loft', 'A bright loft in the city center', 'New York, NY', 120.00),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='carol.ng@example.com'), 'Beachside Bungalow', 'Steps from the beach', 'Santa Monica, CA', 200.00),
(uuid_generate_v4(), (SELECT user_id FROM users WHERE email='alice.johnson@example.com'), 'Suburban Family Home', 'Quiet neighborhood, 3 bedrooms', 'Austin, TX', 95.00);

-- AMENITIES
INSERT INTO amenities (amenity_id, name) VALUES
(uuid_generate_v4(), 'WiFi'),
(uuid_generate_v4(), 'Air conditioning'),
(uuid_generate_v4(), 'Kitchen'),
(uuid_generate_v4(), 'Washer'),
(uuid_generate_v4(), 'Free parking');

-- PROPERTY_AMENITIES (associating amenities to properties)
INSERT INTO property_amenities (property_id, amenity_id)
SELECT p.property_id, a.amenity_id
FROM properties p, amenities a
WHERE (p.title LIKE '%Loft%' AND a.name IN ('WiFi','Kitchen'))
   OR (p.title LIKE '%Bungalow%' AND a.name IN ('WiFi','Air conditioning','Free parking'))
   OR (p.title LIKE '%Family Home%' AND a.name IN ('Washer','Kitchen','Free parking'));

-- PROPERTY_IMAGES
INSERT INTO property_images (image_id, property_id, image_url)
SELECT uuid_generate_v4(), p.property_id, CONCAT('https://example.com/images/', SUBSTRING(md5(p.title) from 1 for 8), '.jpg')
FROM properties p;

-- BOOKINGS (guests booking properties)
INSERT INTO bookings (booking_id, property_id, guest_id, check_in_date, check_out_date, total_amount, booking_status)
VALUES
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE title='Cozy Downtown Loft'), (SELECT user_id FROM users WHERE email='bob.smith@example.com'), '2025-11-10', '2025-11-15', 120*5, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE title='Beachside Bungalow'), (SELECT user_id FROM users WHERE email='david.lee@example.com'), '2025-12-01', '2025-12-07', 200*6, 'confirmed'),
(uuid_generate_v4(), (SELECT property_id FROM properties WHERE title='Suburban Family Home'), (SELECT user_id FROM users WHERE email='eve.miller@example.com'), '2025-10-05', '2025-10-08', 95*3, 'confirmed');

-- PAYMENTS (one per booking)
INSERT INTO payments (payment_id, booking_id, amount, method, status)
SELECT uuid_generate_v4(), b.booking_id, b.total_amount, 'credit_card', 'completed'
FROM bookings b;

-- REVIEWS (one optional review per booking)
INSERT INTO reviews (review_id, booking_id, rating, comment)
SELECT uuid_generate_v4(), b.booking_id, CASE WHEN b.total_amount < 500 THEN 5 ELSE 4 END,
       CONCAT('Great stay at ', (SELECT title FROM properties p WHERE p.property_id = b.property_id))
FROM bookings b;
