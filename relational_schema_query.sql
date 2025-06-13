select * 
from sales_data

create table sales_employees as 
select distinct EmpID
  , EmpName
  , EmpTitle
  , SalesReg
from sales_data;

select * 
from sales_employees;

create table sales_customers as 
select distinct CustID
  , CustName
  , CustType
  , CustState
from sales_data;

select *
from sales_customers;

create table sales_products as 
select distinct ProdNumber
  , ProdName
  , ProdCategory
from sales_data;

select * 
from sales_products;

create table sales_orders as 
select distinct OrderNum
  , OrderDate
  , OrderType
  , EmpID
  , CustID
  , Quantity
  , Price
  , Discount
  , OrderTotal 
from sales_data;

select * 
from sales_orders;