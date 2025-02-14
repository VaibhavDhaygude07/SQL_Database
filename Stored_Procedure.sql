
CREATE TABLE Assignments (
    assignment_id INT PRIMARY KEY,
    course_id INT,
    title VARCHAR(100),
    due_date DATE
);


INSERT INTO Assignments (assignment_id, course_id, title, due_date) VALUES
(1, 101, 'Assignment 1', '2024-01-15'),
(2, 101, 'Assignment 2', '2024-02-10'),
(3, 102, 'Midterm Project', '2024-03-01'),
(4, 103, 'Final Exam', '2024-04-20');

CREATE TABLE Grades (
    grade_id INT PRIMARY KEY,
    assignment_id INT,
    score DECIMAL(5,2), 
    FOREIGN KEY (assignment_id) REFERENCES Assignments(assignment_id)
);


INSERT INTO Grades (grade_id, assignment_id, score) VALUES
(1, 1, 85.5),
(2, 1, 90.0),
(3, 2, 75.0),
(4, 3, 88.0),
(5, 4, 92.0);


ALTER PROCEDURE getAssignmentdata
AS 
BEGIN 
    SELECT * FROM Grades WHERE score > 85.0 ORDER BY score DESC;
END;
GO


EXEC getAssignmentdata;

CREATE PROCEDURE spAddNewData
    @grade_id INT,
    @assignment_id INT, 
    @score DECIMAL(5,2)
AS
BEGIN
    BEGIN TRY
 
        IF EXISTS (SELECT 1 FROM Grades WHERE assignment_id = @assignment_id)
        BEGIN
            UPDATE Grades 
            SET score = @score
            WHERE assignment_id = @assignment_id;
        END
        ELSE
        BEGIN
            INSERT INTO Grades (grade_id, assignment_id, score) 
            VALUES (@grade_id, @assignment_id, @score);
        END
    END TRY
    BEGIN CATCH
        SELECT ERROR_LINE() AS ErrorLine, ERROR_MESSAGE() AS ErrorMessage;
    END CATCH
END;
GO
select * from Grades