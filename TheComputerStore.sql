/*
 * SQL Script designed and tested in MySQL Workbench
*/

USE Test;

DROP DATABASE IF EXISTS TheComputerStore;

CREATE database TheComputerStore;

USE TheComputerStore;

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

START TRANSACTION;

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

COMMIT;

INSERT INTO Products( Name , Price , Manufacturer) VALUES ( 'Loudspeakers' , 70 , 2 );

UPDATE Products
SET Name = 'Laser Printer'
WHERE Code = 8;

UPDATE Products
SET Price = Price * 0.9;

SHOW tables IN TheComputerStore;
SHOW columns FROM manufacturers;
SHOW columns FROM products;

/* playing with select */
SELECT * FROM manufacturers;
SELECT * FROM products;
SELECT Name FROM Products;
SELECT Name, Price FROM Products;
SELECT Name FROM Products WHERE Price <= 200;

/* With AND */
SELECT * FROM Products
WHERE Price >= 60 AND Price <= 120;
 
/* With BETWEEN */
SELECT * FROM Products
WHERE Price BETWEEN 60 AND 120;

/* Without AS */
SELECT Name, Price * 100 FROM Products;
 
/* With AS */
SELECT Name, Price * 100 AS PriceCents FROM Products;

SELECT AVG(Price) FROM Products;
SELECT AVG(Price) FROM Products WHERE Manufacturer=2;
SELECT COUNT(*) FROM Products WHERE Price >= 180;

SELECT Name, Price FROM Products
WHERE Price >= 180 ORDER BY Price DESC, Name;

/* Without INNER JOIN */
SELECT * FROM Products, Manufacturers
WHERE Products.Manufacturer = Manufacturers.Code;

/* With INNER JOIN */
SELECT * FROM Products 
INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code;

SELECT Products.Name, Price, Manufacturers.Name FROM Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code;

SELECT AVG(Price), Manufacturer FROM Products
GROUP BY Manufacturer;

SELECT AVG(Price), Manufacturers.Name FROM Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name;

SELECT AVG(Price), Manufacturers.Name FROM Products INNER JOIN Manufacturers
ON Products.Manufacturer = Manufacturers.Code
GROUP BY Manufacturers.Name HAVING AVG(Price) >= 150;

SELECT name,price FROM Products
ORDER BY price ASC
LIMIT 1;

/* With nested SELECT */
SELECT Name, Price FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products);