import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# CSV to pandas
csv_path = r"C:\Users\gkandekwe\Documents\Data_engineering\week1_setup\data\green_tripdata_2019-10.csv"


df = pd.read_csv(csv_path)

# Connect to PostgreSQL
engine = create_engine("postgresql://postgres:postgres@localhost:5433/ny_taxi")

# Write to the database
df.to_sql("green_tripdata", engine, if_exists="replace", index=False)
