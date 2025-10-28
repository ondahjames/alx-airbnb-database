# Airbnb Database Schema (PostgreSQL)

## 🏠 Overview

This project defines the **PostgreSQL database schema** for an Airbnb-like application.
It models real-world entities such as users, properties, bookings, payments, reviews, amenities, and property images.
The schema is designed for **scalability**, **data consistency**, and **query efficiency**.

---

## 📁 Files

* `schema.sql` – Contains all table definitions, constraints, and indexes.
* *(Optional)* `seed.sql` – Can be used to populate the database with sample data.

---

## 🧩 Entities Overview

### 1. Users

Stores all registered users (guests, hosts, and admins).

**Columns:**

* `user_id` – UUID Primary Key (auto-generated)
* `first_name`, `last_name`, `email`, `phone`
* `user_type` – Role (guest, host, admin)
* `created_at` – Timestamp for record creation

---

### 2. Properties

Represents listings hosted by users.

**Columns:**

* `property_id` – UUID Primary Key
* `host_id` – References `users(user_id)`
* `title`, `description`, `location`, `price_per_night`
* `created_at` – Timestamp for record creation

**Indexes:**

* `idx_properties_location`
* `idx_properties_price`

---

### 3. Bookings

Tracks reservations made by guests.

**Columns:**

* `booking_id` – UUID Primary Key
* `property_id` – References `properties(property_id)`
* `guest_id` – References `users(user_id)`
* `check_in_date`, `check_out_date`, `total_amount`, `booking_status`
* `created_at`

**Constraints:**

* `chk_dates` ensures checkout date > check-in date.

---

### 4. Payments

Logs payment details for each booking.

**Columns:**

* `payment_id` – UUID Primary Key
* `booking_id` – References `bookings(booking_id)`
* `amount`, `payment_method`, `status`
* `payment_date`

**Indexes:**

* `idx_payments_booking`

---

### 5. Reviews

Captures feedback for completed stays.

**Columns:**

* `review_id` – UUID Primary Key
* `booking_id` – References `bookings(booking_id)`
* `rating` (1–5)
* `comment`
* `created_at`

---

### 6. Amenities

Defines available property features.

**Columns:**

* `amenity_id` – UUID Primary Key
* `name` – Unique name of the amenity (e.g., Wi-Fi, Parking)

---

### 7. Property_Amenities

A join table linking properties and amenities (many-to-many relationship).

**Primary Key:**

* (`property_id`, `amenity_id`)

---

### 8. Property_Images

Stores property image URLs.

**Columns:**

* `image_id` – UUID Primary Key
* `property_id` – References `properties(property_id)`
* `image_url`, `uploaded_at`

---

## 🔗 Relationships

| Relationship           | Type         | Description                             |
| ---------------------- | ------------ | --------------------------------------- |
| Users → Properties     | 1-to-Many    | Each host can list multiple properties. |
| Users → Bookings       | 1-to-Many    | Each guest can make multiple bookings.  |
| Properties → Bookings  | 1-to-Many    | One property can have many bookings.    |
| Bookings → Payments    | 1-to-1       | Each booking has one payment.           |
| Bookings → Reviews     | 1-to-1       | Each booking has one review.            |
| Properties ↔ Amenities | Many-to-Many | Through `property_amenities`.           |

---

## ⚙️ How to Use

### 1. Create the Database

```bash
psql -U postgres -d airbnb_db -f schema.sql
```

### 2. Verify Tables

```sql
\dt
```

### 3. (Optional) Add Sample Data

```bash
psql -U postgres -d airbnb_db -f seed.sql
```

---

## 🧠 Notes

* Uses **UUIDs** for all primary keys.
* Includes **indexes** on searchable columns for faster lookups.
* Ensures **referential integrity** with `ON DELETE CASCADE`.
* Future optimizations may include **materialized views** or **advanced indexing** for analytics.

---

## 👨‍💻 Author

**Ondah James**
Project: *ALX Airbnb Database Module*
Directory: `database-script-0x02`
