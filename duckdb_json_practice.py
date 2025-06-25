import duckdb
import json

json_filename = 'kineteco_products_array.json'

con = duckdb.connect(database=':memory:', read_only=False)

print(f"Querying data directly from {json_filename} using DuckDB...")

query_json = f"""
SELECT
    category.key AS ProdCategory,
    product.value ->> 'ProdNumber' AS ProdNumber,
    product.value ->> 'ProdName' AS ProdName,
    CAST(product.value ->> 'Price' AS DOUBLE) AS Price
FROM
    read_json_auto('{json_filename}') AS raw_data,
    json_each(raw_data) AS category,
    json_each(category.value) AS product;
"""

try:
    results = con.execute(query_json).fetchdf()
    print("Query Results (first 5 rows):")
    print(results.head())

except Exception as e:
    print(f"An error occurred: {e}")
finally:
    con.close()