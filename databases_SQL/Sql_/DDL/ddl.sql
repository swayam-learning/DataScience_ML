CREATE DATABASE sqllearning;
DROP DATABASE sqllearning;

-- ddl commands 
CREATE DATABASE IF NOT EXISTS SQLLEARNING;
USE SQLLEARNING;
CREATE TABLE users(
user_id INTEGER,
name VARCHAR(256),
email VARCHAR (256),
password VARCHAR(256)
);
INSERT INTO users VALUES (1,"swayam","swayam@gmai;.com","12344");
SELECT * FROM users;
TRUNCATE TABLE users;-- retains the table structures
DROP TABLE USERS;
