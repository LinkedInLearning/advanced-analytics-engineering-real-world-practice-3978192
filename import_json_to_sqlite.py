import json
import sqlite3

#Configuration
json_filename = 'kineteco_products_array.json'
db_filename = 'star_schema_database.db'
table_name = 'products_array'

#Load JSON Data
with open(json_filename, 'r', encoding='utf-8') as f:
    data = json.load(f)

#Connect to SQLite Database
conn = sqlite3.connect(db_filename)
cursor = conn.cursor()

#Prepare INSERT SQL
insert_sql = f"""
INSERT INTO {table_name} (ProdNumber, ProdCategory, ProdName, Price)
VALUES (?, ?, ?, ?)
ON CONFLICT(ProdNumber) DO UPDATE SET
    ProdCategory = excluded.ProdCategory,
    ProdName = excluded.ProdName,
    Price = excluded.Price;
"""

#Iterate and Insert Data
for category, products_list in data.items():
    for product in products_list:
        prod_number = product.get('ProdNumber')
        prod_name = product.get('ProdName')
        price = product.get('Price')

        cursor.execute(insert_sql, (prod_number, category, prod_name, price))

#Commit Changes and Close Connection
conn.commit()
conn.close()

print(f"Data from '{json_filename}' has been uploaded to '{table_name}' in '{db_filename}'.")