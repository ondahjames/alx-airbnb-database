-- Query 1: Properties with an average rating greater than 4.0
SELECT 
    p.property_id,
    p.title AS property_title,
    p.location,
    p.price_per_night
FROM properties AS p
WHERE p.property_id IN (
    SELECT b.property_id
    FROM bookings AS b
    JOIN reviews AS r
    ON b.booking_id = r.booking_id
    GROUP BY b.property_id
    HAVING AVG(r.rating) > 4.0
)
ORDER BY p.title;

-- Query 2: Users who have made more than 3 bookings
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users AS u
WHERE (
    SELECT COUNT(*) 
    FROM bookings AS b
    WHERE b.guest_id = u.user_id
) > 3
ORDER BY u.first_name;
