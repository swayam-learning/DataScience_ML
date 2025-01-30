USE SQLLEARNING;
CREATE TABLE students(
student_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(256) NOT NULL,
age INT CHECK(age >6 AND age <25)
);

INSERT INTO students (student_id, name, age) VALUES (122, "swayam", 24);
INSERT INTO students (student_id, name, age) VALUES (122, "swayam", 26); -- violates the condition

-- ------------------------------ DEFAULT ------------------------------------------------------------

CREATE TABLE ticket (
ticket_id INT PRIMARY KEY,
name VARCHAR(256) NOT NULL,
travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO ticket(ticket_id,name) VALUES (122, "swayam");
SELECT * FROM ticket;
-- ---------------------------------------------------------------------------------------------------
-- ----------------------------- FOREIGN KEY ---------------------------------------------------------
CREATE TABLE customers(
cid INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(256),
email VARCHAR(256)
);

CREATE TABLE orders(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    cid INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT order_fk FOREIGN KEY (cid) references customers(cid)
);

-- foreign key never allows to delete a table which depends on another table
INSERT INTO customers(cid,name,email) VALUES (1,"swayam","swayam@gmail.com");
INSERT INTO customers(cid,name,email) VALUES (2,"rahul","akhilesh@gmail.com");
INSERT INTO customers(cid,name,email) VALUES (3,"akhilesh","rahul@gmail.com");
INSERT INTO customers(cid,name,email) VALUES (4,"hitesh","hitwa@gmail.com");
SELECT * FROM customers;

INSERT INTO orders(order_id,cid) VALUES (122,1);
INSERT INTO orders(order_id,cid) VALUES (122,2);
INSERT INTO orders(order_id,cid) VALUES (122,3);
INSERT INTO orders(order_id,cid) VALUES (122,4);

SELECT * FROM orders;
-- -------------------------------------------------------------------------------------------------------

-- ---------------------------------------- REFRENTIAL ACTIONS on FOREIGN KEYS ----------------------------
-- RESTRICT by default in case of foreign keys
-- CASCADE if we delet it will be a chain and delete it on other tables as well ,similar in case of update
-- SET NULL if we delete the cid for one customer it will be set null in the orders table

-- ----------------------------------------CASCADE---------------------------------------------------------
CREATE TABLE customers1(
cid INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(256),
email VARCHAR(256)
);

INSERT INTO customers1(cid,name,email) VALUES (1,"swayam","swayam@gmail.com");
INSERT INTO customers1(cid,name,email) VALUES (2,"rahul","akhilesh@gmail.com");
INSERT INTO customers1(cid,name,email) VALUES (3,"akhilesh","rahul@gmail.com");
INSERT INTO customers1(cid,name,email) VALUES (4,"hitesh","hitwa@gmail.com");

CREATE TABLE orders1(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    cid INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT order_fk1 FOREIGN KEY (cid) references customers1(cid)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO orders1(order_id,cid) VALUES (122,1);
INSERT INTO orders1(order_id,cid) VALUES (123,2);
INSERT INTO orders1(order_id,cid) VALUES (124,3);
INSERT INTO orders1(order_id,cid) VALUES (125,4);

SELECT * FROM orders1;
DELETE FROM customers1 WHERE cid = 1;

-- ---------------------------------- SET NULL----------------------------------------------------
CREATE TABLE customers2(
cid INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(256),
email VARCHAR(256)
);

INSERT INTO customers2(cid,name,email) VALUES (1,"swayam","swayam@gmail.com");
INSERT INTO customers2(cid,name,email) VALUES (2,"rahul","akhilesh@gmail.com");
INSERT INTO customers2(cid,name,email) VALUES (3,"akhilesh","rahul@gmail.com");
INSERT INTO customers2(cid,name,email) VALUES (4,"hitesh","hitwa@gmail.com");
SELECT * FROM customers2;

CREATE TABLE orders2(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
    cid INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT order_fk2 FOREIGN KEY (cid) references customers2(cid)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

INSERT INTO orders2(order_id,cid) VALUES (122,1);
INSERT INTO orders2(order_id,cid) VALUES (123,2);
INSERT INTO orders2(order_id,cid) VALUES (124,3);
INSERT INTO orders2(order_id,cid) VALUES (125,4);

SELECT * FROM orders2;
DELETE FROM customers2 WHERE cid = 1;

-- ---------------------------------- SET DEFAULT----------------------------------------------------
-- MySQL does not support SET DEFAULT on FOREIGN KEY deletion or updation

-- ---------------------------------- ALTER ---------------------------------------------------------
ALTER TABLE customers2 ADD COLUMN passwords VARCHAR(256) NOT NULL;
SELECT * FROM customers2;
ALTER TABLE customers2 ADD COLUMN surname VARCHAR(256) NOT NULL AFTER name;
ALTER TABLE customers2 ADD COLUMN  pan_number VARCHAR(256) AFTER surname ,
ADD COLUMN joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP AFTER email;

ALTER TABLE customers2 	DROP COLUMN pan_number,
DROP COLUMN surname,
DROP COLUMN passwords;

ALTER TABLE customers2 MODIFY COLUMN cid BIGINT;

-- ---------------------------------- ADVANCE ALTER -----------------------------------------------
ALTER TABLE customers2 ADD COLUMN age INT NOT NULL;
UPDATE customers2 SET age = 26 where cid=2;
UPDATE customers2 SET age = 27 where cid=3;
UPDATE customers2 SET age = 28 where cid=4;
SELECT * FROM customers2;
ALTER TABLE customers2 ADD CONSTRAINT age_check  CHECK (age >24);
-- ---------------------------------to modify CONSTRAINT-------------------------------------------
ALTER TABLE customers2 DROP CONSTRAINT age_check;
ALTER TABLE customers2 ADD CONSTRAINT age_check CHECK (AGE>6);
-- -------------------------------------------------------------------------------------------------
