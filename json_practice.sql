create table if not exists products_array (
    ProdNumber text primary key,
    ProdCategory text,
    ProdName text,
    Price real
);

select * from products_array

--JSON query basics, doesn't work in SQLite
select name
   , json_extract(details, '$.ProdNumber') as ProdNumber
from products;

select
    name,
    json_extract(details, '$.ProdName.ProdSubName') as ProdSubName
from products;

select name
   ,  json_extract(details, '$.features[0]') AS first_feature
from products;

select name
    , json_extract(details, '$.ProdName', '$.ProdName.ProdSubName') AS name_and_subname
from products;
