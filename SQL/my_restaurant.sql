-- create restaurant database
.open restaurant.db

-- 5 tables

-- table 1 Customers
DROP TABLE customers;

CREATE TABLE customers (
  customerid INT NOT NULL PRIMARY KEY,
  firstname TEXT,
  lastname TEXT,
  age INT,
  states TEXT
);

INSERT INTO customers values
(1,"Mike","Ehrmantraut", 25,"TX"),
(2,"Jane", "Smith", 32,"NM"),
(3,"Saul", "Goodman", 45,"NM"),
(4,"Walter", "White", 52,"TX"),
(5,"Michael", "Jones", 40,"AZ"),
(6,"Emily", "Brown", 22,"CO"),
(7,"David", "Miller", 35,"TX"),
(8,"Ashley", "Moore", 28,"AZ"),
(9,"Jessy", "Pinkman", 24,"NM"),
(10,"Hank","Schrader", 29,"TX");

-- table 2 menu
DROP TABLE menu;

CREATE TABLE menu (
  menuid INT NOT NULL PRIMARY KEY,
  name TEXT,
  price REAL
);

INSERT INTO menu values
(1,"Rancheros Platters",5.99),
(2,"Breakfast Burritos",3.99),
(3,"Nacho Supreme",5.59),
(4,"Hermanos Burger",4.79),
(5,"Grilled Chicken Sandwich",4.99);

-- table 3 branch
DROP TABLE branch;

CREATE TABLE branch (
  branchid INT NOT NULL PRIMARY KEY,
  store TEXT,
  code TEXT
);

INSERT INTO branch values
(1,"New Mexico","NM"),
(2,"Texas","TX"),
(3,"Arizona","AZ"),
(4,"Colorado","CO");

-- table 4 employee
DROP TABLE employee;
  
CREATE TABLE employee (
  staffid INT NOT NULL PRIMARY KEY,
  name TEXT,
  branchid INT
);

INSERT INTO employee VALUES
(1,"Gustavo",1),
(2,"John",2),
(3,"Jacob",3),
(4,"Bill",4);

-- table 5 orders
DROP TABLE orders;

CREATE TABLE orders (
  orderid INT NOT NULL PRIMARY KEY,
  customerid INT,
  menuid INT,
  staffid INT,
  branchid INT
);

--Create random order using python
/*import random

def random_numbers(i):
    orderid = str(i+1)
    customerid = str(random.randint(1, 10))
    menuid = str(random.randint(1, 5))
    staffid = str(random.randint(1, 4))
    branchid = str(random.randint(1, 4))
    return '(' + orderid + ',' + customerid + ',' + menuid + ',' + staffid + ',' + branchid + '),' + "\n" 

result = ""
for i in range(50):
    result += random_numbers(i)

print(result)*/

INSERT INTO orders VALUES
(1,8,1,1,4),
(2,9,4,4,2),
(3,1,4,2,2),
(4,5,2,3,3),
(5,2,1,2,4),
(6,9,4,4,2),
(7,9,5,4,3),
(8,1,4,4,3),
(9,8,1,1,3),
(10,1,4,1,2),
(11,5,4,1,2),
(12,4,4,3,4),
(13,8,1,1,1),
(14,6,2,2,3),
(15,4,5,2,3),
(16,7,2,3,3),
(17,3,1,1,4),
(18,2,3,1,3),
(19,6,5,2,3),
(20,7,4,3,2),
(21,9,3,3,1),
(22,4,5,4,4),
(23,10,2,3,3),
(24,5,4,4,4),
(25,7,4,1,3),
(26,4,1,4,4),
(27,8,4,4,3),
(28,4,4,1,3),
(29,8,4,1,3),
(30,2,5,3,4),
(31,6,5,3,4),
(32,9,3,2,4),
(33,6,3,1,2),
(34,1,4,4,3),
(35,1,5,2,3),
(36,4,4,3,3),
(37,7,3,3,1),
(38,1,4,2,1),
(39,6,4,3,3),
(40,2,5,4,2),
(41,4,4,4,1),
(42,4,1,1,3),
(43,8,4,3,3),
(44,3,5,2,4),
(45,6,4,2,2),
(46,2,1,2,3),
(47,2,3,1,4),
(48,5,3,4,3),
(49,7,3,1,4),
(50,2,4,3,2);

-- 5 queries include (JOIN, WITH, SUBQURIY, Arggate function)

.mode column
.header on

--Our menu
SELECT 
  menuid AS 'No.', 
  name AS Name,
  price AS Price
FROM menu
ORDER BY price desc;

-- Finding top spender
SELECT 
  customers.firstname ||' '|| customers.lastname Customers_Name,
  round(SUM(price),2) Total_spend
FROM orders
JOIN customers on orders.customerid = customers.customerid
JOIN menu ON orders.menuid = menu.menuid
JOIN branch ON branch.branchid = orders.branchid
GROUP BY Customers_Name
ORDER BY Total_spend desc;

-- Finding most visit branch from each customers
WITH customer_branch AS (
    SELECT 
      customers.customerid, 
      branch.store, 
      COUNT(orders.orderid) AS visit_count
    FROM customers
    JOIN orders ON customers.customerid = orders.customerid
    JOIN branch ON orders.branchid = branch.branchid
    GROUP BY customers.customerid, branch.store
)

SELECT 
  customers.firstname ||' '|| customers.lastname Customers_Name,
  customers.states AS 'Home State',
  customer_branch.store Branch
FROM customers
JOIN (
    SELECT 
      customerid,
      MAX(visit_count) AS max_visit_count
    FROM customer_branch
    GROUP BY customerid
) max_visits ON customers.customerid = max_visits.customerid
JOIN 
  customer_branch ON customers.customerid = customer_branch.customerid 
  AND max_visits.max_visit_count = customer_branch.visit_count
ORDER BY Branch;

-- finding total sale each banch
SELECT 
  branch.store, 
  SUM(menu.price) AS total_sale
FROM branch
JOIN orders ON branch.branchid = orders.branchid
JOIN menu ON orders.menuid = menu.menuid
GROUP BY branch.store;

-- Finding the most popular from each branch
WITH branch_menu AS (
    SELECT branch.code AS branch_code, menu.name AS menu_name, COUNT(orders.orderid) AS order_count
    FROM orders
    JOIN menu ON orders.menuid = menu.menuid
    JOIN branch ON orders.branchid = branch.branchid
    GROUP BY branch_code, menu_name
)

SELECT 
  branch.code AS Branch,
  branch_menu.menu_name, 
  branch_menu.order_count
FROM branch
JOIN (
    SELECT branch_code, MAX(order_count) AS max_order_count
    FROM branch_menu
    GROUP BY branch_code
) max_orders ON branch.code = max_orders.branch_code
JOIN 
  branch_menu ON branch.code = branch_menu.branch_code 
  AND max_orders.max_order_count = branch_menu.order_count
ORDER BY branch.code;

-- Finding employee of the month
SELECT 
  employee.name AS 'Staff Name', 
  COUNT(orders.staffid) AS Order_Count
FROM employee
JOIN 
  orders ON employee.staffid = orders.staffid
GROUP BY employee.name
ORDER BY Order_Count desc;
