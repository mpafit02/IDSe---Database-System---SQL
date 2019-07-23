ALTER TABLE employee DROP CONSTRAINT department_fk;
ALTER TABLE department DROP CONSTRAINT managerID_fk;
ALTER TABLE department DROP CONSTRAINT storeOwner_fk;
ALTER TABLE cash_register DROP CONSTRAINT storeOwner_fk_creg;
ALTER TABLE cash_register DROP CONSTRAINT operator_fk;

DROP TABLE employee;
DROP TABLE department;
DROP TABLE supermarket;
DROP TABLE cash_register;
DROP TABLE supplier;

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
   phone NUMBER(10) NOT NULL
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
