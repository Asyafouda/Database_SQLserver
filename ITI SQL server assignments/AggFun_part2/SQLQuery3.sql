use ITI
-------------1------------ 
select count(*)
from Student s
where s.St_Age is not null
-------------2------------
select distinct ins_name
from Instructor
-----------3------------
select s.st_id, isnull(s.st_fname , ' ') +' '+ isnull(st_lname , '') as FullName
, isnull(dept_name , 'No Data') as Dep_Name
from Student s inner join Department d
on s.Dept_Id = d.Dept_Id
----------------4----------------
select ins_name , dept_name
from Instructor i left outer join Department d
on i.Dept_Id = d.Dept_Id
------------5------------
select s.st_fname + ' ' + s.st_lname as FullName , crs_name
from Student s inner join Stud_Course sc
on s.St_Id = sc.St_Id inner join Course c
on c.Crs_Id = sc.Crs_Id
where sc.Grade is not null 
-----------6-------------------
select COUNT(*) as Num_of_course
from Course c inner join Topic t 
on c.Top_Id = t.Top_Id
group by t.Top_Name
-----------7-------------
select MAX(salary)  as max_sal , MIN(salary) as min_sal
from Instructor
-------------8--------------
select ins_name 
from Instructor i
where i.Salary < (select AVG(salary) from Instructor)
-----------9--------------
select dept_name 
from Department d inner join Instructor i 
on d.Dept_Id = i.Dept_Id
 where Salary = (select MIN(salary) from Instructor)
-----------10----------
select top (2) salary
from Instructor
order by Salary desc
------------11-------------
select ins_name, coalesce( salary, 'Bonus') as salary
from Instructor
-----------12----------
select Avg(salary) as avg_salary
from Instructor
------------13--------------
select s.st_fname, sup.*
from Student s inner join Student sup
on s.St_super = sup.St_Id 
--------------14--------------
select Salary
from (  select salary , DENSE_RANK() over(partition by dept_id order by salary desc ) as DR
             from Instructor) as High_Salary
where DR = 2
---------------15---------------
select s.st_fname, s.dept_id
from( select * , ROW_NUMBER() over(partition by dept_id order by NEWID()) as DR
from Student) as s
where DR = 1
-------------Task 2-------------
use Adventureworks2012
----------1-------------
select SalesOrderID, ShipDate
from Sales.SalesOrderHeader 
where OrderDate between 7/28/2002 and 7/29/2014
-----------2------------------
select p.ProductID, p.Name 
from Production.Product p 
where StandardCost < 110
----------3-------------
select p.productid ,p.name 
from Production.Product p 
where p.Weight is null 
-----------4--------------
select p.name 
from Production.Product p 
where p.Color in ( 'silver', 'black', 'red')
-----------5-------------
select p.name
from Production.Product p
where p.name like 'B%'
-----------------6---------------
UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3
----------7---------------------
select SUM(TotalDue)
from Sales.SalesOrderHeader
where orderdate between 7/1/2001 and 7/31/2014
group by OrderDate
-----------8-----------------
select distinct hiredate
from HumanResources.Employee
-------------9--------------
select avg(distinct ListPrice) as AVG
from Production.Product
------------10-------------------
select concat('the ',name,' is only! ',listprice ) as plp
from Production.Product
where ListPrice in (100, 120)
order by ListPrice
---------11----------- 
select rowguid, Name, SalesPersonID, Demographics 
into store_Archive
from Sales.Store

select rowguid, Name, SalesPersonID, Demographics 
into store_Archive_table2
from Sales.Store
where 1=2
-----------12-----------------
select convert(varchar(50),getdate(),101)
union
select convert(varchar(20),getdate())
union
select format(getdate(),'dd-MM-yyyy')
union
select format(getdate(),'hh tt')


