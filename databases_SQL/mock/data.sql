-- Active: 1740077526153@@127.0.0.1@3306@mock_database_intr

CREATE DATABASE if NOT EXISTS mock_database_intr;
use mock_database_intr; 
CREATE TABLE cities (
  city_id INT PRIMARY KEY,
  city_name VARCHAR(50)
);

INSERT INTO cities VALUES 
(1, 'Mumbai'),
(2, 'Delhi'),
(3, 'Bangalore');

CREATE TABLE dishes (
  dish_id INT PRIMARY KEY,
  dish_name VARCHAR(100)
);

INSERT INTO dishes VALUES 
(101, 'Chicken Biryani'),
(102, 'Paneer Butter Masala'),
(103, 'Veg Burger'),
(104, 'Butter Chicken'),
(105, 'Chole Bhature'),
(106, 'Rajma Rice');

CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  user_id INT,
  dish_id INT,
  order_date DATE,
  city_id INT
);

INSERT INTO orders VALUES
(1, 201, 101, '2025-05-01', 1),
(2, 202, 101, '2025-05-02', 1),
(3, 203, 102, '2025-05-03', 1),
(4, 204, 103, '2025-05-04', 1),
(5, 205, 103, '2025-05-05', 1),
(6, 206, 102, '2025-05-06', 1),
(7, 207, 101, '2025-05-07', 1),
(8, 208, 104, '2025-05-01', 2),
(9, 209, 105, '2025-05-02', 2),
(10, 210, 105, '2025-05-03', 2),
(11, 211, 106, '2025-05-04', 2),
(12, 212, 104, '2025-05-05', 2),
(13, 213, 104, '2025-05-06', 2),
(14, 214, 106, '2025-05-07', 2),
(15, 215, 106, '2025-05-08', 2),
(16, 216, 101, '2025-05-01', 3),
(17, 217, 101, '2025-05-02', 3),
(18, 218, 102, '2025-05-03', 3),
(19, 219, 103, '2025-05-04', 3),
(20, 220, 103, '2025-05-05', 3);
