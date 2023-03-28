--1)	Create view named   “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'.
use SD
create view v_clerk
as
select e.empno, p.projectno, enter_date
from humanresource.employee e, company.project p, works_on w
where e.empno = w.EmpNo and
      w.ProjectNo = p.ProjectNo
      and w.Job ='clerk'

select * from v_clerk
--2)	 Create view named  “v_without_budget” that will display all the projects data without budget
use SD
create view v_without_budget 
as 
select *
from company.project
where Budget is null
select * from v_without_budget

--3)	Create view named  “v_count “ that will display the project name and the # of jobs in it
create view v_count 
as 
select projectname , count(*) as job_num
from company.project p, works_on w 
where w.ProjectNo = p.ProjectNo 
group by projectname
select * from v_count 
--4)	 Create view named ” v_project_p2” that will display the emp#  for the project# ‘p2’use the previously created view  “v_clerk”
use SD
create view v_project_p2
as
select empno
from v_clerk v
select * from v_project_p2
--5)	modifey the view named  “v_without_budget”  to display all DATA in project p1 and p2 
alter view v_without_budget 
as
select *
from company.project p where ProjectNo in (1,2)
select * from v_without_budget

--6)	Delete the views  “v_ clerk” and “v_count”
drop view v_count 
go
drop view v_clerk

--7)	Create view that will display the emp# and emp lastname who works on dept# is ‘d2’
create view vdep2
as
select empno , emplname
from humanresource.employee
where deptno = 2

--8)	Display the employee  lastname that contains letter “J” Use the previous view created in Q#7
select emplname from vdep2
where emplname like '%j%'

--9)	Create view named “v_dept” that will display the department# and department name.
create view v_dept
as 
select deptno , DeptName
from company.department
select * from v_dept
--10)	using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’
insert into v_dept
values (4,'development')
select * from v_dept

--11)	Create view name “v_2006_check” that will display employee#, the project #where he works and the date of joining the project which must be from the first of January and the last of December 2006.
use SD
create view v_2006_check 
as
select empno,projectno,enter_date
from works_on
where enter_date between '1-1-2006'and'31-12-2006'
select * from v_2006_check