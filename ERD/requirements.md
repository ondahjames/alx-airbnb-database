📋 Project Requirements
🏠 Project Overview
This document outlines the technical and functional requirements for the Airbnb Database Design & Implementation Project.
The goal is to design and build a scalable, normalized, and efficient database for an Airbnb-like platform.

🧩 Functional Requirements
User Management

Store user details (name, email, phone, date joined).
Ensure unique emails for all users.
Property Management

Maintain information about property listings (title, description, location, price, host).
Link each property to a host (user).
Booking Management

Allow users to make bookings for available properties.
Capture booking dates, status, and total price.
Payment Management

Record payments associated with each booking.
Track payment method, amount, and status.
Review System

Allow users to review properties they’ve stayed in.
Include ratings, comments, and timestamps.
⚙️ Technical Requirements
Database: MySQL or PostgreSQL
Modeling Tool: Draw.io for ERD
Schema Scripts: SQL DDL for table creation
Data Seeding: SQL DML for sample data insertion
Version Control: Git & GitHub for code management
🧠 Constraints & Standards
Follow 3rd Normal Form (3NF) for database normalization.
Use primary keys, foreign keys, and indexes.
Ensure referential integrity between tables.
Include timestamps for created/updated records.
✅ Deliverables
ERD.png – Entity-Relationship Diagram
Normalization.md – Normalization documentation
schema.sql – SQL schema creation file
seed.sql – Data seeding file
requirements.md – This document
README.md – Project overview and workflow
🧾 Author
Ondah James
Cloud Engineer in training | DevOps Enthusiast
