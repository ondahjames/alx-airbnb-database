# Airbnb Database Schema

## Overview

This project defines the **PostgreSQL schema** for an Airbnb-like application, modeling the relationships between users, properties, bookings, payments, reviews, amenities, and images.
The goal is to provide a normalized, scalable, and query-efficient design.

---

## Files

* **schema.sql** – SQL script that creates all database tables, relationships, constraints, and indexes.
* **seed.sql** *(optional)* – Script for populating the database with sample data.

---

## Database Entities

### 1. Users

Stores user information (guests, hosts, admins).

**Key attributes:**

* `user_id` (UUID, Primary Key)
* `first_name`, `last_name`, `email`, `phone`
* `user_type` – defines role: *guest*, *host*, or *admin*
* `created_at`

---

### 2. Properties

Represents listings hosted by users.

**Key attributes:**

* `property_id` (UUID, Primary Key)
* `host_id` → references `users(user_id)`
* `title`, `description`, `location`, `price_per_night`
* `created_at`

---

### 3. Bookings

Links guests to reserved properties.

**Key attributes:**

* `booking_id` (UUID, Primary Key)
* `property_id` → references `properties(property_id)`
* `guest_id` → references `users(user_id)`
* `check_in_date`, `check_out_date`, `total_amount`
* `booking_status`: *confirmed*, *pending*, *canceled*

---

### 4. Payments

Tracks payments associated with bookings.

**Key attributes:**

* `payment_id` (UUID, Primary Key)
* `booking_id` → references `bookings(booking_id)`
* `amount`, `payment_method`, `status`
* `payment_date`

---

### 5. Reviews

Captures guest feedback.

**Key attributes:**

* `review_id` (UUID, Primary Key)
* `booking_id` → references `bookings(booking_id)`
* `rating` (1–5), `comment`

---

### 6. Amenities

Defines property features (e.g., Wi-Fi, parking).

**Key attributes:**

* `amenity_id` (UUID, Primary Key)
* `name` (Unique)

---

### 7. Property_Amenities

Join table for many-to-many relationship between Properties and Amenities.

---

### 8. Property_Images

Stores image URLs associated with properties.

---

## Relationships Summary

* **Users → Properties:** One host can own many properties.
* **Users → Bookings:** A guest can make many bookings.
* **Properties → Bookings:** One property can have many bookings.
* **Bookings → Payments:** One-to-one.
* **Bookings → Reviews:** One-to-one.
* **Properties ↔ Amenities:** Many-to-many via `property_amenities`.

---

## How to Use

### 1. Run the Schema

```bash
psql -U your_username -d your_database -f schema.sql
```

### 2. (Optional) Seed Sample Data

```bash
psql -U your_username -d your_database -f seed.sql
```

---

## Notes

* All primary keys use `UUID` for global uniqueness.
* Indexes are defined on foreign keys and searchable attributes (e.g., `location`, `price_per_night`).
* Constraints ensure referential integrity and valid data (e.g., date validation, positive price).

---

## Author

**ALX Airbnb Database Project** – *Database Design & Implementation (database-script-0x02)*
