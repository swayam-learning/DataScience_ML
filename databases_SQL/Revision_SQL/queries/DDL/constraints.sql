-- Active: 1728126369033@@127.0.0.1@3306@campusx
-- Data Definition Langauge (DDL)

-- CREATE DATABASE campusx;
-- USE campusx;
-- DROP DATABASE campusx;

-- CREATE DATABASE IF NOT EXISTS campusx;
-- DROP DATABASE if EXISTS campusx;

-------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE campusx;
USE campusx;

CREATE TABLE users(
    user_id INTEGER,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

INSERT INTO users (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users (user_id,name, email, password) VALUES (2,"swarup", "swayamswaerup@gmail.com", "123345");
INSERT INTO users (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345");


SELECT * FROM users;
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- Truncate

-- TRUNCATE TABLE users;
-------------------------------------------------------------------------------------------------------------------------------------------------------
-- DROP TABLE users;
-------------------------------------------------------------------------------------------------------------------------------------------------------

--  CONSTRAINTS IN MYSQL

-- NOT NULL
-- UNIQUE (combo)
-- PRIMARY KEY
-- AUTO INCREMENT
-- CHECK
-- DEFAULT
-- FOREIGN KEY

-- REFERENTIAL ACTIONS

-- RESTRICT
-- CASCADE
-- SET NULL
-- SET DEFAULT
-------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE users1(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255)
);


INSERT INTO users1 (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users1 (user_id,name, password) VALUES (2,"swarup", "123345");
INSERT INTO users1 (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users1 (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345");

SELECT * FROM users1;

-----------------------------------------------------------------------------------------------------------------------
---------------------------------------------UNIQUE--------------------------------------------------------------------------------
CREATE TABLE users2(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);


INSERT INTO users2 (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users2 (user_id,name,email, password) VALUES (2,"swarup", "swayam@gmail.com", "123345");
-- this will not work as email is unique
INSERT INTO users2 (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users2 (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345")

------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------- CONSTRAINT----------------------------------------------------------------
-- for eg: when we want name and email id combination to be unique , if we pass unique individually to the columns we will get unique name and unique emailid but not unique user_email_id combination

CREATE TABLE users3(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) not NULL,
    CONSTRAINT user_email_unique UNIQUE (name,email)
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------PRIMARY KEY----------------------------------------------------------------------------------------------------------------

CREATE TABLE users4(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) not NULL,
    CONSTRAINT user_email_unique UNIQUE (name,email),
    CONSTRAINT USER_PK PRIMARY KEY (user_id)
);


-- CREATE TABLE users5(
--     user_id INTEGER NOT NULL PRIMARY KEY,
--     name VARCHAR(255) NOT NULL PRIMARY KEY,
--     email VARCHAR(255) NOT NULL,
--     password VARCHAR(255) not NULL,
--     CONSTRAINT user_email_unique UNIQUE (name,email)
-- );  -- this wont work multiple primary keys but if we want we can use constraints

CREATE TABLE users5(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) not NULL,
    CONSTRAINT user_email_unique UNIQUE (name,email),
    CONSTRAINT USER_name_PK PRIMARY KEY (name,user_id)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------- AUTO_INCREMENT---------------------------------------------------------------------------------------------------------------------------
CREATE TABLE users6(
    user_id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) not NULL,
    CONSTRAINT user_email_unique UNIQUE (name,email),
    CONSTRAINT USER_PK PRIMARY KEY (user_id)
);


INSERT INTO users6 (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users6 (name,email, password) VALUES ("swarup", "swayamswarup@gmail.com","123345");
INSERT INTO users6 (name, email, password) VALUES ("rahul", "jichand@gmail.com", "12345");
INSERT INTO users6 (name, email, password) VALUES ("chand", "chandjio@gmail.com", "123345");

SELECT * FROM users6;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------- CHECK ------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE students (
    student_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INTEGER check (age>6 AND age <25),
    email VARCHAR(255) NOT NULL
);

-- INSERT INTO students (student_id,name, age ,email) VALUES (1,"swayam", 5, "swayamswarup@gmail.com"); constraint violated

INSERT INTO students (student_id,name, age ,email) VALUES (1,"swayam", 15, "swayamswarup@gmail.com");

SELECT * FROM students;

CREATE TABLE students1 (
    student_id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    age INTEGER,
    email VARCHAR(255) NOT NULL,
    CONSTRAINT age CHECK (age>6 AND age<25)
);

INSERT INTO students1 (student_id,name, age ,email) VALUES (1,"swayam", 15, "swayamswarup@gmail.com");

SELECT * FROM students1;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- DEFAULT---------------------------------------------------------------------------------------------------------------------

CREATE TABLE ticket(
    ticket_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ticket(ticket_id,name) VALUES (1,"swayam");
SELECT * FROM ticket;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------FOREIGN KEY -----------------------------------------------------------------------------------------------------------------------
CREATE TABLE customers(
    cid INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
    
);
CREATE Table orders(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_fk FOREIGN KEY (cid) REFERENCES customers(cid)
);


--  referential action on basis of foreign key------------------------------------------------------------------------------------------------------------------


-- cascade
CREATE Table orders1(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_fk1 FOREIGN KEY (cid) REFERENCES customers(cid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- SET NULL

CREATE Table orders2(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER ,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_fk2 FOREIGN KEY (cid) REFERENCES customers(cid)
    ON DELETE SET NULL
    ON UPDATE SET NULL
);

CREATE Table orders3(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_fk3 FOREIGN KEY (cid) REFERENCES customers(cid)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------- ALTER -------------------------------------------------------------------------------------------------------------------
ALTER TABLE customers ADD COLUMN password VARCHAR(255);
SELECT * FROM customers;

--  adding columns
ALTER TABLE customers ADD COLUMN surname VARCHAR(255) after name;

-- modify columns
ALTER TABLE customers MODIFY COLUMN surname VARCHAR(255) after cid;
-- we cannot use BEFORE , only AFTER  and FIRST
ALTER TABLE customers MODIFY COLUMN surname VARCHAR(255) FIRST;

ALTER TABLE customers ADD COLUMN pan_number VARCHAR(255) AFTER surname,
ADD COLUMN joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

--  deleting columns

ALTER TABLE customers DROP COLUMN pan_number;
SELECT*FROM customers;