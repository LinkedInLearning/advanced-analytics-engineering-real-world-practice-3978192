create table if not exists products_array_xml (
    ProdNumber text primary key,
    ProdCategory text,
    ProdName text,
    Price real
);

select *
from products_array_xml;