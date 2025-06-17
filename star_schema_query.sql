select * 
from sales_data

create table sales_data_cleaned as
select * 
from sales_data

update sales_data_cleaned
set OrderDate = replace(replace(OrderDate, '"', ''), '''', '');

create table dim_date as 
select distinct OrderDate 
  , strftime('%Y', OrderDate) as Year
  , strftime('%m', OrderDate) as Month
  , strftime('%d', OrderDate) as Day
  , strftime('%w', OrderDate) as DayofWeek
  , strftime('%w', OrderDate) as WeekNumber
  , case strftime('%w', OrderDate) when '0' then 1 when '6' then 1 else 0 end as IsWeekend
from sales_data_cleaned;

create table dim_employees as 
select distinct sdc.EmpID
  , sdc.EmpName
  , sdc.EmpTitle
  , sdc.SalesReg
  , rd.StartDate
from sales_data_cleaned as sdc
left join reps_data as rd
  on sdc.EmpID = rd.EmpID;

create table dim_customers as 
select distinct CustID
  , CustName
  , CustType
  , CustState
from sales_data_cleaned;

create table dim_products as 
select distinct ProdNumber
  , ProdName
  , ProdCategory
from sales_data_cleaned;

create table dim_orders as 
select distinct OrderNum
  , OrderDate
  , OrderType
  , EmpID
  , CustID
  , ProdNumber
  , Quantity
  , Price
  , Discount
  , OrderTotal 
from sales_data_cleaned;


select * 
from dim_orders as do
left join dim_employees as de 
  on do.EmpID = de.EmpID
left join dim_customers as dc 
  on do.CustID = dc.CustID
left join dim_products as dp 
  on do.ProdNumber = dp.ProdNumber
left join dim_date as dd 
  on do.OrderDate = dd.OrderDate