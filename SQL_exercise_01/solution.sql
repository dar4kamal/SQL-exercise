-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store

CREATE TABLE Manufacturers (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL,
  PRIMARY KEY (Code)   
);

CREATE TABLE Products (
  Code INTEGER,
  Name VARCHAR(255) NOT NULL ,
  Price DECIMAL NOT NULL ,
  Manufacturer INTEGER NOT NULL,
  PRIMARY KEY (Code), 
  FOREIGN KEY (Manufacturer) REFERENCES Manufacturers(Code)
) ENGINE=INNODB;

INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- 1.1 Select the names of all the products in the store.
select Name from Products;

-- 1.2 Select the names and the prices of all the products in the store.
select Name, Price from Products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
select Name 
from Products
where Price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
select Name 
from Products
where Price between 60 and 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
select Name, Price * 100 as PriceInCents
from Products;

-- 1.6 Compute the average price of all the products.\
select AVG(Price) from Products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
select AVG(Price) from Products
where Manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
select COUNT(Code) from Products
where Price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
select Name,Price from Products
where Price >= 180
order by Price desc, Name asc;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
select * from Products
inner join Manufacturers on Manufacturers.Code = Products.Manufacturer;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
select Products.Name as Product, Products.Price, Manufacturers.Name as Manufacturer
from Products
inner join Manufacturers on Manufacturers.Code = Products.Manufacturer;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
-- No Need For Join as this query from the same table
select AVG(Products.Price), Manufacturers.Code as code
from Products
inner join Manufacturers on Manufacturers.Code = Products.Manufacturer
group by Manufacturers.Code;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
select avg(Products.Price), Manufacturers.Name as Name
from Products
inner join Manufacturers on Manufacturers.Code = Products.Manufacturer
group by Manufacturers.Name;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
select avg(Products.Price) as avgPrice, Manufacturers.Name as Name
from Products
inner join Manufacturers on Manufacturers.Code = Products.Manufacturer
group by Manufacturers.Name
having avgPrice >= 150;

-- 1.15 Select the name and price of the cheapest product.
select Products.Name, Products.Price
from Products
right join (
select min(Price) as Price
from Products ) as MinPrice
on Products.Price = MinPrice.Price;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
-- Not Finished
select manNameMaxPrice.ManufacturerName , Products.Name as ProductName, Products.Price as Price
from
(SELECT Manufacturers.Name as ManufacturerName, MAX(Price) as price
FROM Products, Manufacturers
WHERE Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name ) as manNameMaxPrice
join Products
on Products.Price = manNameMaxPrice.Price
group by manNameMaxPrice.ManufacturerName, Products.Name;
    
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
insert into Products values(11, 'Loudspeakers', 70, 2);

-- 1.18 Update the name of product 8 to "Laser Printer".
update Products
set Name = "Laser Printer"
where Code = 8;

-- 1.19 Apply a 10% discount to all products.
update Products
set Price = 0.9 * Price
where Code > 0;

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
update Products
set Price = 0.9 * Price
where Price >= 120;
