import pymysql

# to directly fetch a table directly from a database
mydb = pymysql.connect(
    host="<hostname>",
    user="root",
    password ="<password>",
    database="worker"
)

mycursor = mydb.cursor()

mycursor.execute("SHOW TABLES")
tables = mycursor.fetchall()
for tb  in tables:
    print(tb[0])

mycursor.close()
mydb.close()