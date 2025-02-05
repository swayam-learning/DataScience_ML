create table example(
    cid INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE example1(
    cid INT,
    orders INT,
CONSTRAINT fk FOREIGN KEY (cid) REFERENCES example(cid) 
ON DELETE CASCADE
);

INSERT INTO example(cid,name,email) VALUES (1, "Swayam","swayam25@gmail.com");
INSERT INTO example(cid,name,email) VALUES (2, "Swrup","swarup25@gmail.com");

INSERT INTO example1 (orders) VALUES(24);
UPDATE example1 SET cid=1 WHERE orders=24;
SELECT * FROM example1;

SELECT * from example,example1;