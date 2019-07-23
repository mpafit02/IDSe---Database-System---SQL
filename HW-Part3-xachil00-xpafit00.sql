ALTER TABLE employee DROP CONSTRAINT department_fk;
--ALTER TABLE department DROP CONSTRAINT managerID_fk;
ALTER TABLE department DROP CONSTRAINT storeID_fk;
ALTER TABLE cash_register DROP CONSTRAINT storeID_fk_creg;
ALTER TABLE cash_register DROP CONSTRAINT operator_fk;
ALTER TABLE supplier DROP CONSTRAINT storeID_fk_sup;
ALTER TABLE customer DROP CONSTRAINT storeID_fk_cus;
ALTER TABLE product DROP CONSTRAINT storeID_fk_prod;
ALTER TABLE supplies DROP CONSTRAINT productID_fk;
ALTER TABLE supplies DROP CONSTRAINT supplierID_fk;
ALTER TABLE buys DROP CONSTRAINT productID_fk_buy;
ALTER TABLE buys DROP CONSTRAINT customerID_fk_buy;

DELETE FROM supermarket;
DELETE FROM department;
DELETE FROM cash_register;
DELETE FROM supplier;
DELETE FROM customer;
DELETE FROM employee;
DELETE FROM product;
DELETE FROM supplies;
DELETE FROM buys;

DROP TABLE employee;
DROP TABLE department;
DROP TABLE cash_register;
DROP TABLE supplier;
DROP TABLE customer;
DROP TABLE supermarket;
DROP TABLE product;
DROP TABLE supplies;
DROP TABLE buys;
DROP VIEW Table2;
--DROP TRIGGER product_price;

CREATE TABLE employee(
  employeeID NUMBER(10) NOT NULL,
   CONSTRAINT employeeID_pk PRIMARY KEY (employeeID),
  firstName VARCHAR2(25 CHAR) NOT NULL,
  lastName VARCHAR2(25 CHAR) NOT NULL,
  salary NUMBER(5) NOT NULL,
  phone NUMBER(10) NOT NULL UNIQUE,
  departmentID VARCHAR2(25 CHAR) NOT NULL
);
CREATE TABLE department(
  departmentID VARCHAR2(25 CHAR) NOT NULL,
   CONSTRAINT departmentID_pk PRIMARY KEY (departmentID),
  --managerID NUMBER(10) NOT NULL,
  storeID NUMBER(10) NOT NULL
);
CREATE TABLE supermarket(
  storeID NUMBER(10) NOT NULL,
  CONSTRAINT storeID_pk PRIMARY KEY (storeID),
  storeName VARCHAR2(25 CHAR) NOT NULL,
  phone NUMBER(10) NOT NULL,
  address VARCHAR2(60 CHAR) NOT NULL
);
CREATE TABLE cash_register(
  cashRegID NUMBER(10) NOT NULL,
  CONSTRAINT cashRegID_pk PRIMARY KEY (cashRegID),
  money NUMBER(5) DEFAULT 0 NOT NULL,
  storeID NUMBER(10) NOT NULL,
  operatorOfReg NUMBER(10) NOT NULL  
);
CREATE TABLE supplier(
   supplierID NUMBER(10) NOT NULL,
   CONSTRAINT supplierID_pk PRIMARY KEY (supplierID),
   firstName VARCHAR2(25 CHAR) NOT NULL,
   lastName VARCHAR2(25 CHAR) NOT NULL,
   address VARCHAR2(60 CHAR) NOT NULL,
   phone NUMBER(10) NOT NULL,
   storeID NUMBER(10) NOT NULL
);
CREATE TABLE customer(
  customerID NUMBER(10) NOT NULL,
  CONSTRAINT customerID_pk PRIMARY KEY (customerID),
  firstName VARCHAR2(25 CHAR) NOT NULL,
  lastName VARCHAR2(25 CHAR) NOT NULL,
  points NUMBER(5) DEFAULT 0 NOT NULL,
  phone NUMBER(10) NOT NULL,
  storeID NUMBER(10) NOT NULL
);
CREATE TABLE product(
  productID NUMBER(10) NOT NULL,
  CONSTRAINT productID_pk PRIMARY KEY (productID),
  typeOfProd NUMBER(1) NOT NULL,
  price NUMBER(5) DEFAULT 0,
  amount NUMBER(2) NOT NULL,
  storeID NUMBER(10) NOT NULL
);
CREATE TABLE supplies(
   supplierID NUMBER(10) NOT NULL,
   productID NUMBER(10) NOT NULL
);
CREATE TABLE buys (
   productID NUMBER(10) NOT NULL,
   customerID NUMBER(10) NOT NULL
);

ALTER TABLE employee
   ADD CONSTRAINT department_fk
    FOREIGN KEY (departmentID)
    REFERENCES department (departmentID)
;
--ALTER TABLE department
  -- ADD CONSTRAINT managerID_fk
    --FOREIGN KEY (managerID)
   -- REFERENCES employee (employeeID)
--;
ALTER TABLE department
   ADD CONSTRAINT storeID_fk
    FOREIGN KEY (storeID)
    REFERENCES supermarket (storeID)
;
ALTER TABLE cash_register
   ADD CONSTRAINT storeID_fk_creg
    FOREIGN KEY (storeID)
    REFERENCES supermarket (storeID)
;
ALTER TABLE cash_register
   ADD CONSTRAINT operator_fk
    FOREIGN KEY (operatorOfReg)
    REFERENCES employee (employeeID)
;
ALTER TABLE supplier
   ADD CONSTRAINT storeID_fk_sup
    FOREIGN KEY (storeID)
    REFERENCES supermarket (storeID)
;
ALTER TABLE customer
   ADD CONSTRAINT storeID_fk_cus
    FOREIGN KEY (storeID)
    REFERENCES supermarket (storeID)
;
ALTER TABLE product
   ADD CONSTRAINT storeID_fk_prod
    FOREIGN KEY (storeID)
    REFERENCES supermarket (storeID)
;
ALTER TABLE supplies
   ADD CONSTRAINT supplierID_fk
    FOREIGN KEY (supplierID)
    REFERENCES supplier (supplierID)
;
ALTER TABLE supplies
   ADD CONSTRAINT productID_fk
    FOREIGN KEY (productID)
    REFERENCES product (productID)
;
ALTER TABLE buys
   ADD CONSTRAINT productID_fk_buy
    FOREIGN KEY (productID)
    REFERENCES product (productID)
;
ALTER TABLE buys
   ADD CONSTRAINT customerID_fk_buy
    FOREIGN KEY (customerID)
    REFERENCES customer (customerID)
;

INSERT INTO supermarket
VALUES (1234567890,'Albert',1234567890,'Kolejni 2, Brno, 61200');
INSERT INTO supplier
VALUES (0987654321,'Marios','Pafitis','Kolejni 3, Brno, 61200',1010101010,1234567890);
INSERT INTO supplier
VALUES (0887654321,'Marios2','2Pafitis','Kolejni 4, Brno, 61200',1010101011,1234567890);
INSERT INTO product
VALUES (2020202020,'4','15','30',1234567890);
INSERT INTO product
VALUES (2020202021,'4','16','20',1234567890);
INSERT INTO product
VALUES (2020202022,'3','25','30',1234567890);
INSERT INTO supplies
VALUES (0987654321,2020202021);
INSERT INTO supplies
VALUES (0987654321,2020202022);
INSERT INTO supplies
VALUES (0887654321,2020202022);
INSERT INTO customer
VALUES (1111111111,'Eirini','Christou',0,0000000000,1234567890);
INSERT INTO customer
VALUES (1111111112,'Michalis','Pafitis',100,0000000000,1234567890);
INSERT INTO customer
VALUES (1111111113,'Giorgos','Achilleos',50,0000000000,1234567890);
INSERT INTO buys
VALUES (2020202020,1111111111);
INSERT INTO department
VALUES ('Security',1234567890);
INSERT INTO employee
VALUES (2222222222,'Leonidas','Achilleos',1500,99999999,'Security');
INSERT INTO employee
VALUES (2222222221,'Maria','Maroushka',2000,99999998,'Security');
INSERT INTO employee
VALUES (2222222220,'Bob','Milan',3000,99999997,'Security');
INSERT INTO cash_register
VALUES (3030303030,100,1234567890,2222222222);
INSERT INTO cash_register
VALUES (3030303031,1000,1234567890,2222222222);
INSERT INTO cash_register
VALUES (3030303032,10000,1234567890,2222222222);
INSERT INTO cash_register
VALUES (3030303033,2000,1234567890,2222222222);
INSERT INTO cash_register
VALUES (3030303034,0,1234567890,2222222222);


--------- QUERIES ---------

-- 1st join between 2 tables
-- Select all the cash registers of the store Albert and order them in descending order
SELECT *
FROM supermarket
INNER JOIN cash_register
ON supermarket.storeid=cash_register.storeid
WHERE supermarket.storeName='Albert'
ORDER BY cash_register.cashRegID DESC;

-- 2nd join between 2 tables with create view
CREATE VIEW Table2 AS
SELECT departmentID
FROM employee
NATURAL JOIN department;

-- showing the content of  Table2 view
SELECT * FROM Table2;

-- Join between 3 tables
-- Select all the employees of Albert with salary between 1000 and 2000.
SELECT supermarket.storeName, employee.*
FROM supermarket
INNER JOIN department
ON supermarket.storeid=department.storeid
INNER JOIN employee
ON department.departmentID=employee.departmentID
WHERE supermarket.storeName='Albert' AND employee.salary BETWEEN 1000 AND 2000;

-- 3rd join between 2 tables and with EXISTS
-- Select the customer with the most points
SELECT firstName, lastName, customerID, points
FROM supermarket S
INNER JOIN customer C1
ON S.storeID=C1.storeID
WHERE NOT EXISTS (
    SELECT * 
    FROM customer C2 
    WHERE C1.points < C2.points);

-- Query with GROUP BY
-- Count how many products we have per type
SELECT typeofprod, COUNT(*) AS "Products per TypeOfProducts" 
FROM product
GROUP BY typeofprod;


-- Query with EXISTS
-- Which suppliers supply the product with productid: 2020202021 ?
SELECT supplierID,firstName,lastName
FROM supplier
WHERE NOT EXISTS(
    SELECT productid FROM product
    NATURAL JOIN supplies
    WHERE supplies.supplierid=supplier.supplierid
    AND productid=2020202021
);


--CREATE VIEW Marios_Pafitis_prods AS
--SELECT supplierID,productID
--FROM supplies
--WHERE Country = "Brazil"; 


---------- PART 4 *NOT READY YET*------------

--TRIGGER--
--CREATE TRIGGER product_price
--BEFORE INSERT or UPDATE
--OF price
--ON product
--FOR EACH ROW
--BEGIN
--    if: new.price<0 then
--    raise_application_error(-20011,'Price must be above 0.');
--    end if;
--END;
--/

--INSERT INTO product
--VALUES (2020202025,'3','-4','30',1234567890);