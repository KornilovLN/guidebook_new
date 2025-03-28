# Viewing SQLite3 Database Contents
### There are several ways to view the contents of a SQLite3 database. Here are the most common methods:

## Using the SQLite3 Command Line Tool
* The SQLite3 command line tool is the most direct way to examine a database:
```
sqlite3 your_database.db
```
* Once inside the SQLite shell, you can run various commands:
  * List all tables
```
.tables
```
  * Show schema for a specific table
```
.schema table_name
```
  * Display data from a table
```
SELECT * FROM table_name;
```
  * Format output for better readability
```
.mode column
.headers on
```
* Exit the SQLite shell
```
.quit
```

## Using SQLite Browser Tools
* If you prefer a graphical interface, you can install DB Browser for SQLite:
  * On Ubuntu/Debian

```
sudo apt-get install sqlitebrowser
```
  * On Windows
```
Download from the official website: https://sqlitebrowser.org/dl/
```
  * Using Python - You can also view SQLite database contents using Python:
```python
import sqlite3

# Connect to the database
conn = sqlite3.connect('your_database.db')
cursor = conn.cursor()

# Get list of tables
cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = cursor.fetchall()
print("Tables in the database:")
for table in tables:
    print(f"- {table[0]}")

# Example: Query data from a specific table
# Replace 'table_name' with an actual table name from your database
cursor.execute("SELECT * FROM table_name")
rows = cursor.fetchall()

# Print column names
column_names = [description[0] for description in cursor.description]
print("\nColumns:", column_names)

# Print data
print("\nData:")
for row in rows:
    print(row)

conn.close()
```
  * view_sqlite.py <-- Run this script with:
```
python view_sqlite.py
```
