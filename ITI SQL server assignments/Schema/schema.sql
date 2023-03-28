--1.
create table department
(
DeptNo char(3) primary key ,
DeptName varchar(20),
Location varchar(10)
)
insert into department
values('d1','Research','NY')
insert into department
values
('d2','Accounting','DS'),('d3','Markiting','KW')

create rule r1 as @x in ('NY','DS','KW')
create default def1 as 'NY'
sp_addtype loc,'nchar(2)'
sp_bindrule r1, loc
sp_bindefault def1,loc

alter table department alter column Location loc
----------------------------------------------------------

create table employee 
(
empno int primary key,
empfname varchar(20) not null,
emplname varchar(20) not null,
deptno char(3),
salary int ,
constraint c1 foreign key(deptno) references department(deptno) ,
constraint c2 unique(salary) ,
)
create rule r2 as @y<6000
sp_bindrule r2, 'employee.Salary'

-----------------------------------------------------------------------------------
--1.
insert into Works_on(EmpNo,ProjectNo)values(11111, 'p2') -- error
--2.
update Works_on set EmpNo =11111 where EmpNo=10102  -- error
--3.
update employee set EmpNo=22222 where EmpNo=10102   -- error
--4.
delete from employee where EmpNo=10102 -- error
delete from Works_on where EmpNo=10102
delete from employee where EmpNo=10102

--------------------------------------------------------------
--1.
alter table employee add telephone int
--2.
alter table employee drop column telephone 
--------------------------------------------------------------
--2.
create schema company
alter schema company transfer department
alter schema company transfer project

create schema humanresource
alter schema humanresource transfer Employee 

----------------------------------------------------------
--3.
SELECT * FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE TABLE_NAME='Employee'
-----------------------------------------------------------
--4.
create synonym emp for HumanResource.employee
--a.
Select * from Employee -- error
--b.
Select * from humanresource.Employee
--c.
Select * from Emp
--d.
Select * from humanresource.Emp --error
---------------------------------------------------------------
--5.
update company.project
set budget+=(.1*budget)
from company.project p inner join works_on w
on p.projectno=w.projectno
where empno=10102
and job = 'Manager'
----------------------------------------------------------------------------
--6.
update company.department
set DeptName='sales'
from company.department d inner join humanresource.employee e
on d.DeptNo=e.deptno
where empfname='james'
------------------------------------------------------------------------------
--7.
update works_on
set enter_date='12/12/2007'
from company.department d,humanresource.employee e,works_on w
where d.DeptNo=e.deptno and e.empno=w.empno and d.DeptName='sales' and projectno='p1'
----------------------------------------------------------------------------------------
--8.
delete from works_on
where empno in 
(select empno from humanresource.employee e,company.department d 
where d.DeptNo=e.deptno and d.Location='kw') 
-----------------------------------------------------------------------------------------

create schema asya 

alter schema asya transfer course

alter schema asya transfer student
