USE sqllearning;
-- constraints

CREATE TABLE users(
user_id INTEGER NOT NULL,
name VARCHAR(256) NOT NULL,
email VARCHAR(256) UNIQUE,
password VARCHAR(256)
);
-- DROP TABLE users;
--  NOT NULL enusres we have some value and UNIQUE enusres it has unique values
-- we cannot have same email id for two different names

CREATE TABLE users1(
user_id INTEGER NOT NULL,
name VARCHAR(256) NOT NULL,
email VARCHAR(256) NOT NULL,
password VARCHAR(256) NOT NULL,

CONSTRAINT users1_email_unique UNIQUE(email),
CONSTRAINT users1_name_email_unique_combo UNIQUE (name,email)
);

SELECT * FROM users1;

-- ------------------- UNIQUE ---------------------------------------

CREATE TABLE users2(
user_id INTEGER NOT NULL,
name VARCHAR(256) NOT NULL,
email VARCHAR(256) NOT NULL,
password VARCHAR(256) NOT NULL,

CONSTRAINT users2_email_unique UNIQUE(email),
CONSTRAINT users2_name_email_unique_combo UNIQUE (name,email),
CONSTRAINT users2_pk PRIMARY KEY (name)
);

SELECT * FROM users2;

CREATE TABLE users3(
user_id INTEGER AUTO_INCREMENT ,
name VARCHAR(256) NOT NULL,
email VARCHAR(256) NOT NULL,
password VARCHAR(256) NOT NULL,

CONSTRAINT users2_email_unique UNIQUE(email),
CONSTRAINT users2_name_email_unique_combo UNIQUE (name,email),
CONSTRAINT users2_pk PRIMARY KEY (user_id)
);

INSERT INTO users3 (name, email, password) VALUES ("swayam", "swayam@gmail.com", "12345");
INSERT INTO users3 (name, email, password) VALUES ("swarup", "swayamswaerup@gmail.com", "123345");
INSERT INTO users3 (name, email, password) VALUES ("rahul", "jichand@gmail.com", "12345");
INSERT INTO users3 (name, email, password) VALUES ("chand", "chandjio@gmail.com", "123345");

SELECT * FROM users3;


