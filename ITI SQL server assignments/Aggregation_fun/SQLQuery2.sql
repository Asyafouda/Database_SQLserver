use Company_SD
--1.	Display (Using Union Function)
--a The name and the gender of the dependence that's gender is Female and depending on Female Employee.
--b. And the male dependence that depends on Male Employee.

select d.Dependent_name ,d.sex
from Dependent d inner join Employee e
on e.SSN =d.ESSN
where e.Sex ='f' and d.Sex ='f'
union
select d.Dependent_name ,d.sex
from Dependent d inner join Employee e
on e.SSN =d.ESSN
where e.Sex ='m' and d.Sex = 'm'
--2.For each project, list the project name and the total hours per week (for all employees) spent on that project.
select p.pname, sum(w.hours) as total_hours
from Project p inner join Works_for w
on p.Pnumber = w.Pno
inner join Employee e
on w.ESSn = e.SSN
group by p.Pname
--3.Display the data of the department which has the smallest employee ID over all employees' ID.
select d.* 
from Departments d inner join Employee e
on e.Dno = d.Dnum
where SSN = ( select MIN(ssn) from Employee)
--4.For each department, retrieve the department name and the maximum, minimum and average salary of its employees.
select d.dname, max(e.salary) as max, min(e.salary) as min, AVG(e.salary) as avg
from Departments d inner join Employee e
on d.Dnum = e.Dno
group by d.Dname
--5.List the full name of all managers who have no dependents.
select e.fname +' '+ e.lname
from Employee e inner join Departments dp
on e.SSN = dp.MGRSSN
where ssn not in ( select essn from Dependent )
--6.For each department-- if its average salary is less than the average salary of all employees-- display its number, name and number of its employees.
select d.dnum, d.dname, count (e.ssn) as num_of_emp
from Departments d inner join Employee e
on d.Dnum = e.Dno
group by d.dnum, d.dname
having avg (e.Salary) < (select AVG(salary) from Employee)
--7. Retrieve a list of employees names and the projects names they are working on ordered by department number and within each department, ordered alphabetically by last name, first name.
select e.fname, e.Lname, p.pname
from Employee e inner join Works_for w
on e.SSN = w.ESSn
inner join Project p 
on w.Pno = p.Pnumber
order by e.Dno, Lname, Fname
--8. Try to get the max 2 salaries using subquery
select MAX(e.salary) as max1
from Employee e 
where Salary !=  (select MAX(salary) from Employee)
union 
select MAX(e.salary) as max2 from Employee e 
--9. Get the full name of employees that is similar to any dependent name
select e.fname +' ' + e.lname as [Full name]
from Employee e inner join Departments d
on e.Dno = d.Dnum
WHERE fname in (select e.Fname from Employee)
--10. Display the employee number and name if at least one of them have dependents (use exists keyword) self-study.
select e.ssn ,e.fname , e.Lname
from Employee e 
where exists( select * from Employee inner join Dependent d on e.SSN = d.ESSN)
--11.In the department table insert new department called "DEPT IT" , with id 100, employee with SSN = 112233 as a manager for this department. The start date for this manager is '1-11-2006'
insert into Departments 
values ('DEPT IT', 100, 112233,11-1-2006)
--12.	Do what is required if you know that : Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), and they give you(your SSN =102672) her position (Dept. 20 manager) 
--a.	First try to update her record in the department table
--b.	Update your record to be department 20 manager.
--c.	Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments
set MGRSSN= 968574
where Dnum = 100
update Departments
set MGRSSN = 102672
where Dnum = 20
update Employee
set Superssn = 102672
where ssn = 102672
--13.Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) so try to delete his data from your database in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, supervises any employees or works in any projects and handle these cases).

delete Dependent where ESSN = 223344
delete Works_for where ESSn = 223344
update Employee set Superssn = 102672 where Superssn = 223344
update Departments set MGRSSN = 102672 where MGRSSN = 223344
delete Employee where SSN = 223344
--14.Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
update Employee
set Salary = Salary + Salary*1.3
where SSN in (select essn from Project, Works_for where Pno = Pnumber and Pname = ' Al Rabwah')




