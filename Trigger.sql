create database triggerDB

create table Employee( Emp_ID int, Name varchar(25), Department varchar(25), Salary decimal(12,2))

insert into Employee(Emp_ID, Name, Department,Salary)
values
(6, 'Sam', 'Sales',40000),
(1, 'Devid', 'HR', 55000),
(2,'Rome', 'Sales',35000),
(3, 'Alis', 'IT', 75000),
(4, 'Roman', 'HR', 60000),
(5, 'Bob', 'IT', 60000)

insert into Employee(Emp_ID, Name, Department,Salary)
values
(8, 'Ravi', 'Manager',45000)

create trigger tr_tablecreation
on database
for create_table
as 
begin
 print 'YOU CANNOT CREATE TABLE IN THIS DATABASE'
 rollback transaction
 end

CREATE TRIGGER tr_Alter
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
    PRINT 'A new table has been created in the database.'
END;


CREATE OR ALTER TRIGGER tr_alter
ON Employee
AFTER INSERT
AS
BEGIN
    SELECT * FROM inserted;
END;

Drop trigger tr_tablecreation on database 

CREATE TRIGGER tr_update
ON Employee
AFTER UPDATE
AS
BEGIN
	SELECT * FROM inserted
	SELECT * FROM deleted
END

UPDATE Employee SET NAME='John' WHERE Emp_ID=7

CREATE TABLE Audit_Employee(Emp_ID INT, Audit_Info VARCHAR(50))
SELECT * FROM Audit_Employee



CREATE TRIGGER Audit_info
ON Employee
AFTER INSERT
AS
BEGIN 
    INSERT INTO Audit_Employee (Emp_ID, Audit_Info)
    SELECT Emp_ID, CONCAT('Employee with ID ', Emp_ID, ' is added at ', GETDATE())
    FROM inserted;
END;
