USE SQLLEARNING;

/*
CREATE
RETRIEVE
UPDATE
DELETE
*/

CREATE TABLE boot(
    uid INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL 
);

INSERT INTO boot(uid,name,email,password) VALUES (12,"swayam","swayam@gmail.com","12345");
INSERT INTO boot(name,email,password) VALUES ("swwati","swaati@gmail.com","1234355");

INSERT INTO boot(name,email,password) VALUES ("rahul","rahul@gmail.com","12345325325");

INSERT INTO boot(name,email,password) VALUES ("ankit","ankit@gmail.com","212ds412345");

SELECT * FROM boot;

INSERT INTO sqllearning.boot VALUES ("16","rohan","rohan@gmail.com","2423e3"),("17","rohit","rohit@gmail.com","2423e3");

