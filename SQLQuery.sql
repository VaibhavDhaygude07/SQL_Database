create database employee

create table emp (
  id int not null,
  empname varchar(50),
  salary decimal(10,2),
  department varchar(10),
  city varchar(10)
)

insert into emp (id, empname, salary, department,city) 
values
  (1, 'Devid',45000,'Sales', 'Mumbai'),
  (2, 'Remo', 50000, 'Managment', 'Delhi'),
  (3, 'Leo', 75000, 'IT', 'Mumbai'),
  (4, 'Allen', 70000, 'IT', 'Chainnai'),
  (5, 'Jay', 40000, 'Sales', 'Hydrabad')

select * from emp order by  salary desc

select empname from emp order by salary OFFSET 1 ROWS

select top 3* from emp

select  distinct department from emp 

select * from emp where salary>45000

select * from emp where salary>70000 and department ='IT'

select * from emp where salary>50000 or city='Delhi'

select * from emp where city in('Mumbai', 'Delhi') 

select * from emp where salary between 35000 and 45000

select * from emp where empname LIKE 'D%'

select id as empid from emp 

select  department, max(salary)as Max_salary from emp group by department 

select * from emp

create table emp_info(name varchar(50), mob_no int, email varchar(50), city varchar(10))

INSERT INTO emp_info (name, mob_no, email, city)
VALUES 
	('Leonard',545554, 'leonard123@gmail.com', 'New York'), 
    ('Devid', 99999, 'devid@gmail.com', 'Mumbai'),
    ('Remo', 989854, 'remo@gmail.com', 'Pune'),
    ('Leo', 9897689, 'leo@gmail.com', 'Punjab'),
    ('Allen',896554, 'allen@gmail.com', 'Gujrat'),
    ('Jay', 7856236, 'jay@gmail.com', 'Pune');

select empname from emp 
union 
select email from emp_info

select empname from emp
INTERSECT
select name from emp_info
--Intersect  Print comman details 

select empname,city from emp
except 
select name, city from emp_info

--Second most salary 
select salary from emp  as e1 where 1 =
								(select count(distinct salary) from  emp as e2 where e2.salary > e1.salary)




