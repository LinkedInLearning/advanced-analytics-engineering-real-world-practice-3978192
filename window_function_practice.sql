--row number
with sales_order as (
select EmpID
  , OrderNum
  , OrderDate
  , row_number() over(partition by EmpID order by OrderDate) as row_nbr 
from sales_data_cleaned
order by EmpID, row_nbr
)

select * 
from sales_order
where row_nbr = 1;

--qualify example, doesn't work in SQLite
select EmpID
  , OrderNum
  , OrderDate
  , row_number() over(partition by EmpID order by OrderDate) as row_nbr 
from sales_data_cleaned
qualify row_nbr = 1
order by EmpID, row_nbr

--rank
select EmpID
  , sum(OrderTotal) as OrderTotalSum
  , rank() over(order by sum(OrderTotal) desc) as OrderTotalRank
from sales_data_cleaned
group by EmpID
order by OrderTotalRank;

select EmpID
  , count(OrderTotal) as OrderTotalCount
  , rank() over(order by count(OrderTotal) desc) as OrderTotalRank
from sales_data_cleaned
group by EmpID
order by OrderTotalRank;

select EmpID
  , count(OrderTotal) as OrderTotalCount
  , dense_rank() over(order by count(OrderTotal) desc) as OrderTotalRank
from sales_data_cleaned
group by EmpID
order by OrderTotalRank;

--lag
select date(OrderDate, 'start of month') AS OrderMonth
  , sum(OrderTotal) as OrderTotalSum
  , lag(sum(OrderTotal), 1, 0) over(order by date(OrderDate, 'start of month')) as PreviousMonthOrderTotalSum
  , (sum(OrderTotal) - lag(sum(OrderTotal), 1, 0) over(order by date(OrderDate, 'start of month'))) / sum(OrderTotal) as PercentChangeOrderTotalSum
from sales_data_cleaned
group by OrderMonth;