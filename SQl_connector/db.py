# to show the table and then allow the user to select the database and show it's tables
import pymysql
mydb = pymysql.connect(
    host = "<yourhostname>",
    user = "root",
    password = "<yourpassword>",
)
mycursor = mydb.cursor()

# Execute the query to show databases
mycursor.execute("SHOW DATABASES")

# Fetch all rows (databases)
databases = mycursor.fetchall()
print("available databses malik aap dekhiye naa")
for db in databases:
    print(db[0])

selected_db = input("\nEnter the name of the database you want to use: ")
if (selected_db,) in databases:
    # Connect to the selected database
    mycursor.execute(f"USE {selected_db}")

    # Execute the query to show tables in the selected database
    mycursor.execute("SHOW TABLES")

    # Fetch all rows (tables)
    tables = mycursor.fetchall()

    # Print the list of tables
    print(f"\nTables in database '{selected_db}':")
    for table in tables:
        print(table[0])
else:
    print(f"Database '{selected_db}' does not exist.")

mycursor.close()
mydb.close()

