ALTER TABLE employee DROP CONSTRAINT department_fk;
ALTER TABLE department DROP CONSTRAINT managerID_fk;
ALTER TABLE department DROP CONSTRAINT storeOwner_fk;
ALTER TABLE cash_register DROP CONSTRAINT storeOwner_fk_creg;
ALTER TABLE cash_register DROP CONSTRAINT operator_fk;
ALTER TABLE supplier DROP CONSTRAINT storeOwner_fk_sup;
ALTER TABLE customer DROP CONSTRAINT storeOwner_fk_cus;
ALTER TABLE product DROP CONSTRAINT storeOwner_fk_prod;
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

CREATE TABLE employee(
  employeeID NUMBER(10) NOT NULL,
   CONSTRAINT employeeID_pk PRIMARY KEY (employeeID),
  firstName VARCHAR2(25CHAR) NOT NULL,
  lastName VARCHAR2(25CHAR) NOT NULL,
  salary NUMBER(5) NOT NULL,
  phone NUMBER(10) NOT NULL UNIQUE,
  department NUMBER(1) NOT NULL
);
CREATE TABLE department(
  departmentID NUMBER(1) NOT NULL,
   CONSTRAINT departmentID_pk PRIMARY KEY (departmentID),
  managerID NUMBER(10) NOT NULL,
  storeOwner NUMBER(10) NOT NULL
);
CREATE TABLE supermarket(
  storeID NUMBER(10) NOT NULL,
  CONSTRAINT storeID_pk PRIMARY KEY (storeID),
  firstName VARCHAR2(25 CHAR) NOT NULL,
  phone NUMBER(10) NOT NULL,
  address VARCHAR2(60CHAR) NOT NULL
);
CREATE TABLE cash_register(
  cashRegID NUMBER(10) NOT NULL,
  CONSTRAINT cashRegID_pk PRIMARY KEY (cashRegID),
  money NUMBER(5) DEFAULT 0 NOT NULL,
  storeOwner NUMBER(10) NOT NULL,
  operator NUMBER(10) NOT NULL  
);
CREATE TABLE supplier(
   supplierID NUMBER(10) NOT NULL,
   CONSTRAINT supplierID_pk PRIMARY KEY (supplierID),
   firstName VARCHAR2(25CHAR) NOT NULL,
   lastName VARCHAR2(25CHAR) NOT NULL,
   phone NUMBER(10) NOT NULL,
   storeOwner NUMBER(10) NOT NULL
);
CREATE TABLE customer(
  customerID NUMBER(10) NOT NULL,
  CONSTRAINT customerID_pk PRIMARY KEY (customerID),
  firstName VARCHAR2(25CHAR) NOT NULL,
  lastName VARCHAR2(25CHAR) NOT NULL,
  points NUMBER(5) DEFAULT 0 NOT NULL,
  phone NUMBER(10) NOT NULL,
  storeOwner NUMBER(10) NOT NULL
);
CREATE TABLE product(
  productID NUMBER(10) NOT NULL,
  CONSTRAINT productID_pk PRIMARY KEY (productID),
  typeOfProd NUMBER(1) NOT NULL,
  price NUMBER(5) DEFAULT 0,
  amount NUMBER(2) NOT NULL,
  storeOwner NUMBER(10) NOT NULL
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
    FOREIGN KEY (department)
    REFERENCES department (departmentID)
;
ALTER TABLE department
   ADD CONSTRAINT managerID_fk
    FOREIGN KEY (managerID)
    REFERENCES employee (employeeID)
;
ALTER TABLE department
   ADD CONSTRAINT storeOwner_fk
    FOREIGN KEY (storeOwner)
    REFERENCES supermarket (storeID)
;
ALTER TABLE cash_register
   ADD CONSTRAINT storeOwner_fk_creg
    FOREIGN KEY (storeOwner)
    REFERENCES supermarket (storeID)
;
ALTER TABLE cash_register
   ADD CONSTRAINT operator_fk
    FOREIGN KEY (operator)
    REFERENCES supermarket (storeID)
;
ALTER TABLE supplier
   ADD CONSTRAINT storeOwner_fk_sup
    FOREIGN KEY (storeOwner)
    REFERENCES supermarket (storeID)
;
ALTER TABLE customer
   ADD CONSTRAINT storeOwner_fk_cus
    FOREIGN KEY (storeOwner)
    REFERENCES supermarket (storeID)
;
ALTER TABLE product
   ADD CONSTRAINT storeOwner_fk_prod
    FOREIGN KEY (storeOwner)
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
VALUES (0987654321,'Marios','Pafitis',1010101010,1234567890);
INSERT INTO product
VALUES (2020202020,'4','15','30',1234567890);
INSERT INTO supplies
VALUES (0987654321,2020202020);
INSERT INTO customer
VALUES (1111111111,'Eirini','Hristou',0,0000000000,1234567890);
INSERT INTO buys
VALUES (2020202020,1111111111);
--INSERT INTO cash_register
--VALUES (0000100001,200,12345679890,0000000000);
