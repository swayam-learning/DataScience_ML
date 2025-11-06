import pymysql

# connect to the database server
try:
    conn = pymysql.connect(
                host = '127.0.0.1',
                user = 'root',
                password = '12345',
                database= "indigo"
    )
    mycursor = conn.cursor()
    print("connection established")
except:
    print("connection error")

# create a databse in the db server

# mycursor.execute("Create Database indigo")
# conn.commit()

# Create table
# airport --> airport_id|code|name

# mycursor.execute('''
# CREATE TABLE airport(
#                  airport_id INTEGER PRIMARY KEY,
#                  code VARCHAR(10) NOT NUll,
#                  city VARCHAR(50) NOT NULL,
#                  name VARCHAR (255) NOT NULL
#                  )
#                  ''')
# conn.commit()

# insert data to the tables
# mycursor.execute("""
#     INSERT INTO airport VALUES
#         (1,'DEL','NEW DELHI','IGIA'),
#         (2,'CCU','KOLKATA','NSCA'),
#         (3,'BOM','MUMBAI','CSMA')
# """)
# conn.commit()

# Search / Retreive

mycursor.execute('SELECT * FROM airport WHERE airport_id>1')
data = mycursor.fetchall()
print(data)

for i in data:
    print(i[3])

# Update
mycursor.execute('''
        UPDATE airport
        SET city = 'BOMBAY'
        WHERE airport_id = 3
                 ''')
conn.commit()

