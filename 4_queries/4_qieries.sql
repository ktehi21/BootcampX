-- Total Teacher Assistance Requests
SELECT count(assistance_requests.*) as total_assistances, teachers.name
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE name = 'Waylon Boehm'
GROUP BY teachers.name;
/* BY ME
SELECT count(assistance_requests.*) as total_assistances, name
FROM teachers
JOIN assistance_requests 
ON teacher_id = teachers.id
WHERE name = 'Waylon Boehm'
GROUP BY name;
*/

-- Total Student Assistance Requests
SELECT count(assistance_requests.*) as total_assistances, students.name
FROM assistance_requests
JOIN students ON students.id = student_id
WHERE name = 'Elliot Dickinson'
GROUP BY students.name;

-- Assistance Requests Data
SELECT teachers.name as teacher, 
students.name as student, 
assignments.name as assignment, 
(completed_at-started_at) as duration
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
JOIN students ON students.id = student_id
JOIN assignments ON assignments.id = assignment_id
ORDER BY duration;

-- Average Assistance Time
SELECT avg(completed_at-started_at) as average_assistance_request_duration
FROM assistance_requests;

-- Average Cohort Assistance Time
SELECT cohorts.name, avg(completed_at-started_at) as average_assistance_time
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time;

-- Cohort With Longest Assistances
SELECT cohorts.name, avg(completed_at-started_at) as average_assistance_time
FROM assistance_requests
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC;
..