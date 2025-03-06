-- Active: 1740077526153@@127.0.0.1@3306@campusx_revise
CREATE DATABASE IF NOT EXISTS campusx_revise;
use campusx_revise;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Data Definition Language

-- Create
-- Drop
-- Truncate
-- Alter
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------Drop--------------------------------------------------------------------------------------------
-- DROP DATABASE IF EXISTS campusx_revise;

--------------------------------------------------------------Create-----------------------------------------------------------------------------------------------------------
CREATE TABLE users(
    user_id INTEGER,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

-------------------------------------------------------------Insert-----------------------------------------------------------------------------------------------
INSERT INTO users (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users (user_id,name, email, password) VALUES (2,"swarup", "swayamswaerup@gmail.com", "123345");
INSERT INTO users (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345");


SELECT * FROM users;
------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------Truncate -------------------------------------------------------------------------------------------------------

-- TRUNCATE TABLE users;
-- in truncating structure of the table remains, but data gets deleted
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  CONSTRAINTS IN MYSQL

-- NOT NULL✅
-- UNIQUE (combo)✅
-- PRIMARY KEY✅
-- AUTO INCREMENT✅
-- CHECK✅
-- DEFAULT✅
-- FOREIGN KEY✅
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------Not Null------------------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------Unique-------------------------------------------------------------------------------------------------------
CREATE TABLE users2(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);


INSERT INTO users2 (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users2 (user_id,name,email, password) VALUES (2,"swarup","swayamyo@gmail.com","123345");
INSERT INTO users2 (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users2 (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345");

SELECT * FROM users2;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------PRIMARY KEY----------------------------------------------------------------------------------------------------

CREATE TABLE users3(
    user_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);


INSERT INTO users3 (user_id,name, email, password) VALUES (1,"swayam", "swayam@gmail.com", "12345");
INSERT INTO users3 (user_id,name,email, password) VALUES (2,"swarup","swayamyo@gmail.com","123345");
INSERT INTO users3 (user_id,name, email, password) VALUES (3,"rahul", "jichand@gmail.com", "12345");
INSERT INTO users3 (user_id,name, email, password) VALUES (4,"chand", "chandjio@gmail.com", "123345");

SELECT * FROM users3;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------AUTO INCREMENT----------------------------------------------------------------------------------------------------------
CREATE TABLE users4(
    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);
INSERT INTO users4 (name, email, password) VALUES ("swayam", "swayam@gmail.com", "12345");
INSERT INTO users4 (name,email, password) VALUES("swarup","swayamyo@gmail.com","123345");
INSERT INTO users4 (name, email, password) VALUES ("rahul", "jichand@gmail.com", "12345");
INSERT INTO users4 (name, email, password) VALUES ("chand", "chandjio@gmail.com", "123345");

SELECT * FROM users4;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------ Constraints ------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE users5(
    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255),

    constraint users_email_unique UNIQUE(email)
);

INSERT INTO users5 (name, email, password) VALUES ("swayam", "swayam@gmail.com", "12345");
INSERT INTO users5 (name,email, password) VALUES("swarup","swayamyo@gmail.com","123345");
INSERT INTO users5 (name, email, password) VALUES ("rahul", "jichand@gmail.com", "12345");
INSERT INTO users5 (name, email, password) VALUES ("chand", "chandjio@gmail.com", "123345");

SELECT * FROM users5;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE users6(
    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255),

    constraint users_email_unique UNIQUE(name,email)
);

INSERT INTO users6 (name, email, password) VALUES ("swayam", "swayam@gmail.com", "12345");
INSERT INTO users6 (name,email, password) VALUES("swarup","swayamyo@gmail.com","123345");
INSERT INTO users6 (name, email, password) VALUES ("rahul", "jichand@gmail.com", "12345");
INSERT INTO users6 (name, email, password) VALUES ("chand", "chandjio@gmail.com", "123345");

SELECT * FROM users6;

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------Check--------------------------------------------------------------------------------------------------------------------------------------
CREATE Table users7(
    user_id INTEGER,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255),
    age INTEGER check(age>6 and age<20),

    constraint users_email_name_unique UNIQUE(name,email),
    constraint users_primary_key PRIMARY KEY(user_id)
);


INSERT INTO users7 (user_id,name, email, password,age) VALUES (1,"swayam", "swayam@gmail.com", "12345",18);
SELECT * FROM users7;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------Default-----------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE ticket(
    ticket_id INTEGER PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ticket(ticket_id,name) VALUES (1,"swayam");
SELECT * FROM ticket;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

-- SET DEFAULT
CREATE Table orders3(
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    cid INTEGER NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT orders_fk3 FOREIGN KEY (cid) REFERENCES customers(cid)
    ON DELETE SET DEFAULT
    ON UPDATE SET DEFAULT
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------ALTER---------------------------------------------------------------------------------------------------------------------------

SELECT * FROM customers;

-- add column
ALTER TABLE customers ADD COLUMN password VARCHAR(255) after email;
SELECT * FROM customers;

-- modify column
ALTER TABLE customers MODIFY COLUMN password VARCHAR(255) after name;
SELECT * FROM customers;

-- modify and add 
ALTER TABLE customers ADD COLUMN pan_number VARCHAR(255) AFTER name,
ADD COLUMN joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- delete column

ALTER TABLE customers drop COLUMN pan_number;
SELECT * FROM customers;