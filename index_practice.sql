create index idx_empid on sales_data_cleaned(EmpID);

pragma index_list('sales_data_cleaned');

create unique index idx_ordernum on sales_data_cleaned(OrderNum);

explain query plan 
select * 
from sales_data_cleaned 
where EmpID = 900018483;