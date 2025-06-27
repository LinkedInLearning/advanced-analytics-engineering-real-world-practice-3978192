-- Find rows with missing order total
select *
from sales_missing_data
where OrderTotal = '';

-- Count of missing entries per column
select sum(case when empid = '' then 1 else 0 end) as missing_empid
  , sum(case when empname = '' then 1 else 0 end) as missing_empname
  , sum(case when emptitle = '' then 1 else 0 end) as missing_emptitle
  , sum(case when salesreg = '' then 1 else 0 end) as missing_salesreg
  , sum(case when ordernum = '' then 1 else 0 end) as missing_ordernum
  , sum(case when orderdate = '' then 1 else 0 end) as missing_orderdate
  , sum(case when ordertype = '' then 1 else 0 end) as missing_ordertype
  , sum(case when custtype = '' then 1 else 0 end) as missing_custtype
  , sum(case when custid = '' then 1 else 0 end) as missing_custid
  , sum(case when custname = '' then 1 else 0 end) as missing_custname
  , sum(case when custstate = '' then 1 else 0 end) as missing_custstate
  , sum(case when prodcategory = '' then 1 else 0 end) as missing_prodcategory
  , sum(case when prodnumber = '' then 1 else 0 end) as missing_prodnumber
  , sum(case when prodname = '' then 1 else 0 end) as missing_prodname
  , sum(case when quantity = '' then 1 else 0 end) as missing_quantity
  , sum(case when price = '' then 1 else 0 end) as missing_price
  , sum(case when discount = '' then 1 else 0 end) as missing_discount
  , sum(case when ordertotal = '' then 1 else 0 end) as missing_ordertotal
from sales_missing_data;

-- create a table with not null constraints
create table sales_missing_data_cleaned (
  empid integer not null,
  empname text,
  emptitle text,
  salesreg text,
  ordernum integer primary key not null,
  orderdate text not null,
  ordertype text,
  custtype text,
  custid integer,
  custname text,
  custstate text,
  prodcategory text,
  prodnumber text,
  prodname text,
  quantity integer,
  price real,
  discount real,
  ordertotal real
);

--intentionally fail
insert into sales_missing_data_cleaned
select *
from sales_missing_data
where OrderNum is not null;

select * 
from sales_missing_data_cleaned

-- 1.exclude
select *
from sales_missing_data_cleaned
where ordertotal is not null;

-- 2.imputation
select quantity
  , price
  , discount
  , quantity * (price * (1 - discount)) as ordertotalcalc
from sales_missing_data_cleaned
where ordertotal = ''

update sales_missing_data_cleaned
set ordertotal = quantity * (price * (1 - discount))
where ordertotal = '';

select * 
from sales_missing_data_cleaned
where ordertotal = '';

select avg(ordertotal)
from sales_missing_data_cleaned

--coalesce 
select
  coalesce(price, 0) as adjusted_price
from sales_missing_data;

--case statement
select ordernum
  , ordertotal
  , case
    when ordertotal = '' then 'Missing'
    when ordertotal = 0 then 'Zero Value'
    else 'Valid'
  end as order_status
from sales_missing_data;
