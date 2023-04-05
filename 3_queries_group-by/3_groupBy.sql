-- CREATE TABLE assignments (
--   id SERIAL PRIMARY KEY NOT NULL,
--   name VARCHAR(255),
--   content TEXT,
--   day INTEGER,
--   chapter INTEGER,
--   duration INTEGER
-- );

-- Assignments Per Day
SELECT day, count(*) as total_assignments 
FROM assignments 
GROUP BY day 
ORDER BY day;


-- Busy Days
SELECT day, count(*) as total_assignments 
FROM assignments 
GROUP BY day
HAVING count(*) > 10;
ORDER BY day

-- Large Cohorts
SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM students 
JOIN assignment_submissions ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohort
ORDER BY cohort
/*
SELECT cohorts.name as cohort_name, count(students.*) as students_count
FROM cohorts
JOIN students ON cohorts.id = cohort_id
GROUP BY cohort_name 
HAVING count(students.*) >= 18
ORDER BY student_count;
*/

-- Total Assignment Submissions
SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM students 
JOIN assignment_submissions ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohort
ORDER BY cohort;
/*
SELECT cohorts.name as cohort, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id = student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY total_submissions DESC;
*/

-- Average Completion Time
SELECT students.name as student, avg(assignment_submissions.duration) as average_assignment_duration
FROM assignment_submissions
JOIN students ON students.id = student_id
WHERE end_date IS NULL
GROUP BY student
ORDER BY average_assignment_duration DESC;


CREATE TABLE assignment_submissions (
  id SERIAL PRIMARY KEY NOT NULL,
  assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE,
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
  duration INTEGER,
  submission_date DATE
);
CREATE TABLE assignments (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  content TEXT,
  day INTEGER,
  chapter INTEGER,
  duration INTEGER
);
-- Low Average Completion Time
SELECT students.name as student, avg(assignment_submissions.duration) as average_assignment_duration, avg(assignments.duration) as average_estimated_duration
FROM assignment_submissions
JOIN students ON students.id = student_id
JOIN assignments ON assignments.id = assignment_id
WHERE end_date IS NULL
GROUP BY student
HAVING avg(assignment_submissions.duration) < avg(assignments.duration)
ORDER BY average_assignment_duration;