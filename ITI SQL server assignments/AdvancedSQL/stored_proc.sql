--1.Create a stored procedure without parameters to show the number of students per department name.[use ITI DB]
use ITI
create Procedure getcount
as
select d.Dept_Name, count(s.St_Id) as stud_num
from Student s join Department d
on s.Dept_Id=d.Dept_Id
group by d.Dept_Name
--2.Create a stored procedure that will check for the # of employees in the project p1 
--if they are more than 3 print message to the user “'The number of employees in the project p1 is 3 or more'” 
use Company_SD
create Procedure emp_num
as
declare @empnum int
select @empnum=count(SSN) 
from Employee e, Works_for w
where e.SSN=w.ESSn and w.Pno=100
if (@empnum>=3)
    select 'The number of employees in the project p1 is 3 or more'
else
    select 'The following employees work for the project p1' as result, e.Fname,e.Lname
	from Employee e, Works_for w
	where e.SSN=w.ESSn and w.Pno=100


--3.Create a stored procedure that will be used in case there is an old employee has left the project and a new one become instead of him. 
--The procedure should take 3 parameters (old Emp. number, new Emp. number and the project number) 
--and it will be used to update works_on table. [Company DB].
use Company_SD
create proc change @old_id int, @new_id int, @pno int
as
begin try
update Works_for
set ESSn=@new_id
where ESSn=@old_id and Pno=@pno
end try
begin catch
      select 'Not allowed'as result
end catch


--4.Add column budget in project table and insert any draft values in it then Create an Audit table with the following structure:
--ProjectNo 	UserName 	ModifiedDate 	Budget_Old 	Budget_New 
--   p2 	       Dbo 	     2008-01-31	      95000 	  200000 
--This table will be used to audit the update trials on the Budget column (Project table, Company DB).
--Example: If a user updated the budget column then the project number, user name that made that update, the date of the modification and the value of the old and the new budget will be inserted into the Audit table.
--Note: This process will take place only if the user updated the budget column.
use SD
ALTER TABLE project
ADD budget int;

create table update_info
(
ProjectNo varchar(20),
UserName varchar(20),
ModifiedDate date,
Budget_Old int,
Budget_New int
)
select * from update_info

alter trigger auditUpdateBudget
on project
for update
as  
   if update(budget)
   begin
        declare @pnum int, @old_budget int, @new_budget int
		select @pnum=Pnumber from inserted
		select @new_budget=budget from inserted
		select @old_budget=budget from deleted
	insert into update_info values(@pnum,suser_name(),getdate(),@old_budget,@new_budget)
   end


--5.Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]
--“Print a message for user to tell him that he can’t insert a new record in that table”
use ITI
create trigger preventInsert
on department
instead of insert
as
    select 'You cannot insert a new record in that table.'as Result


--6.Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
use Company_SD
alter trigger preventInsertEmp
on employee
after insert 
as 
   if (format(getdate(),'MMMM') = 'March')
   begin
       select 'You cannot insert in March'
   end
   else
   begin
   delete from Employee where SSN=(select SSN from inserted)
   select * from inserted
   end


--7.Create a trigger on student table after insert to add Row in Student Audit table (Server User Name , Date, Note) where note will be “[username] Insert New Row with Key=[Key Value] in table [table name]”
--ServerUser Name	Date  Note 
create table stud_audit
 (
 ServerUserName varchar(50),
 Datee date,
 Note varchar(50)
 )
alter trigger st_audit
on student
after insert 
as
declare @note int
select  @note =st_id from inserted
insert into stud_audit
values(suser_name(),getdate(),@note)

--8.Create a trigger on student table instead of delete to add Row in Student Audit table (Server User Name, Date, Note) where note will be“ try to delete Row with Key=[Key Value]”
alter trigger st_audit2
on student
instead of delete  
as
declare @note int
select  @note=st_id from deleted
insert into stud_audit
values(suser_name(),getdate(),@note)