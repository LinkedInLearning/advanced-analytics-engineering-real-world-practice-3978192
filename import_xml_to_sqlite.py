import sqlite3
import xml.etree.ElementTree as ET

# Configuration
xml_filename = 'kineteco_products_array.xml'
db_filename = 'star_schema_database.db'
table_name = 'products_array_xml'

# Load XML
tree = ET.parse(xml_filename)
root = tree.getroot()

# Connect to SQLite
conn = sqlite3.connect(db_filename)
cursor = conn.cursor()

# Prepare SQL
insert_sql = f"""
INSERT INTO {table_name} (ProdNumber, ProdCategory, ProdName, Price)
VALUES (?, ?, ?, ?)
ON CONFLICT(ProdNumber) DO UPDATE SET
    ProdCategory = excluded.ProdCategory,
    ProdName = excluded.ProdName,
    Price = excluded.Price;
"""

# Iterate and insert
for category in root:
    category_name = category.tag
    for product in category.findall('Product'):
        prod_number = product.findtext('ProdNumber')
        prod_name = product.findtext('ProdName')
        price = float(product.findtext('Price', default='0'))
        cursor.execute(insert_sql, (prod_number, category_name, prod_name, price))

conn.commit()
conn.close()

print(f"Data from '{xml_filename}' has been uploaded to '{table_name}' in '{db_filename}'.")
