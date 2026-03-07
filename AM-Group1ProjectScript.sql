-- Insert all the SQL Scripts here part of requirement
-- Make sure to COMMIT ALL update

-- Author: Saiyara
-- Create Customer table, CUSTOMER_ID AS PK
CREATE TABLE CUSTOMER (
    CUSTOMER_ID INT PRIMARY KEY,
    CUSTOMER_LNAME VARCHAR(100),
    CUSTOMER_FNAME VARCHAR(100),
    CUSTOMER_PHONE VARCHAR(20),
    CUSTOMER_EMAIL VARCHAR(100)
);
-- Customer table data input (10 total data)
INSERT INTO CUSTOMER (CUSTOMER_ID, CUSTOMER_LNAME, CUSTOMER_FNAME, CUSTOMER_PHONE, CUSTOMER_EMAIL) VALUES
(1, 'Daisy', 'Donald', '443-555-1001', 'donald.daisy@email.com'),
(2, 'Tinker', 'Bell', '443-555-1002', 'bell.tinker@email.com'),
(3, 'Williams', 'Wendy', '443-555-1003', 'wendy.williams@email.com'),
(4, 'Brown', 'Snow', '443-555-1004', 'snow.brown@email.com'),
(5, 'Jones', 'Gus', '443-555-1005', 'gus.jones@email.com'),
(6, 'Garcia', 'Merida', '443-555-1006', 'merida.garcia@email.com'),
(7, 'Miller', 'Pascal', '443-555-1007', 'pascal.miller@email.com'),
(8, 'Davis', 'Shere', '443-555-1008', 'shere.davis@email.com'),
(9, 'Rodriguez', 'Gaston', '443-555-1009', 'gaston.rodriguez@email.com'),
(10, 'Martinez', 'Abu', '443-555-1010', 'abu.martinez@email.com');

-- Create SALESCHANNEL TABLE, CHANNEL_ID AS PK
CREATE TABLE SALESCHANNEL (
    CHANNEL_ID INT PRIMARY KEY,
    CHANNEL_NAME VARCHAR(100),
    CHANNEL_ROUTE VARCHAR(100)
);

-- Create table ORDERS, ORDER_ID AS PK, REFERENCES CUST_ID & CHANNEL_ID AS FK
CREATE TABLE ORDERS (
    ORDER_ID INT PRIMARY KEY,
    ORDER_DATE DATE,
    ORDER_TIME TIME,
    ORDER_TOTAL DECIMAL(10,2),
    CUSTOMER_ID INT,
    CHANNEL_ID INT,
    
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
    FOREIGN KEY (CHANNEL_ID) REFERENCES SALESCHANNEL(CHANNEL_ID)
);

-- Create table LoyaltyProgram, LOYALTY_ID AS PK & CUSTOMER_ID AS FK
CREATE TABLE LOYALTYPROGRAM (
    LOYALTY_ID INT PRIMARY KEY,
    LOYALTY_POINTS INT,
    LOYALTY_TIER VARCHAR(20),
    CUSTOMER_ID INT,
    
    FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID)
);

-- LoyaltyProgram data (0-199 Bronze, 200 - 299 Silver, 300 - 399 Gold, 400 - 499 Platinum)
INSERT INTO LOYALTYPROGRAM (LOYALTY_ID, LOYALTY_POINTS, LOYALTY_TIER, CUSTOMER_ID) VALUES
(001, 120, 'Bronze', 1),
(002, 230, 'Silver', 2),
(003, 360, 'Gold', 3),
(004, 160, 'Bronze', 4),
(005, 212, 'Silver', 5),
(006, 389, 'Gold', 6),
(007, 199, 'Bronze', 7),
(008, 218, 'Silver', 8),
(009, 450, 'Platinum', 9),
(0010, 200, 'Silver', 10);

-- Create table ProductCategory, PCATEGORY AS PK
CREATE TABLE PRODUCTCATEGORY (
    PCATEGORY_ID INT PRIMARY KEY,
    PCATEGORY_NAME VARCHAR(100),
    PCATEGORY_ALLERGEN VARCHAR(100),
    PCATEGORY_END_DATE DATE
);
