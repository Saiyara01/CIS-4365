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

-- Create Event table with Event_ID as PK
CREATE TABLE EVENT (
    EVENT_ID INT PRIMARY KEY,
    EVENT_NAME VARCHAR(150),
    EVENT_DATE DATE,
    EVENT_TIME TIME,
    EVENT_LOCATION VARCHAR(255),
    EVENT_TYPE VARCHAR(100),
    EVENT_DESC VARCHAR(200)
);

-- Event data values 
INSERT INTO EVENT VALUES
(1, 'Wedding Catering', '2024-11-10', '17:00:00', 'Houston Hall', 'Wedding', 'Large wedding event'),
(2, 'Birthday Party', '2024-11-12', '15:00:00', 'Private Home', 'Birthday', 'Kids birthday party'),
(3, 'Corporate Meeting', '2024-11-15', '10:00:00', 'Downtown Office', 'Corporate', 'Business catering'),
(4, 'Anniversary Dinner', '2024-11-18', '19:00:00', 'Restaurant Hall', 'Anniversary', 'Family celebration'),
(5, 'Baby Shower', '2024-11-20', '14:00:00', 'Community Center', 'Shower', 'Baby shower event'),
(6, 'Graduation Party', '2024-11-22', '18:00:00', 'Event Center', 'Graduation', 'College graduation'),
(7, 'Holiday Party', '2024-12-01', '20:00:00', 'Hotel Ballroom', 'Holiday', 'Company holiday party'),
(8, 'Engagement Party', '2024-12-03', '17:30:00', 'Garden Venue', 'Engagement', 'Engagement celebration'),
(9, 'Office Lunch', '2024-12-05', '12:00:00', 'Office Space', 'Corporate', 'Team lunch event'),
(10, 'Fundraiser', '2024-12-08', '19:30:00', 'Charity Hall', 'Charity', 'Fundraising dinner');

-- Table AllergyInfo; Allergy_ID as PK

CREATE TABLE ALLERGYINFO (
    ALLERGY_ID INT PRIMARY KEY,
    ALLERGY_NAME VARCHAR(100),
    ALLERGY_DESC VARCHAR(200),
    ALLERGY_TYPE VARCHAR(100),
    ALLERGY_CONTENT VARCHAR(100),
    ALLERGY_REACTION VARCHAR(255)
);

-- Sample data for AllergyInfo table
INSERT INTO ALLERGYINFO VALUES
(1, 'Peanut Allergy', 'Allergy to peanuts', 'Food', 'Peanuts', 'Swelling, hives'),
(2, 'Dairy Allergy', 'Allergy to milk products', 'Food', 'Milk', 'Stomach pain, rash'),
(3, 'Gluten Allergy', 'Allergy to gluten', 'Food', 'Wheat', 'Digestive issues'),
(4, 'Egg Allergy', 'Allergy to eggs', 'Food', 'Egg protein', 'Skin rash'),
(5, 'Soy Allergy', 'Allergy to soy products', 'Food', 'Soy', 'Nausea'),
(6, 'Tree Nut Allergy', 'Allergy to tree nuts', 'Food', 'Almonds, walnuts', 'Swelling'),
(7, 'Shellfish Allergy', 'Allergy to seafood', 'Food', 'Shrimp, crab', 'Breathing issues'),
(8, 'Sesame Sensitivity', 'Reaction to sesame seeds', 'Food', 'Sesame', 'Swelling'),
(9, 'Wheat Allergy', 'Allergy to Wheat products', 'Food', 'Wheat', 'Digestive Issues'),
(10, 'Artificial Color Allergy', 'Reaction to food dyes', 'Additive', 'Food coloring', 'Hyperactivity');

