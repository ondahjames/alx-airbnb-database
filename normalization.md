# Normalization Steps (to 3NF)

## 1. Unnormalized form (UNF)
Initially, data may be collected in a single table where many fields repeat (e.g., property details and amenities duplicated per booking). This leads to redundancy and update anomalies.

## 2. First Normal Form (1NF)
- Ensure each field contains atomic values (no repeating groups).
- Use unique primary keys for each entity (UUIDs used in schema).
- Separate repeating groups into related tables (e.g., property_images, property_amenities).

## 3. Second Normal Form (2NF)
- Remove partial dependencies: ensure non-key attributes fully depend on the primary key.
- Example: In BOOKINGS, move property-specific details into PROPERTIES; booking-specific totals remain in BOOKINGS.

## 4. Third Normal Form (3NF)
- Remove transitive dependencies: non-key attributes should not depend on other non-key attributes.
- Example: User contact details remain in USERS, not duplicated in BOOKINGS or PAYMENTS.
- Joins via foreign keys (e.g., property_id, user_id) maintain relationships without redundancy.

## 5. Other considerations
- Use join tables for many-to-many relationships (property_amenities).
- Add indexes on foreign keys and frequently queried columns (location, price, booking dates).
- Validate constraints (date checks, non-negative prices) to maintain data integrity.
