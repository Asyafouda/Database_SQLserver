--1.	 Create a scalar function that takes date and returns Month name of that date.
create function get_month(@date date)
returns varchar(20)
begin
declare @name varchar(20)
select @name= (format(@date,'MMMM') )
return @name
end
begin try
    select dbo.get_month('1-1-2010') as Month_name
end try
begin catch 
    select 'Please enter your date as (mon-day-year)' 
end catch


--2.	 Create a multi-statements table-valued function that takes 2 integers and returns the values between them.
create function getvalue(@x int,@y int)
returns @t table
         (id int)
         as
         begin
              insert into @t
              values(@x)
              while @x < @y
              begin
                 insert into @t
				 values (@x+1)
				 set @x+=1
              end
return
end
select* from dbo.getvalue(5,10) 
		  
--3  Create a tabled valued function that takes Student No and returns Department Name with Student full name.
create function getstud(@id int)
returns table
 as
	 return
	 (
	 select Dept_Name, S.St_Fname +' '+ s.St_Lname as fullname
	 from Department d, asya.Student s
	 where d.Dept_Id= s.Dept_Id and St_Id=@id
	 
	 )
	 select* from getstud(10)

	 --4.	Create a scalar function that takes Student ID and returns a message to user 
--a.	If first name and Last name are null then display 'First name & last name are null'
---b.	If First name is null then display 'first name is null'
--c.	If Last name is null then display 'last name is null'
--d.	Else display 'First name & last name are not null'

create function msg(@sid int)
returns varchar(30)
begin
declare @messagee varchar(50)
declare @firstname varchar(20)
declare @lastname varchar(20)
select @firstname=st_fname from asya.Student where St_Id=@sid
select @lastname=St_Lname from asya.Student where St_Id=@sid
if @firstname is null and @lastname is null
select @messagee= 'First name & last name are null'
else if @firstname is null
select @messagee= 'First name is null'
else if @lastname is null
select @messagee= 'last name is null'
else
select @messagee= 'First name & last name are not null'
return @messagee
end

select dbo.msg(50)

--5.	Create a function that takes integer which represents manager ID and
------displays department name, Manager Name and hiring date 
create function getman (@idm int)
returns table
as
return
(
select ins_name,dept_name,manager_hiredate
from Instructor i,Department d
where i.Ins_Id=d.Dept_Manager and d.Dept_Manager=@idm
)

select *from getman(2)

--6.	Create multi-statements table-valued function that takes a string
--If string='first name' returns student first name
--If string='last name' returns student last name 
--If string='full name' returns Full Name from student table 
--Note Use “ISNULL” function
create function stdname(@name varchar(20))
returns @t table
(
name varchar(30)
)
as  begin
if @name='first name'
insert into @t
select ISNULL(st_fname,' ')from asya.Student
else if @name='last name'
insert into @t
select ISNULL(St_Lname,' ')from asya.Student
else if @name='full name'
insert into @t
select ISNULL(St_Fname+' '+St_Lname,' ')from asya.Student
return
end
select * from stdname('full name')


--7.	Write a query that returns the Student No and Student first name without the last char

select st_id, SUBSTRING(st_fname ,1,len(st_fname)-1) as fname
from asya.Student
---8 Wirte query to delete all grades for the students Located in SD Department 
delete SC 
from Stud_Course sc, asya.Student s, Department d
where sc.St_Id = s.St_Id and d.Dept_Id = s.Dept_Id
and Dept_Name = 'SD'


----bonus
declare @x int = 3000
declare @fname varchar(20) = 'Jane', @lname varchar(20) ='smith'
while @x<= 6000
begin 
insert into asya.Student(st_id,st_fname, st_lname)
values(@x, @fname, @lname)
set @x+=1
end