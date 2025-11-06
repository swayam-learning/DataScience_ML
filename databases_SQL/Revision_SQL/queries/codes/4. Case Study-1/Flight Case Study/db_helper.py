import pymysql

class DB:
    def __init__(self):
        try:
            self.conn = pymysql.connect(
                        host = '127.0.0.1',
                        user = 'root',
                        password = '12345',
                        database= 'flights'
            )
            self.mycursor = self.conn.cursor()
            print("connection established")
        except:
            print("connection error")
    def fetch_city_names(self):
        city = []
        self.mycursor.execute('''
                   select distinct(destination) from flights_cleaned
                   union
                   select distinct(Source) from flights_cleaned;
                              ''')
        data = self.mycursor.fetchall()
        for item in data:
            city.append(item[0])
        return city

    def fetch_all_flights(self,source,destination):
        self.mycursor.execute("""
                               SELECT Airline,Route,Dep_Time,Duration,Price 
                               FROM flights_cleaned
                               WHERE source = '{}' and destination ='{}'
                               """.format(source,destination))
        data = self.mycursor.fetchall()
        return data        
    
    def fetch_airline_frequency(self):
        airline = []
        frequency = []
        self.mycursor.execute (
            """
                select airline,count(*) from flights_cleaned group by airline
            """
        )
        data = self.mycursor.fetchall()
        for item in data:
            airline.append(item[0])
            frequency.append(item[1])

        return airline,frequency
