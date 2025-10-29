-- Query 1: Total number of bookings made by each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    COUNT(b.booking_id) AS total_bookings
FROM users AS u
LEFT JOIN bookings AS b
ON u.user_id = b.guest_id
GROUP BY u.user_id, u.first_name, u.last_name
ORDER BY total_bookings DESC;

-- Query 2: Rank properties based on number of bookings
SELECT 
    p.property_id,
    p.title AS property_title,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties AS p
LEFT JOIN bookings AS b
ON p.property_id = b.property_id
GROUP BY p.property_id, p.title
ORDER BY booking_rank;

