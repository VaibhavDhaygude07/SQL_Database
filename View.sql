SELECT * FROM student

create view studentview1 as 
select Name, Department, Age from student where Age>20

select * from studentview1

create table Student_Mark(student_id int,
Science varchar(25),
Math varchar(25),
Engish varchar(25)
)
ALTER TABLE Student_Mark ALTER COLUMN Science int
ALTER TABLE Student_Mark ALTER COLUMN Math int
ALTER TABLE Student_Mark ALTER COLUMN Engish int
INSERT INTO Student_Mark(student_id, Science,Math,Engish)
VALUES
(1, 85, 74,75),
(2, 76, 79,67),
(3, 61, 82,88),
(4, 92, 89,82),
(5, 70, 68,71),
(6, 85, 74,75),
(7, 85, 74,75),
(8, 85, 74,75),
(9, 85, 74,75),
(10, 85, 74,75),