## Data Import & ETL

### Tasks Completed
- Created ShopSmart_Retail_Analytics database.
- Designed a staging table for raw data.
- Investigated MySQL Workbench import limitations.
- Validated the cleaned CSV file.
- Built a Python ETL script using Pandas and SQLAlchemy.
- Successfully loaded 51,255 records into MySQL.
### Key Learning

Initially, I attempted to import the dataset using MySQL Workbench's Import Wizard, but it loaded only a small portion of the data. Instead of relying on the GUI, I implemented a Python-based ETL pipeline that reads the CSV and loads it directly into MySQL. During implementation, I also learned how SQLAlchemy connection URLs handle special characters in passwords.
