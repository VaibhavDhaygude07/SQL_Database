CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    age INT
);

INSERT INTO Students (student_id, name, email, age) VALUES
(1, 'Alice Johnson', 'alice@example.com', 20),
(2, 'Bob Smith', 'bob@example.com', 21),
(3, 'Charlie Brown', 'charlie@example.com', 22);

select * from Students

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

INSERT INTO Courses (course_id, course_name, credits) VALUES
(101, 'Database Systems', 4),
(102, 'Machine Learning', 3),
(103, 'Computer Networks', 3);

CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(100),
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data
INSERT INTO Assignments (assignment_id, course_id, title, due_date) VALUES
(1, 101, 'Assignment 1', '2024-01-15'),
(2, 101, 'Assignment 2', '2024-02-10'),
(3, 102, 'Midterm Project', '2024-03-01'),
(4, 103, 'Final Exam', '2024-04-20');

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    student_id INT,
    assignment_id INT,
    score DECIMAL(5, 2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);

INSERT INTO Grades (grade_id, student_id, assignment_id, score) VALUES
(1, 1, 1, 85.5),
(2, 2, 1, 90.0),
(3, 3, 2, 75.0),
(4, 1, 3, 88.0),
(5, 2, 4, 92.0);

CREATE TABLE Instructors (
    instructor_id INT PRIMARY KEY,
    course_id INT,
    name VARCHAR(50),
    email VARCHAR(100),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data
INSERT INTO Instructors (instructor_id, course_id, name, email) VALUES
(1, 101, 'Dr. Smith', 'smith@example.com'),
(2, 102, 'Dr. Johnson', 'johnson@example.com'),
(3, 103, 'Dr. Lee', 'lee@example.com');

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    attendance_date DATE,
    status VARCHAR(10),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data
INSERT INTO Attendance (attendance_id, student_id, course_id, attendance_date, status) VALUES
(1, 1, 101, '2024-01-10', 'Present'),
(2, 2, 101, '2024-01-10', 'Absent'),
(3, 3, 102, '2024-02-05', 'Present'),
(4, 1, 103, '2024-02-07', 'Absent'),
(5, 2, 103, '2024-02-07', 'Present');

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Insert sample data
INSERT INTO Enrollments (enrollment_id, student_id, course_id) VALUES
(1, 1, 101),
(2, 1, 102),
(3, 2, 101),
(4, 2, 103),
(5, 3, 102);


-- Retrieve a List of Students Along with the Names of Courses They Are Enrolled In
select Students.student_id, Students.name, Courses.course_id, Courses.course_name from Students inner join Enrollments ON Students.student_id = Enrollments.student_id
INNER JOIN Courses ON Enrollments.course_id = Courses.course_id;

-- List All Students and the Courses They Are Enrolled In, Including Students Not Enrolled in Any Course
   select Students.student_id, Students.name, Courses.course_id, Courses.course_name from Students left join Enrollments On Students.student_id = Enrollments.student_id
   left join Courses on Enrollments.course_id = Courses.course_id

   --List All Courses and the Students Enrolled in Each Course, Including Courses with No Students
   select Courses.course_id, Courses.course_name, Students.student_id, Students.name from Courses Left join Enrollments on Courses.course_id = Enrollments.course_id
   left join Students on Enrollments.student_id = Students.student_id

   -- Full Outer Join: Retrieve a List of All Students and Courses, Including Students Without Any Courses and Courses Without Any Students
   select Students.student_id, Students.name, Courses.course_id, Courses.course_name from Students full outer join Enrollments on Students.student_id = Enrollments.student_id
   full outer join  Courses on Enrollments.course_id = Courses.course_id

   --Retrieve Each Student's Name Along with Their Course Name and Instructor’s Name
   select Students.name as student_name, Courses.course_name, Instructors.name as Instructor_name from Students inner join Enrollments on Students.student_id = Enrollments.student_id
   inner join Courses on Courses.course_id = Enrollments.course_id 
   inner join Instructors on Instructors.course_id = Courses.course_id

   --Use LEFT JOIN to Find Students Who Are Not Enrolled in Any Course
   select Students.name from Students Left join Enrollments on Students.student_id = Enrollments.student_id
   Where Enrollments.course_id is Null

   -- Retrieve the Title of Each Assignment Along with the Student’s Name and Their Score
   select Students.name as student_name, Assignments.title as Assignment_title, Grades.score from Assignments inner join Grades on Assignments.assignment_id = Grades.assignment_id
   inner join Students on Grades.student_id = Students.student_id

   --List Each Course Name, the Total Number of Enrolled Students, and the Instructor's Name

	SELECT Courses.course_name, COUNT(Enrollments.student_id) AS total_students, Instructors.name AS instructor_name
	FROM Courses
	LEFT JOIN Enrollments ON Courses.course_id = Enrollments.course_id
	INNER JOIN Instructors ON Courses.course_id = Instructors.course_id
	GROUP BY Courses.course_name, Instructors.name


	--Calculate the Average Attendance Rate for Each Course (Percentage of "Present" Status)
	SELECT Courses.course_name,
    AVG(CASE WHEN Attendance.status = 'Present' THEN 1 ELSE 0 END) * 100 AS attendance_rate
	FROM Courses
	INNER JOIN Attendance ON Courses.course_id = Attendance.course_id
	GROUP BY Courses.course_name

	--Find All Students Enrolled in a Specific Course (e.g., "Database Systems")
	select Students.name from Students where student_id In (select student_id from Enrollments where course_id in 
															(select course_id from Courses where course_name='Database Systems'))

	--Find Courses with More than a Certain Number of Enrollments
	select Courses.course_name from Courses Where course_id in (select course_id from Enrollments group by course_id having count(student_id)>1)

	-- List Students Not Enrolled in Any Courses
	select name from Students where student_id not in (select student_id from Enrollments )

	--Find the Latest Enrollment Date for Each Student
	select name from Students where 
