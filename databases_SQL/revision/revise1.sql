
----------------------------------------------------- CONSTRAINTS -------------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS Revising_sql;
-- DROP DATABASE Revising_sql;
-- TRUNCATE DATABASE Revising_sql;
USE Revising_sql;

CREATE TABLE users(
    user_id INTEGER,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);
DROP TABLE users;

SELECT * FROM users;
CREATE TABLE users(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255)
);

SELECT * FROM users;

CREATE TABLE users1(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    CONSTRAINT user_email_name UNIQUE (name,email)
);

SELECT * FROM users1;


CREATE TABLE users2(
    user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    password VARCHAR(255),
    CONSTRAINT user_email_name UNIQUE (name,email),
    CONSTRAINT userid_name PRIMARY KEY (user_id,name)

);

SELECT * FROM users2;