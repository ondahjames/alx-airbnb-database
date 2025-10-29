-- INNER JOIN: Get bookings with their respective users
SELECT 
    b.booking_id,
    b.property_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings AS b
INNER JOIN users AS u
ON b.guest_id = u.user_id
ORDER BY b.created_at DESC;

-- LEFT JOIN: Get all properties with their reviews (if any)
SELECT 
    p.property_id,
    p.title AS property_title,
    p.location,
    r.review_id,
    r.rating,
    r.comment
FROM properties AS p
LEFT JOIN bookings AS b
ON p.property_id = b.property_id
LEFT JOIN reviews AS r
ON b.booking_id = r.booking_id
ORDER BY p.title;

-- FULL OUTER JOIN: Get all users and all bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.check_in_date,
    b.check_out_date,
    b.total_amount
FROM users AS u
FULL OUTER JOIN bookings AS b
ON u.user_id = b.guest_id
ORDER BY u.first_name;
