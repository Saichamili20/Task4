Hospital Database Analysis – mis602_ass2
Project Overview
This project contains SQL queries, views, and indexes created for analyzing a hospital management database as part of my internship tasks.
The database includes patients, doctors, appointments, prescriptions, medications, and specialities, and the queries aim to generate meaningful healthcare insights.

Database Tables Used
patient – stores patient details (name, gender, DOB, state, etc.)

doctor – stores doctor details (name, speciality, contact, etc.)

appointment – appointment details linking patients and doctors

medication – list of available medicines

prescription – medicines prescribed during appointments

speciality – list of doctor specialities

Queries Performed
1. Data Exploration
Displayed sample records from all tables (SELECT * LIMIT 10)

Listed all available tables in the database (SHOW TABLES)

2. Patient Statistics
Count of male, female, and total patients

Grouping patients by state (GROUP BY state_code)

Categorized patients by DOB ranges (CASE)

Classified patients as Frequent Visitors or Occasional Visitors based on number of visits

3. Doctor & Speciality Analysis
List of doctors with their speciality

Doctors specializing in Cardiology and Neurology

Count of patients per speciality (GROUP BY speciality)

4. Appointment & Prescription Insights
Mapped which patient consulted which doctor

Tracked patient medication history

Listed most prescribed medicines

Found patients who received a specific medicine (e.g., Aspirin)

Found doctors who prescribed a specific medicine (e.g., Losartan)

Identified patients who received the same medicine

5. Subqueries
Patients with more than one appointment

Doctors linked to a medicine via nested subqueries

Patients linked to a medicine via nested subqueries

6. Views
patient_doctor_view – links patients, doctors, and appointment dates

patient_medication_view – links patients, medicines, and prescription details

7. Indexes
Created indexes on frequently searched columns:

patient(name)

appointment(appointment_date)

doctor(name)

Verified using SHOW INDEXES FROM <table>

 How to Run
Import the mis602_ass2.sql file into MySQL Workbench.

Select the database:


USE mis602_ass2;
Run queries in order as given in the .sql file.

To view stored views:


SELECT * FROM patient_doctor_view;
SELECT * FROM patient_medication_view;
Key Learnings
Used JOINs to connect multiple tables for richer insights

Applied aggregate functions (COUNT, GROUP_CONCAT, etc.)

Created views for reusable query logic

Used subqueries for multi-step filtering

Implemented indexes to optimize frequently used queries 
Attached screenshots of few outputs
