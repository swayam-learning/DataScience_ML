CREATE TABLE users (
    user_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)
);

INSERT INTO users(user_id,name,email,password) VALUES (1,"Nitish","nitish@gmail.com","p252h");
INSERT INTO users(user_id,name,email,password) VALUES (2,"Khushboo","khushboo@gmail.com","hxn9b");
INSERT INTO users(user_id,name,email,password) VALUES (3,"Vartika","vartika@gmail.com","9hu7j");
INSERT INTO users(user_id,name,email,password) VALUES (4,"Ankit","ankit@gmail.com","lkko3");
INSERT INTO users(user_id,name,email,password) VALUES (5,"Neha","neha@gmail.com","3i7qm");
INSERT INTO users(user_id,name,email,password) VALUES (6,"Anupama","anupama@gmail.com","46rdw2");
INSERT INTO users(user_id,name,email,password) VALUES (7,"Rishabh","rishabh@gmail.com","4sw123");

SELECT * FROM users;

CREATE TABLE restaurants (
    r_id INT PRIMARY KEY,
    r_name VARCHAR(255),
    cuisine VARCHAR(255)
);
INSERT INTO restaurants(r_id,r_name,cuisine) VALUES(1,"dominos","Italian");
INSERT INTO restaurants(r_id,r_name,cuisine) VALUES(2,"kfc","American");
INSERT INTO restaurants(r_id,r_name,cuisine) VALUES(3,"box8","North Indian");
INSERT INTO restaurants(r_id,r_name,cuisine) VALUES(4,"Dosa Plaza","South Indian");
INSERT INTO restaurants(r_id,r_name,cuisine) VALUES(5,"China Town","Chinese");

SELECT * FROM restaurants;

CREATE TABLE food(
    f_id INT PRIMARY KEY,
    f_name VARCHAR(255),
    type VARCHAR(255)
);
INSERT INTO food(f_id,f_name,type) VALUES (1, "Non-Veg Pizza","Non-Veg");
INSERT INTO food(f_id,f_name,type) VALUES (2, "Veg Pizza","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (3, "Choco Lava Cake","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (4, "Chicken Wings","Non-Veg");
INSERT INTO food(f_id,f_name,type) VALUES (5, "Chicken Popcorn","Non-Veg");
INSERT INTO food(f_id,f_name,type) VALUES (6, "Rice Meal","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (7, "Roti Meal","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (8, "Masala Dosa","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (9, "Rava Idli","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (10, "Schezwan Noodles","Veg");
INSERT INTO food(f_id,f_name,type) VALUES (11, "Veg Manchurian","Veg");
SELECT * FROM food;

CREATE TABLE menu (
    menu_id INT PRIMARY KEY,
    r_id INT,
    f_id INT,
    price INT
);

INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (1,1,1,450);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (2,1,2,400);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (3,1,3,100);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (4,2,3,115);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (5,2,4,230);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (6,2,5,300);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (7,3,3,80);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (8,3,6,160);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (9,3,7,140);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (10,4,6,230);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (11,4,8,180);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (12,4,9,120);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (13,5,6,250);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (14,5,10,220);
INSERT INTO menu(menu_id,r_id,f_id,price) VALUES (15,5,11,180);
SELECT * FROM menu;


CREATE TABLE orders (
    order_id INT,
    user_id INT,
    r_id INT,
    amount DECIMAL(10, 2),
    date DATE,
    partner_id INT,
    delivery_time INT,
    delivery_rating INT,
    restaurant_rating INT
);
INSERT INTO orders (order_id, user_id, r_id, amount, date, partner_id, delivery_time, delivery_rating, restaurant_rating)
VALUES
(1001, 1, 1, 550, '2022-05-10', 1, 25, 5, 3),
(1002, 1, 2, 415, '2022-05-26', 1, 19, 5, 2),
(1003, 1, 3, 240, '2022-06-15', 5, 29, 4, 0),
(1004, 1, 3, 240, '2022-06-29', 4, 42, 3, 5),
(1005, 1, 3, 220, '2022-07-10', 1, 58, 1, 4),
(1006, 2, 2, 530, '2022-06-10', 2, 16, 5, 0),
(1007, 2, 3, 240, '2022-07-03', 2, 33, 4, 3),
(1008, 2, 4, 350, '2022-07-07', 1, 41, 1, 1),
(1009, 3, 1, 850, '2022-07-31', 1, 67, 1, 4),
(1010, 3, 2, 650, '2022-05-05', 2, 21, 5, 5),
(1011, 3, 3, 400, '2022-05-20', 1, 55, 5, 4),
(1012, 3, 4, 480, '2022-06-10', 1, 33, 4, 1),
(1013, 4, 1, 230, '2022-05-15', 1, 31, 5, 1),
(1014, 4, 2, 300, '2022-06-05', 1, 30, 4, 2),
(1015, 4, 3, 450, '2022-05-25', 2, 45, 5, 4),
(1016, 4, 4, 640, '2022-06-10', 2, 40, 2, 3),
(1017, 5, 1, 645, '2022-06-15', 1, 42, 5, 4),
(1018, 5, 2, 400, '2022-06-30', 2, 40, 5, 2),
(1019, 5, 3, 300, '2022-07-05', 2, 43, 3, 4),
(1020, 5, 4, 645, '2022-07-08', 2, 50, 1, 1),
(1021, 1, 1, 645, '2022-07-15', 2, 44, 4, 3),
(1022, 2, 2, 645, '2022-07-28', 2, 44, 4, 1),
(1023, 5, 2, 645, '2022-07-28', 2, 44, 4, 1),
(1024, 5, 2, 645, '2022-07-21', 2, 58, 2, 1),
(1025, 5, 2, 645, '2022-07-28', 2, 44, 4, 0);

SELECT * FROM orders;

CREATE TABLE delivery_partner(
    partner_id INT PRIMARY KEY,
    partner_name VARCHAR(255)
);

INSERT INTO delivery_partner(partner_id,partner_name) VALUES(1,"Suresh");
INSERT INTO delivery_partner(partner_id,partner_name) VALUES(2,"Amit");
INSERT INTO delivery_partner(partner_id,partner_name) VALUES(3,"Lokesh");
INSERT INTO delivery_partner(partner_id,partner_name) VALUES(4,"Kartik");
INSERT INTO delivery_partner(partner_id,partner_name) VALUES(5,"Gyandeep");
SELECT * FROM delivery_partner;

CREATE TABLE order_details(
    id INT PRIMARY KEY,
    order_id INT,
    r_id INT
);
INSERT INTO order_details(id,order_id,r_id) VALUES(1,1001,1);
INSERT INTO order_details(id,order_id,r_id) VALUES(2,1001,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(3,1002,4);
INSERT INTO order_details(id,order_id,r_id) VALUES(4,1002,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(5,1003,6);
INSERT INTO order_details(id,order_id,r_id) VALUES(6,1003,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(7,1004,6);
INSERT INTO order_details(id,order_id,r_id) VALUES(8,1004,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(9,1005,7);
INSERT INTO order_details(id,order_id,r_id) VALUES(10,1005,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(11,1006,1);
INSERT INTO order_details(id,order_id,r_id) VALUES(12,1006,2);
INSERT INTO order_details(id,order_id,r_id) VALUES(13,1006,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(14,1007,4);
INSERT INTO order_details(id,order_id,r_id) VALUES(15,1007,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(16,1008,6);
INSERT INTO order_details(id,order_id,r_id) VALUES(17,1008,3);
INSERT INTO order_details(id,order_id,r_id) VALUES(18,1009,8);
INSERT INTO order_details(id,order_id,r_id) VALUES(19,1009,9);
INSERT INTO order_details(id,order_id,r_id) VALUES(20,1010,10);
INSERT INTO order_details(id,order_id,r_id) VALUES(21,1010,11);
INSERT INTO order_details(id,order_id,r_id) VALUES(22,1010,6);
INSERT INTO order_details(id,order_id,r_id) VALUES(23,1011,1);
INSERT INTO order_details(id,order_id,r_id) VALUES(24,1012,8);
INSERT INTO order_details(id,order_id,r_id) VALUES(25,1013,4);
INSERT INTO order_details(id,order_id,r_id) VALUES(26,1014,4);
INSERT INTO order_details(id,order_id,r_id) VALUES(27,1015,4);

SELECT * FROM order_details;