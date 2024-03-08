Create database Ecom

create table customers (
customer_id int identity (1,1) Primary Key,
CustomerName varchar(50),
email varchar(50),
Customer_address varchar(100) );

create table products (
product_id int identity(1,1)Primary Key,
ProductName varchar(50),
price decimal(10,2),
DescriptionOfProduct text,
stockQuantity int);

 create table cart (
cart_id int identity(1,1)Primary Key,
customer_id int,
product_id int,
quantity int
foreign key(customer_id) references customers(customer_id),
foreign key(product_id) references products(product_id));

create table orders(
order_id int identity(1,1)Primary Key,
customer_id int,
order_date date,
total_price decimal(10,2),
shipping_address text,
foreign key (customer_id) references customers(customer_id));

create table order_items (
order_item_id int identity(1,1)Primary Key,
order_id int,
product_id int,
quantity int,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id));

--inserting records
insert into customers(CustomerName ,email ,Customer_address)
values
('John Doe', 'johndoe@example.com', '123 Main St, City'),
('Jane Smith' ,'janesmith@example.com','456 Elm St, Town'),
('Robert Johnson', 'robert@example.com', '789 Oak StVillage'),
( 'Sarah Brown', 'sarah@example.com' ,'101 Pine St, Suburb'),
( 'David Lee', 'david@example.com', '234 Cedar St, District'),
( 'Laura Hall', 'laura@example.com', '567 Birch St, County'),
( 'Michael Davis', 'michael@example.com' ,'890 Maple St, State'),
('Emma Wilson', 'emma@example.com', '321 Redwood St, Country'),
('William Taylor', 'william@example.com', '432 Spruce St, Province'),
('Olivia Adams', 'olivia@example.com', '765 Fir St, Territory');

DBCC CHECKIDENT (customers, RESEED, 1);

insert into products(ProductName, DescriptionOfProduct, price, stockQuantity)
values
( 'Laptop' ,'High-performance laptop' ,800.00, 10),
('Smartphone','Latest smartphone' ,600.00, 15),
('Tablet','Portable tablet' ,300.00 ,20),
('Headphones', 'Noise-canceling' ,150.00, 30),
('TV', '4K Smart TV' ,900.00 ,5),
('Coffee Maker', 'Automatic coffee maker', 50.00, 25);
select*from products
insert into products(ProductName, DescriptionOfProduct, price, stockQuantity)
values
( 'Refrigerator' ,'Energy-efficient' ,700.00, 10),
('Microwave Oven','Countertop microwave' ,80.00, 15),
('Blender','High-speed blender' ,70.00 ,20),
('Vacuum Cleaner', 'Bagless vacuum cleaner' ,120.00 ,10);
alter table products
add category varchar(20)


DBCC CHECKIDENT (orders, RESEED, 1);


insert into orders(customer_id, order_date,total_price)
values
( 1 ,'2023-01-05' ,1200.00),
(2,'2023-02-10' , 900.00),
(3,'2023-03-15' ,300.00),
(4, '2023-04-20' ,150.00),
(5, '2023-05-25' , 1800.00),
(6, '2023-06-30',  400.00),
( 7 ,'2023-07-05' ,700.00),
(8,'2023-08-10' ,160.00),
(9,'2023-09-15' ,140.00),
( 10,'2023-10-20' ,1400.00);
select* from orders

alter table order_items
add Total_amount decimal(10,2)
DBCC CHECKIDENT (order_items, RESEED, 1);


insert into order_items(order_id,product_id,quantity,Total_amount)
values
( 1 ,1,2,1600.00),
(1,3 ,1, 300.00),
(2,2 ,3,1800.00),
(3, 5 ,2,1800.00),
(4, 4 ,4, 600.00),
(4, 6, 1, 50.00),
( 5,1 ,1,800.00),
(5,2 ,2,1200.00),
(6,10 ,2,240.00),
( 6,9 ,3,2100.00);


DBCC CHECKIDENT (order_items, RESEED, 1);

insert into cart(customer_id, product_id, quantity)
values
(1,1,2),
(1,3,1),
(2,2,3),
(3,4,4),
(3,5 ,2),
(4, 6, 1),
(5, 1,1),
(6, 10,2),
(6, 9, 3),
(7, 7, 2);
select*from products

--Update refrigerator product price to 800.
UPDATE products
SET price = 800.00
WHERE product_id = 7;

select * from cart
--2. Remove all cart items for a specific customer.
delete from cart where customer_id=1

--3. Retrieve Products Priced Below $100.
select * from products where price<100

--4. Find Products with Stock Quantity Greater Than 5.

select * from products where stockQuantity>5

--5. Retrieve Orders with Total Amount Between $500 and $1000.

select *from orders
where total_price between 500.00 AND 1000.00;

--6. Find Products which name end with letter ‘r’.

select *
from products where ProductName LIKE '%r';

--7. Retrieve Cart Items for Customer 5.
select *from cart
where customer_id = 5;

--8. Find Customers Who Placed Orders in 2023.

select distinct *FROM customers c
join orders o on c.customer_id = o.customer_id
where o.order_date between '2023-01-01' AND '2023-12-31'

--9. Determine the Minimum Stock Quantity for Each Product Category.
select min(stockQuantity) as min_stock_quantity,category
from products
group by category;
select * from products

--10. Calculate the Total Amount Spent by Each Customer.
select c.customer_id, c.CustomerName as Customer_Name, sum(o.total_price) AS total_amount_spent
from customers c
JOIN orders o ON c.customer_id = o.customer_id
group by c.customer_id, c.CustomerName;

--11. Find the Average Order Amount for Each Customer.
select o.customer_id, avg(o.total_price) AS average_order_amount
from orders o
group BY o.customer_id;

--12. Count the Number of Orders Placed by Each Customer.
select customer_id,count(order_id) as total_orders
FROM orders
group by customer_id;

--13. Find the Maximum Order Amount for Each Customer.
select customer_id, max(total_price) AS max_order_amount
from orders
group by customer_id;

--14. Get Customers Who Placed Orders Totaling Over $1000.
select c.customer_id,c.CustomerName,c.email,c.Customer_address from customers c
join orders o ON c.customer_id = o.customer_id
group by c.customer_id,c.CustomerName,c.email,c.Customer_address
having SUM(o.total_price) > 1000.00;

--15. Subquery to Find Products Not in the Cart.
select *from products
where product_id NOT IN (select distinct product_id FROM cart);

--16. Subquery to Find Customers Who Haven't Placed Orders.
select *
from customers
where customer_id not in (select distinct customer_id FROM orders);

--17. Subquery to Calculate the Percentage of Total Revenue for a Product.
select product_id, ProductName, price, (price * 100 / (select SUM(total_price) from orders)) as revenue_percentage
from products;

--18. Subquery to Find Products with Low Stock.
select *from products
where stockQuantity < (select avg(stockQuantity) from products);

--19. Subquery to Find Customers Who Placed High-Value Orders.
select *from customers
where customer_id in (select customer_id from orders 
where total_price = (select max(total_price) as Maximum_value from orders))
