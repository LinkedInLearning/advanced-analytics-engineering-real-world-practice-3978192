#hash practice
import hashlib

def hash_email(email):
    return hashlib.sha256(email.encode()).hexdigest()

email = "user@example.com"
hashed = hash_email(email)
print("Hashed email:", hashed)

#hashing our customer's names
import sqlite3
import hashlib

conn = sqlite3.connect("star_schema_database.db")
cursor = conn.cursor()

cursor.execute("SELECT CustID, CustName FROM dim_customers")
rows = cursor.fetchall()

def hash_value(value):
    return hashlib.sha256(value.encode()).hexdigest()

hashed_customers = []
for CustID, CustName in rows:
    hashed_name = hash_value(CustName)
    hashed_customers.append((CustID, hashed_name))

for CustID, hashed_name in hashed_customers:
    print(f"CustID: {CustID}, Hashed Name: {hashed_name}")


#encrpytion practice
import sqlite3
from cryptography.fernet import Fernet

#generate a key and store it securely 
key = Fernet.generate_key()
cipher = Fernet(key)

conn = sqlite3.connect("star_schema_database.db")
cursor = conn.cursor()

cursor.execute("SELECT CustID, CustName FROM dim_customers")
rows = cursor.fetchall()

for CustID, CustName in rows:
    encrypted_name = cipher.encrypt(CustName.encode())
    decrypted_name = cipher.decrypt(encrypted_name).decode()
    
    print(f"CustID: {CustID}")
    print(f"Encrypted Name: {encrypted_name}")
    print(f"Decrypted Name: {decrypted_name}")
    print("-" * 40)

conn.close()


#tokenization practice
import sqlite3
import uuid

conn = sqlite3.connect("star_schema_database.db")
cursor = conn.cursor()

cursor.execute("SELECT CustID, CustName FROM dim_customers")
rows = cursor.fetchall()

token_map = {}

for CustID, CustName in rows:
    token = str(uuid.uuid4())  
    token_map[CustName] = token
    print(f"CustID: {CustID}")
    print(f"Original Name: {CustName}")
    print(f"Tokenized Name: {token}")
    print("-" * 40)

conn.close()
