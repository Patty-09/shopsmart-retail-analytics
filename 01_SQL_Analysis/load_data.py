import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

# MySQL Connection Configuration

connection_url = URL.create(
    drivername="mysql+pymysql",
    username="root",
    password="prati#2004",          
    host="localhost",
    port=3306,
    database="ShopSmart_Retail_Analytics"
)

engine = create_engine(connection_url)

# Read CSV File

csv_path = r"C:\Users\DELL\Downloads\superstore.csv"

df = pd.read_csv(
    csv_path,
    encoding="utf-8"
)

print(f"Rows Loaded from CSV: {len(df)}")


# Upload Data to MySQL

df.to_sql(
    name="global_superstore_raw",
    con=engine,
    if_exists="replace",      # Replace table if it already exists
    index=False
)


print("====================================")
print("Data Imported Successfully!")
print(f"Total Rows Imported: {len(df)}")
print("====================================")