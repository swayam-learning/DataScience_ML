import pymysql

# connect to the database server
try:
    conn = pymysql.connect(
    host = '127.0.0.1',
    user = 'root',
    password = '12345'
    )
    mycursor = conn.cursor()
    print("connection established")
except:
    print("connection error")

# create a databse in the db server

# mycursor.execute("Create Database indigo")
# conn.commit()

# Create table
mycursor.execute("")