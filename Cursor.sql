CREATE DATABASE Student

CREATE TABLE Student_details(
RollNo INT PRIMARY KEY,
Student_Name VARCHAR(50),
Class VARCHAR(10),
Marks_Sceinece INT,
Marks_Math INT,
Marks_Eng INT
)

INSERT INTO Student_details(RollNo,Student_Name,Class,Marks_Sceinece,Marks_Math,Marks_Eng)
VALUES
(1, 'Devid' ,'5th',54,78,54),
(2, 'Sam','7th',65,45,62),
(3, 'Tom' ,'6th',48,54,78),
(4, 'Leo' ,'4th',43,78,84),
(5, 'Alis' ,'9th',71,88,54),
(6, 'Smith' ,'8th',59,89,44),
(7, 'Roy' ,'10th',66,58,65),
(8, 'Roman' ,'7th',84,78,54),
(9, 'Bob' ,'5th',68,74,84),
(10, 'Joy' ,'11th',84,78,94)


SELECT * FROM Student_details



DECLARE @RollNo INT,
        @Student_Name VARCHAR(100),
        @Marks_Science INT,
        @Marks_Eng INT,
        @Marks_Math INT,
        @Marks_Total INT,
        @Percentage FLOAT;


DECLARE student_cursor CURSOR FOR 
SELECT RollNo, Student_Name,Marks_Sceinece, Marks_Math, Marks_Eng
FROM Student_details;


OPEN student_cursor;

FETCH NEXT FROM student_cursor INTO @RollNo, @Student_Name, @Marks_Science, @Marks_Math, @Marks_Eng;

WHILE @@FETCH_STATUS = 0
BEGIN
    
    PRINT CONCAT('Name: ', @Student_Name);
    PRINT CONCAT('Roll No: ', @RollNo);
    PRINT CONCAT('Science: ', @Marks_Science);
    PRINT CONCAT('Math: ', @Marks_Math);
    PRINT CONCAT('English: ', @Marks_Eng);

   
    SET @Marks_Total = @Marks_Science + @Marks_Math + @Marks_Eng;
    PRINT CONCAT('Total: ', @Marks_Total);

    SET @Percentage = CAST(@Marks_Total AS FLOAT) / 3;
    PRINT CONCAT('Percentage: ', @Percentage, '%');


    IF @Percentage >= 80
        PRINT 'Grade: A';
    ELSE IF @Percentage >= 60 AND @Percentage < 80
        PRINT 'Grade: B';
    ELSE IF @Percentage > 35 AND @Percentage < 60
        PRINT 'Grade: C';
    ELSE 
        PRINT 'FAIL';

    PRINT '==============================';


    FETCH NEXT FROM student_cursor INTO @RollNo, @Student_Name, @Marks_Science, @Marks_Math, @Marks_Eng;
END


CLOSE student_cursor;
DEALLOCATE student_cursor;


