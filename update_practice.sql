create table dim_employees_cleaned as 
select * 
from dim_employees;

select * 
from dim_employees_cleaned;

insert into dim_employees_cleaned(EmpID, EmpName, EmpTitle, SalesReg, StartDate)
values (900020002, 'John Jones', 'Senior Sales Representative', 'Southeast', '12/1/2010');

insert into dim_employees_cleaned(EmpID, EmpName, EmpTitle, SalesReg, StartDate)
values (900020003, 'Jason James', 'Sales Associate I', 'Southeast', '1/1/2011'),
  (900020004, 'Rebecca Smith', 'Sales Associate II', 'S Central East', '10/5/2012');

update dim_employees_cleaned
set EmpTitle = 'Sales Associate IV'
where EmpID = 900019273;

begin transaction;
update dim_employees_cleaned
set SalesReg = 'Northwest', StartDate = '6/21/2015'
where EmpID = 900019273;
rollback;

insert into sales_data_cleaned (EmpID, EmpName, EmpTitle, SalesReg, OrderNum, OrderDate, OrderType, CustType, CustID, CustName, CustState, ProdCategory, ProdNumber, ProdName, Quantity, Price, Discount, OrderTotal)
values (900018483, 'Kendra Barnbrook', 'Senior Sales Associate', 'S Central East', 1103796, '2022-01-02', 'Retail', 'Individual', 4005111, 'Kenny Richardson', 'Missouri', 'Solar panels', 'KESP200', 'K-Eco 200', 4, 654, 0, 2616)
on conflict (OrderNum) do update set 
  OrderDate = excluded.OrderDate; 

select * 
from sales_data_cleaned 
where OrderNum = 1103796;