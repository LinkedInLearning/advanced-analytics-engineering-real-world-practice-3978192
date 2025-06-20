with recrusive numbers(n) as (
select 1
union all 
select n + 1 from numbers where n < 10
)
select n from numbers;

--Running Total Recursive CTE
create table sales_running_totals as 
with ordered as (
select *
  , row_number() over (partition by EmpID order by OrderDate, OrderNum) as row_num
from sales_data_cleaned
)

, running_totals(EmpID, OrderDate, OrderNum, OrderTotal, row_num, RunningTotal) as (
  select EmpID
  , OrderDate
  , OrderNum
  , OrderTotal
  , row_num
  , OrderTotal as RunningTotal
from ordered
where row_num = 1

union all

select
  o.EmpID
  , o.OrderDate
  , o.OrderNum
  , o.OrderTotal
  , o.row_num
  , rt.RunningTotal + o.OrderTotal AS RunningTotal
from ordered as o
join running_totals rt
  on o.EmpID = rt.EmpID and o.row_num = rt.row_num + 1
)

select EmpID
  , OrderDate
  , OrderNum
  , OrderTotal
  , RunningTotal
from running_totals
order by EmpID, OrderDate, OrderNum;
