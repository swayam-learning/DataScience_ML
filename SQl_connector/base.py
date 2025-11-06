import pymysql
import pandas as pd
mydb = pymysql.connect(
    host="<host name>",
    user="root",
    password="<your password>"
)

mycursor = mydb.cursor()
mycursor.execute("SHOW DATABASES")
db = mycursor.fetchall()
for i in db:
    print(i[0])
   
sel_db = input("Enter your favourite database: ")
if(sel_db,) in db:
    mycursor.execute(f"USE {sel_db}")
    mycursor.execute("SHOW TABLES")
    tb = mycursor.fetchall()
    for i in tb:
        print(i[0])
    
sel_tb = input("Enter your favourite table: ")
mycursor.execute(f"SELECT * FROM {sel_tb}")
rows = mycursor.fetchall()
column_names = [i[0] for i in mycursor.description]
df = pd.DataFrame(rows,columns=column_names)
print(df)
column_names_input = input("Enter column names you want to access (comma-separated): ")
columns = column_names_input.split(',')
if all(col in df.columns for col in columns):
    print(df[columns])
# # Expanded version of the check
# all_present = True
# for col in columns:
#     if col not in df.columns:
#         all_present = False
#         break

# if all_present:
#     print(df[columns])  # Accessing the specified columns
# else:
#     print("One or more column names entered do not exist in the DataFrame.")
