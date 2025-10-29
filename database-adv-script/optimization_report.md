-- Retrieve all bookings along with user, property, and payment details
SELECT 
    b.booking_id,
    b.booking_date,
    b.check_in_date,
    b.check_out_date,
    b.total_amount,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.property_name,
    p.location,
    p.price_per_night,
    pay.payment_id,
    pay.payment_method,
    pay.payment_status,
    pay.payment_date
FROM bookings b
JOIN users u 
    ON b.user_id = u.user_id
JOIN properties p 
    ON b.property_id = p.property_id
LEFT JOIN payments pay 
    ON b.booking_id = pay.booking_id
ORDER BY b.booking_date DESC;
