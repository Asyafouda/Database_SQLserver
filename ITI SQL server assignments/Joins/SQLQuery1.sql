use Company_SD
--1	Display the Department id, name and id and the name of its manager.
select dnum ,dname,Fname, MGRSSN 
from Employee e inner join Departments d
on e.SSN = d.MGRSSN
--2.Display the name of the departments and the name of the projects under its control.
select dname, pname
from Departments d inner join Project p
on d.Dnum = p.Dnum
--3	Display the full data about all the dependence associated with the name of the employee they depend on him/her.
select d.* ,fname as empName
from Dependent d inner join Employee e
on d.ESSN = e.ssn
--4 Display the Id, name and location of the projects in Cairo or Alex city.
select pname , pnumber, plocation 
from Project
where Plocation in('Cairo' , 'Alex') 
--5 Display the Projects full data of the projects with a name starts with "a" letter.
select p.*
from Project p
where Pname like 'a%'
--6 display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
select e.*
from Employee e 
where Dno = 30 and e.Salary between 1000 and 2000
--7.Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
select e.*
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p
on p.Pnumber = w.Pno
where Dno = 10 and w.Hours >= 10 and p.Pname ='Al Rabwah' 
--8.Find the names of the employees who directly supervised with Kamel Mohamed.
select e.fname
from Employee e inner join Employee sup
on sup.SSN = e.Superssn
where sup.Fname= 'Kamel' and sup.Lname= 'Mohamed'
--9.Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
select e.* , p.pname
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p
on p.Pnumber = w.Pno
order by p.Pname
--10.For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
select p.Pnumber , d.dname , e.lname, e.address ,e.bdate
from Employee e inner join Departments d
on e.SSN = d.MGRSSN
inner join Project p
on p.Dnum = d.Dnum
where City = 'Cairo'
--11.Display All Data of the managers
select e.*
from Employee e, Departments d
where e.SSN = d.MGRSSN
--12.Display All Employees data and the data of their dependents even if they have no dependents
select e.*, d.Dependent_name
from Employee e inner join Dependent d
on e.SSN = d.ESSN
--13.Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
insert into Employee
values ('Asya' , 'Mohamed', 102672, '6/3/2000', 'cairo', 'f', 3000, 112233, 30)
--14. Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or supervisor number to him.
insert into Employee
values ('Nada' , 'Ahmed', 102660, '1/1/2000', 'cairo', 'f', 30)
--15. Upgrade your salary by 20 % of its last value.
update Employee 
set Salary= Salary+ (salary*20/100)
where Employee.SSN = 102672
