----1.	 Create a view that displays student full name, course name if the student has a grade more than 50. 
use ITI
create view vgrade
as
(
select s.St_Fname + ' ' +s.St_Lname as Full_Name, c.crs_name
from Student s join Stud_Course cs
on s.St_Id =cs.St_Id
join Course c 
on c.crs_id = cs.crs_id
where cs.grade > 50
)
select* from vgrade

--2.	 Create an Encrypted view that displays manager names and the topics they teach. 
create  view V_Mgr_topic
with encryption
as
select ins_name  as 'Manager Name' , Top_Name
from Department d , Instructor I , Ins_Course IC , Topic T , Course C
where D.Dept_Manager = I.Ins_Id and Ic.Ins_Id = I.Ins_Id
and Ic.Crs_Id = C.Crs_Id and C.Top_Id =T.Top_Id

select * from V_Mgr_topic

--3.	Create a view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department 
create view VDept
as 
select Ins_Name , Dept_name
from Instructor I , Department D
where I.Dept_Id = D.Dept_Id and Dept_Name in ('SD','java')

select * from VDept

--4.	 Create a view “V1” that displays student data for student who lives in Alex or Cairo. 
--Note: Prevent the users to run the following query 
--Update V1 set st_address=’tanta’
--Where st_address=’alex’;
create view V1
as
select * from Student 
where St_Address in ('alex','cairo')
with check option 

select * from V1

--5.	Create a view that will display the project name and the number of employees work on it. “Use SD database”
use SD

create view vpName
as
select projectname , count(empno) as  'Employee Number'
from company.project P , works_on W
where p.projectno = w.projectno
group by projectname

select * from vpName

--6.	Create index on column (Hiredate) that allow u to cluster the data in table Department. What will happen?
use ITI

create clustered index i
on department (manager_hiredate)

--7.	Create index that allow u to enter unique ages in student table. What will happen? 
 create unique index i
 on student (st_age)
--8.	Using Merge statement between the following two tables [User ID, Transaction Amount]
create table d_trans (user_id int, tamount int)
create table L_trans (user_id int, tamount int)

insert into d_trans values (1,1000),(2,2000),(3,1000)
merge into L_trans as l 
using d_trans as d
on l.user_id = d.user_id
when matched then 
update set l.tamount=d.tamount 
when not matched then 
insert values (d.user_id , d.tamount);

select * from L_trans
--9.	Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000. Use company DB
use Company_SD

 declare  c1 cursor 
 for select salary from Employee
 for update 
 declare @salary int
 open c 
 fetch c into @salary
 while @@FETCH_STATUS = 0
 begin
    if @salary <3000
    update Employee
	set Salary= @salary*1.1
	where current of c1
	if @salary >= 3000
	 update Employee
	 set Salary= @salary*1.2
	 where current of c1

    fetch c into @salary 
end
close c1
deallocate c1
--10.	Display Department name with its manager name using cursor. Use ITI DB
use ITI
declare  c1 cursor 
for 
   select dept_name, ins_name
   from Department d, Instructor i
   where d.Dept_Manager = i.Ins_Id
for read only

declare @dname varchar(20), @iname varchar(20)
open c1
fetch c1 into @dname,@iname
while @@FETCH_STATUS=0
  begin
      select @dname, @iname
	  fetch c1 into @dname,@iname
  end
close c1
deallocate c1



--11.	Try to display all students first name in one cell separated by comma. Using Cursor 
use ITI
declare c cursor 
for select distinct  st_fname from student 
   where st_fname is not null 
for read only 
declare @n varchar (30) , @names varchar (500)=''
open c
fetch c into @n 
while @@FETCH_STATUS = 0 
      begin 
	       set @names=concat (@names,',',@n)
		   fetch c into @n 
	  end 
select @names 
close c
deallocate c