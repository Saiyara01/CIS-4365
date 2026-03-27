-- Insert all the SQL Scripts here part of requirement
-- Make sure to COMMIT ALL update


-- Author: Saiyara, Izzy


-- AllergyInfo table
CREATE TABLE AllergyInfo (
    ALLERGY_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    ALLERGY_NAME        VARCHAR(100)    NOT NULL,
    ALLERGY_DESC        VARCHAR(200),
    ALLERGY_TYPE        VARCHAR(100),
    ALLERGY_CONTENT     VARCHAR(100),
    ALLERGY_REACTION    VARCHAR(255)
);


-- Department table
CREATE TABLE Department (
    DEPT_CODE       INT             AUTO_INCREMENT PRIMARY KEY,
    DEPT_NAME       VARCHAR(100)    NOT NULL,
    DEPT_DESC       VARCHAR(100)
);


-- Event table
CREATE TABLE Event (
    EVENT_ID        INT             AUTO_INCREMENT PRIMARY KEY,
    EVENT_NAME      VARCHAR(150)    NOT NULL,
    EVENT_DATE      DATE            NOT NULL,
    EVENT_TIME      TIME,
    EVENT_LOCATION  VARCHAR(255),
    EVENT_TYPE      VARCHAR(100)    NOT NULL,
    EVENT_DESC      VARCHAR(200)
);

-- Holiday table
CREATE TABLE Holiday (
    HOLIDAY_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    HOLIDAY_NAME        VARCHAR(100)    NOT NULL,
    HOLIDAY_SEASON      VARCHAR(20),
    HOLIDAY_START_DATE  DATE            NOT NULL,
    HOLIDAY_END_DATE    DATE            NOT NULL
);


-- Ingredient table
CREATE TABLE Ingredient (
    INGREDIENT_ID   INT             AUTO_INCREMENT PRIMARY KEY,
    INGREDIENT_NAME VARCHAR(100)    NOT NULL,
    INGREDIENT_UNIT VARCHAR(50)     NOT NULL
);

-- LoyaltyProgram table
CREATE TABLE LoyaltyProgram (
    LOYALTY_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    LOYALTY_POINTS  INT             NOT NULL    DEFAULT 0,
    LOYALTY_TIER    VARCHAR(20)     NOT NULL
    LOYALTY_POINTS_MIN INT
    LOYALTY_POINTS_MAX INT
);


-- ProductCategory table
CREATE TABLE ProductCategory (
    PCATEGORY_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    PCATEGORY_NAME  VARCHAR(100)    NOT NULL
);


-- Promotion table
CREATE TABLE Promotion (
    PROMOTION_ID            INT             AUTO_INCREMENT PRIMARY KEY,
    PROMOTION_NAME          VARCHAR(150)    NOT NULL,
    PROMOTION_DISCOUNT      DECIMAL(5,2)    NOT NULL,
    PROMOTION_START_DATE    DATE            NOT NULL,
    PROMOTION_END_DATE      DATE            NOT NULL
);

-- SalesChannel table
CREATE TABLE SalesChannel (
    CHANNEL_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    CHANNEL_NAME    VARCHAR(100)    NOT NULL,
    CHANNEL_ROUTE   VARCHAR(100)
);


-- Supplier table
CREATE TABLE Supplier (
    SUPPLIER_ID     INT             AUTO_INCREMENT PRIMARY KEY,
    SUPPLIER_NAME   VARCHAR(150)    NOT NULL,
    SUPPLIER_PHONE  VARCHAR(20),
    SUPPLIER_EMAIL  VARCHAR(100)
);

-- Customer table (no FK dependencies in Tier 2)
CREATE TABLE Customer (
    CUSTOMER_ID     INT             AUTO_INCREMENT PRIMARY KEY,
    CUSTOMER_LNAME  VARCHAR(100)    NOT NULL,
    CUSTOMER_FNAME  VARCHAR(100)    NOT NULL,
    CUSTOMER_PHONE  VARCHAR(20),
    CUSTOMER_EMAIL  VARCHAR(100)
);


-- Employee table (depends on Role only)
CREATE TABLE Employee (
    EMP_CODE        INT             AUTO_INCREMENT PRIMARY KEY,
    EMP_LNAME       VARCHAR(100)    NOT NULL,
    EMP_FNAME       VARCHAR(100)    NOT NULL,
    EMP_PHONE       VARCHAR(20),
    ROLE_ID         INT             NOT NULL,
    FOREIGN KEY (ROLE_ID) REFERENCES Role(ROLE_ID)
);


-- Inventory table (depends on Ingredient)
CREATE TABLE Inventory (
    INVENTORY_ID            INT             AUTO_INCREMENT PRIMARY KEY,
    CURRENT_STOCK           DECIMAL(10,2)   NOT NULL    DEFAULT 0.00,
    REORDER_LEVEL           DECIMAL(10,2)   NOT NULL,
    INVENTORY_LAST_UPDATE   DATE            NOT NULL,
    INGREDIENT_ID           INT             NOT NULL    UNIQUE,
    FOREIGN KEY (INGREDIENT_ID) REFERENCES Ingredient(INGREDIENT_ID)
);


-- NutritionalInfo table (depends on Product)
CREATE TABLE NutritionalInfo (
    NUTRITION_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    CALORIES_TOTAL  INT             NOT NULL,
    FAT_TOTAL       DECIMAL(5,2)    NOT NULL,
    CARBS_TOTAL     DECIMAL(5,2)    NOT NULL,
    PROTEIN_TOTAL   DECIMAL(5,2)    NOT NULL,
    SERVING_SIZE    VARCHAR(50)     NOT NULL,
    PRODUCT_ID      INT             NOT NULL    UNIQUE,
    FOREIGN KEY (PRODUCT_ID) REFERENCES Product(PRODUCT_ID)
);


-- Order (depends on Customer, SalesChannel, SalesReport)
-- backticks used to escape the table name
CREATE TABLE `Order` (
    ORDER_ID        INT             AUTO_INCREMENT PRIMARY KEY,
    ORDER_DATE      DATE            NOT NULL,
    ORDER_TIME      TIME            NOT NULL,
    ORDER_TOTAL     DECIMAL(10,2)   NOT NULL    DEFAULT 0.00,
    CUSTOMER_ID     INT             NOT NULL,
    CHANNEL_ID      INT             NOT NULL,
    REPORT_ID       INT,
    FOREIGN KEY (CUSTOMER_ID)   REFERENCES Customer(CUSTOMER_ID),
    FOREIGN KEY (CHANNEL_ID)    REFERENCES SalesChannel(CHANNEL_ID),
    FOREIGN KEY (REPORT_ID)     REFERENCES SalesReport(REPORT_ID)
);


-- Product table (depends on ProductCategory)
CREATE TABLE Product (
    PRODUCT_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_NAME        VARCHAR(100)    NOT NULL,
    PRODUCT_PRICE       DECIMAL(10,2)   NOT NULL,
    PRODUCT_TYPE        VARCHAR(100),
    PRODUCT_DESCRIPTION VARCHAR(100),
    PCATEGORY_ID        INT             NOT NULL,
    FOREIGN KEY (PCATEGORY_ID) REFERENCES ProductCategory(PCATEGORY_ID)
);


-- ProductPromotion table (depends on Product, Promotion)
-- Associative Entity [Product:Promotion]
CREATE TABLE ProductPromotion (
    PRODUCT_PROMO_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_PROMO_DATE  DATE            NOT NULL,
    PRODUCT_PROMO_DEPT  VARCHAR(100),
    PRODUCT_PROMO_CAT   VARCHAR(100),
    PRODUCT_ID          INT             NOT NULL,
    PROMOTION_ID        INT             NOT NULL,
    FOREIGN KEY (PRODUCT_ID)   REFERENCES Product(PRODUCT_ID),
    FOREIGN KEY (PROMOTION_ID) REFERENCES Promotion(PROMOTION_ID)
);


-- Role table (depends on Department)
CREATE TABLE Role (
    ROLE_ID         INT             AUTO_INCREMENT PRIMARY KEY,
    ROLE_NAME       VARCHAR(100)    NOT NULL,
    ROLE_DESC       VARCHAR(255),
    ROLE_WORKHOURS  INT,
    ROLE_TYPE       VARCHAR(50),
    DEPT_CODE       INT             NOT NULL,
    FOREIGN KEY (DEPT_CODE) REFERENCES Department(DEPT_CODE)
);


-- CateringInvoice (depends on CateringOrder)
CREATE TABLE CateringInvoice (
    CAT_INVOICE_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    CAT_INVOICE_DATE    DATE            NOT NULL,
    CAT_INVOICE_TOTAL   DECIMAL(12,2)   NOT NULL,
    CAT_INVOICE_STATUS  VARCHAR(50)     NOT NULL    DEFAULT 'Unpaid',
    CATERING_ORDER_ID   INT             NOT NULL    UNIQUE,
    FOREIGN KEY (CATERING_ORDER_ID) REFERENCES CateringOrder(CATERING_ORDER_ID)
);


-- CateringOrder (depends on Customer, Event)
CREATE TABLE CateringOrder (
    CATERING_ORDER_ID       INT             AUTO_INCREMENT PRIMARY KEY,
    CATERING_ORDER_DATE     DATE            NOT NULL,
    CATERING_ORDER_TOTAL    DECIMAL(12,2)   NOT NULL    DEFAULT 0.00,
    CUSTOMER_ID             INT             NOT NULL,
    EVENT_ID                INT             NOT NULL,
    FOREIGN KEY (CUSTOMER_ID)   REFERENCES Customer(CUSTOMER_ID),
    FOREIGN KEY (EVENT_ID)      REFERENCES Event(EVENT_ID)
);


-- Delivery (depends on Order)
CREATE TABLE Delivery (
    DELIVERY_ID         INT             AUTO_INCREMENT PRIMARY KEY,
    DELIVERY_TYPE       VARCHAR(100),
    DELIVERY_ADDRESS    VARCHAR(225)    NOT NULL,
    DELIVERY_STATUS     VARCHAR(50)     NOT NULL    DEFAULT 'Pending',
    ORDER_ID            INT             NOT NULL    UNIQUE,
    FOREIGN KEY (ORDER_ID) REFERENCES `Order`(ORDER_ID)
);


-- Expense (depends on SupplierInvoice)
CREATE TABLE Expense (
    EXPENSE_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    EXPENSE_AMOUNT  DECIMAL(12,2)   NOT NULL,
    EXPENSE_DATE    DATE            NOT NULL,
    SUP_INVOICE_ID  INT             NOT NULL    UNIQUE,
    FOREIGN KEY (SUP_INVOICE_ID) REFERENCES SupplierInvoice(SUP_INVOICE_ID)
);



-- HolidayProductSales (depends on Holiday, Product)
-- Associative Entity [Holiday:Product]
CREATE TABLE HolidayProductSales (
    HOLIDAY_SALES_ID            INT             AUTO_INCREMENT PRIMARY KEY,
    HOLIDAY_SALES_START_DATE    DATE            NOT NULL,
    HOLIDAY_SALES_END_DATE      DATE            NOT NULL,
    HOLIDAY_SALES_VOLUME        INT             NOT NULL    DEFAULT 0,
    HOLIDAY_SALES_REVENUE       DECIMAL(12,2)   NOT NULL    DEFAULT 0.00,
    HOLIDAY_ID                  INT             NOT NULL,
    PRODUCT_ID                  INT             NOT NULL,
    FOREIGN KEY (HOLIDAY_ID)    REFERENCES Holiday(HOLIDAY_ID),
    FOREIGN KEY (PRODUCT_ID)    REFERENCES Product(PRODUCT_ID)
);



-- ProductAllergy (depends on Product, AllergyInfo)
-- Associative Entity [Product:AllergyInfo]
CREATE TABLE ProductAllergy (
    PRODUCT_ALLERGY_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    PRODUCT_ALLERGY_CONTENT     VARCHAR(100),
    PRODUCT_ALLERGY_DISCLAIMER  VARCHAR(255),
    ALLERGY_ID                  INT             NOT NULL,
    PRODUCT_ID                  INT             NOT NULL,
    FOREIGN KEY (ALLERGY_ID)    REFERENCES AllergyInfo(ALLERGY_ID),
    FOREIGN KEY (PRODUCT_ID)    REFERENCES Product(PRODUCT_ID)
);


-- Review (depends on Customer, Product)
CREATE TABLE Review (
    REVIEW_ID       INT             AUTO_INCREMENT PRIMARY KEY,
    REVIEW_RATING   INT             NOT NULL,
    REVIEW_COMMENT  VARCHAR(500),
    REVIEW_DATE     DATE            NOT NULL,
    CUSTOMER_ID     INT             NOT NULL,
    PRODUCT_ID      INT             NOT NULL,
    CONSTRAINT CHK_Rating CHECK (REVIEW_RATING BETWEEN 1 AND 5),
    FOREIGN KEY (CUSTOMER_ID)   REFERENCES Customer(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID)    REFERENCES Product(PRODUCT_ID)
);


-- SalesReport (no FK dependencies, but Order depends on it)
CREATE TABLE SalesReport (
    REPORT_ID               INT             AUTO_INCREMENT PRIMARY KEY,
    REPORT_START_DATE       DATE            NOT NULL,
    REPORT_END_DATE         DATE            NOT NULL,
    REPORT_TOTAL_REVENUE    DECIMAL(15,2)   NOT NULL    DEFAULT 0.00,
    REPORT_TOTAL_SALES      DECIMAL(15,2)   NOT NULL    DEFAULT 0.00,
    SALES_DESC              VARCHAR(200)
);



-- Shift (depends on Employee)
CREATE TABLE Shift (
    SHIFT_ID            INT             AUTO_INCREMENT PRIMARY KEY,
    SHIFT_DATE          DATE            NOT NULL,
    SHIFT_START_TIME    TIME            NOT NULL,
    SHIFT_END_TIME      TIME            NOT NULL,
    EMP_CODE            INT             NOT NULL,
    FOREIGN KEY (EMP_CODE) REFERENCES Employee(EMP_CODE)
);



-- SupplierIngredient table (depends on Supplier, Ingredient)
-- Associative Entity [Supplier:Ingredient]
CREATE TABLE SupplierIngredient (
    SUPPLIER_INGR_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    SUPPLY_UNIT         VARCHAR(50)     NOT NULL,
    SUPPLY_PRICE        DECIMAL(10,2)   NOT NULL,
    SUPPLIER_ID         INT             NOT NULL,
    INGREDIENT_ID       INT             NOT NULL,
    FOREIGN KEY (SUPPLIER_ID)   REFERENCES Supplier(SUPPLIER_ID),
    FOREIGN KEY (INGREDIENT_ID) REFERENCES Ingredient(INGREDIENT_ID)
);



-- SupplierInvoice (depends on Supplier)
CREATE TABLE SupplierInvoice (
    SUP_INVOICE_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    SUP_INVOICE_DATE    DATE            NOT NULL,
    SUP_INVOICE_TOTAL   DECIMAL(12,2)   NOT NULL,
    SUP_INVOICE_STATUS  VARCHAR(50)     NOT NULL    DEFAULT 'Unpaid',
    SUPPLIER_ID         INT             NOT NULL,
    FOREIGN KEY (SUPPLIER_ID) REFERENCES Supplier(SUPPLIER_ID)
);


-- WasteLog (depends on Ingredient, Supplier)
CREATE TABLE WasteLog (
    WASTELOG_ID     INT             AUTO_INCREMENT PRIMARY KEY,
    WASTE_DATE      DATE            NOT NULL,
    WASTE_QUANTITY  DECIMAL(10,2)   NOT NULL,
    WASTE_REASON    VARCHAR(100),
    INGREDIENT_ID   INT             NOT NULL,
    SUPPLIER_ID     INT,
    FOREIGN KEY (INGREDIENT_ID) REFERENCES Ingredient(INGREDIENT_ID),
    FOREIGN KEY (SUPPLIER_ID)   REFERENCES Supplier(SUPPLIER_ID)
);



-- OrderAssignment (depends on Order, Employee)
-- Associative Entity [Employee:Order]
CREATE TABLE OrderAssignment (
    ORDER_ASSIGNMENT_ID     INT             AUTO_INCREMENT PRIMARY KEY,
    ORDER_ASSIGNMENT_TIME   TIME            NOT NULL,
    ORDER_ASSIGNMENT_DATE   DATE            NOT NULL,
    ORDER_ID                INT             NOT NULL,
    EMP_CODE                INT             NOT NULL,
    FOREIGN KEY (ORDER_ID)  REFERENCES `Order`(ORDER_ID),
    FOREIGN KEY (EMP_CODE)  REFERENCES Employee(EMP_CODE)
);



-- OrderLine (depends on Order, Product)
-- Associative Entity [Order:Product]
CREATE TABLE OrderLine (
    ORDERLINE_ID        INT             AUTO_INCREMENT PRIMARY KEY,
    ORDERLINE_QUANTITY  INT             NOT NULL,
    ORDERLINE_PRICE     DECIMAL(10,2)   NOT NULL,
    ORDER_ID            INT             NOT NULL,
    PRODUCT_ID          INT             NOT NULL,
    FOREIGN KEY (ORDER_ID)      REFERENCES `Order`(ORDER_ID),
    FOREIGN KEY (PRODUCT_ID)    REFERENCES Product(PRODUCT_ID)
);


--- Table Data same order as the tables based on dependency on other tables

-- AllergyInfo
INSERT INTO AllergyInfo (ALLERGY_NAME, ALLERGY_DESC, ALLERGY_TYPE, ALLERGY_CONTENT, ALLERGY_REACTION) VALUES
('Gluten',      'Present in wheat-based products',           'Food Intolerance',  'Wheat flour',      'Bloating, digestive discomfort'),
('Dairy',       'Present in milk-based ingredients',         'Food Allergy',      'Milk, butter',     'Hives, swelling, anaphylaxis'),
('Eggs',        'Present in baked goods and pastries',       'Food Allergy',      'Whole eggs',       'Skin rash, respiratory issues'),
('Nuts',        'Present in select cakes and pastries',      'Food Allergy',      'Almonds, walnuts', 'Anaphylaxis, throat swelling'),
('Soy',         'Present in some bread and pastry mixes',    'Food Intolerance',  'Soy lecithin',     'Digestive discomfort'),
('Sesame',      'Present in select bread toppings',          'Food Allergy',      'Sesame seeds',     'Hives, anaphylaxis'),
('Shellfish',   'Present in select savory items',            'Food Allergy',      'Shrimp paste',     'Anaphylaxis, throat swelling'),
('Peanuts',     'Present in select cookies and cakes',       'Food Allergy',      'Peanut butter',    'Anaphylaxis, swelling'),
('Sulfites',    'Present in dried fruits used in baking',    'Food Intolerance',  'Dried fruits',     'Headache, breathing difficulty'),
('Lactose',     'Present in cream and milk-based fillings',  'Food Intolerance',  'Cream, milk',      'Bloating, nausea');


-- Department
INSERT INTO Department (DEPT_NAME, DEPT_DESC) VALUES
('Kitchen',         'Handles all baking and food preparation'),
('Front of House',  'Manages customer orders and service'),
('Logistics',       'Handles delivery and supply chain'),
('Management',      'Oversees daily operations and staff'),
('Marketing',       'Manages promotions and customer outreach'),
('Catering',        'Handles catering orders and events'),
('Pastry',          'Specializes in pastries and desserts'),
('Beverages',       'Manages all drink preparation and service'),
('Cleaning',        'Maintains hygiene and sanitation standards'),
('Procurement',     'Manages supplier relations and purchasing');


-- Event
INSERT INTO Event (EVENT_NAME, EVENT_DATE, EVENT_TIME, EVENT_LOCATION, EVENT_TYPE, EVENT_DESC) VALUES
('Johnsons Wedding Reception',      '2025-03-15',   '14:00:00',     '45 Rosewood Venue, Springfield',       'Wedding',      'Full catering for 120 guests'),
('Chen Birthday Celebration',       '2025-02-22',   '18:00:00',     '12 Maple Street, Riverside',           'Birthday',     'Birthday party catering for 40 guests'),
('TechCorp Annual Gala',            '2025-04-10',   '19:00:00',     '200 Business Park Ave, Downtown',      'Corporate',    'Corporate dinner for 200 guests'),
('Smith Baby Shower',               '2025-03-01',   '12:00:00',     '8 Lavender Lane, Greenfield',          'Baby Shower',  'Afternoon tea catering for 25 guests'),
('Riverside School Bake Sale',      '2025-05-03',   '09:00:00',     '1 School Road, Riverside',             'Community',    'Baked goods supply for school fundraiser'),
('Martinez Anniversary Dinner',     '2025-06-14',   '19:30:00',     '33 Oak Avenue, Hillside',              'Anniversary',  'Intimate dinner catering for 30 guests'),
('City Food Festival',              '2025-07-20',   '10:00:00',     'Central Park Grounds, Downtown',       'Festival',     'Festival stall catering over 3 days'),
('Green Valley Farmers Market',     '2025-04-26',   '08:00:00',     'Green Valley Market Square',           'Market',       'Weekly market stall with fresh baked goods'),
('Williams Graduation Party',       '2025-05-18',   '15:00:00',     '77 Elm Street, Northside',             'Graduation',   'Graduation celebration for 60 guests'),
('Downtown Business Breakfast',     '2025-03-28',   '07:30:00',     '5 Commerce Street, Downtown',          'Corporate',    'Morning catering for 50 business attendees');


-- Holiday
INSERT INTO Holiday (HOLIDAY_NAME, HOLIDAY_SEASON, HOLIDAY_START_DATE, HOLIDAY_END_DATE) VALUES
('Christmas',               'Winter',   '2024-12-20',   '2024-12-26'),
('New Year',                'Winter',   '2024-12-31',   '2025-01-01'),
('Valentines Day',          'Spring',   '2025-02-14',   '2025-02-14'),
('Easter',                  'Spring',   '2025-04-18',   '2025-04-21'),
('Mid-Autumn Festival',     'Autumn',   '2024-09-17',   '2024-09-17'),
('Mothers Day',             'Spring',   '2025-05-11',   '2025-05-11'),
('Thanksgiving',            'Autumn',   '2024-11-28',   '2024-11-28'),
('Chinese New Year',        'Winter',   '2025-01-29',   '2025-02-04'),
('Halloween',               'Autumn',   '2024-10-31',   '2024-10-31'),
('Independence Day',        'Summer',   '2025-07-04',   '2025-07-04');


-- Ingredient
INSERT INTO Ingredient (INGREDIENT_NAME, INGREDIENT_UNIT) VALUES
('All-Purpose Flour',   'kg'),
('Unsalted Butter',     'kg'),
('Whole Milk',          'L'),
('Granulated Sugar',    'kg'),
('Large Eggs',          'units'),
('Cocoa Powder',        'kg'),
('Whipping Cream',      'L'),
('Vanilla Extract',     'L'),
('Baking Powder',       'kg'),
('Sea Salt',            'kg');


-- LoyaltyProgram table
INSERT INTO LoyaltyProgram (LOYALTY_TIER, LOYALTY_POINTS_MIN, LOYALTY_POINTS_MAX) VALUES
('Bronze',      0,      499),
('Silver',      500,    999),
('Gold',        1000,   1999),
('Platinum',    2000,   NULL);


-- ProductCategory
INSERT INTO ProductCategory (PCATEGORY_NAME) VALUES
('Bread'),
('Cakes'),
('Pastries'),
('Beverages'),
('Cookies'),
('Savory'),
('Seasonal'),
('Catering Platters'),
('Tarts'),
('Muffins');


-- Promotion
INSERT INTO Promotion (PROMOTION_NAME, PROMOTION_DISCOUNT, PROMOTION_START_DATE, PROMOTION_END_DATE) VALUES
('Summer Sale',             15.00,  '2024-06-01',   '2024-06-30'),
('Christmas Special',       20.00,  '2024-12-15',   '2024-12-25'),
('Valentines Bundle',       10.00,  '2025-02-10',   '2025-02-14'),
('Easter Treats',           12.00,  '2025-04-14',   '2025-04-21'),
('Loyalty Member Deal',     8.00,   '2025-01-01',   '2025-03-31'),
('New Year Clearance',      25.00,  '2024-12-31',   '2025-01-02'),
('Mid-Autumn Festival',     10.00,  '2024-09-10',   '2024-09-17'),
('Birthday Month Offer',    5.00,   '2025-01-01',   '2025-12-31'),
('Weekend Special',         7.00,   '2025-01-04',   '2025-12-27'),
('Bulk Buy Discount',       18.00,  '2025-01-01',   '2025-12-31');


-- SalesChannel
INSERT INTO SalesChannel (CHANNEL_NAME, CHANNEL_ROUTE) VALUES
('In-Store',    'Walk-in counter purchase'),
('Pickup',      'Order ahead and collect in store'),
('Delivery',    'Order dispatched to customer address'),
('Online',      'Order placed via website or app'),
('Phone',       'Order placed via telephone'),
('Catering',    'Order placed as part of catering service'),
('Market',      'Order placed at farmers market stall'),
('Corporate',   'Bulk order placed by corporate client'),
('Wholesale',   'Bulk order placed by retail partner'),
('Event',       'Order placed at a hosted bakery event');


-- Supplier
INSERT INTO Supplier (SUPPLIER_NAME, SUPPLIER_PHONE, SUPPLIER_EMAIL) VALUES
('Golden Grain Co.',        '555-0101',     'orders@goldengrain.com'),
('Fresh Dairy Farm',        '555-0102',     'supply@freshdairy.com'),
('SweetCane Sugar Co.',     '555-0103',     'sales@sweetcane.com'),
('Pure Cocoa Imports',      '555-0104',     'info@purecocoa.com'),
('Sunrise Egg Farm',        '555-0105',     'orders@sunriseegg.com'),
('Valley Fruit Suppliers',  '555-0106',     'contact@valleyfruit.com'),
('Nutty Harvest Co.',       '555-0107',     'sales@nuttyharvest.com'),
('Coastal Salt Works',      '555-0108',     'info@coastalsalt.com'),
('Premium Vanilla Co.',     '555-0109',     'orders@premiumvanilla.com'),
('EcoPackaging Supplies',   '555-0110',     'supply@ecopackaging.com');


-- Customer (depends on LoyaltyProgram)
INSERT INTO Customer (CUSTOMER_LNAME, CUSTOMER_FNAME, CUSTOMER_PHONE, CUSTOMER_EMAIL, LOYALTY_ID) VALUES
('Johnson',     'Emily',    '555-1001',     'emily.johnson@email.com',      1),
('Chen',        'Michael',  '555-1002',     'michael.chen@email.com',       2),
('Martinez',    'Sofia',    '555-1003',     'sofia.martinez@email.com',     3),
('Williams',    'James',    '555-1004',     'james.williams@email.com',     4),
('Thompson',    'Rachel',   '555-1005',     'rachel.thompson@email.com',    5),
('Nguyen',      'David',    '555-1006',     'david.nguyen@email.com',       NULL),
('Patel',       'Priya',    '555-1007',     'priya.patel@email.com',        NULL),
('Anderson',    'Lucas',    '555-1008',     'lucas.anderson@email.com',     6),
('Kim',         'Jenny',    '555-1009',     'jenny.kim@email.com',          7),
('Brown',       'Oliver',   '555-1010',     'oliver.brown@email.com',       NULL);


-- Employee (depends on Role)
INSERT INTO Employee (EMP_LNAME, EMP_FNAME, EMP_PHONE, ROLE_ID) VALUES
('Baker',       'Mary',     '555-2001',     1),
('Santos',      'Carlos',   '555-2002',     2),
('Lee',         'Hannah',   '555-2003',     3),
('Nguyen',      'Peter',    '555-2004',     4),
('Davis',       'Tom',      '555-2005',     5),
('Wilson',      'Sarah',    '555-2006',     6),
('Moore',       'Daniel',   '555-2007',     7),
('Taylor',      'Jessica',  '555-2008',     8),
('Clark',       'Henry',    '555-2009',     9),
('White',       'Grace',    '555-2010',     10);


-- Inventory (depends on Ingredient)
INSERT INTO Inventory (CURRENT_STOCK, REORDER_LEVEL, INVENTORY_LAST_UPDATE, INGREDIENT_ID) VALUES
(45.00,     10.00,  '2025-03-01',   1),
(12.00,     5.00,   '2025-03-01',   2),
(30.00,     8.00,   '2025-03-01',   3),
(25.00,     10.00,  '2025-03-01',   4),
(200.00,    50.00,  '2025-03-01',   5),
(8.00,      5.00,   '2025-03-01',   6),
(3.00,      5.00,   '2025-03-01',   7),
(4.00,      2.00,   '2025-03-01',   8),
(6.00,      3.00,   '2025-03-01',   9),
(10.00,     4.00,   '2025-03-01',   10);


-- NutritionalInfo (depends on Product)
INSERT INTO NutritionalInfo (CALORIES_TOTAL, FAT_TOTAL, CARBS_TOTAL, PROTEIN_TOTAL, SERVING_SIZE, PRODUCT_ID) VALUES
(210,   2.50,   38.00,  7.00,   '1 slice (90g)',        1),
(480,   22.00,  65.00,  6.00,   '1 slice (120g)',       2),
(310,   18.00,  28.00,  5.00,   '1 croissant (65g)',    3),
(120,   4.50,   14.00,  6.00,   '1 cup (240ml)',        4),
(160,   8.00,   22.00,  2.00,   '1 cookie (35g)',       5),
(290,   16.00,  24.00,  9.00,   '1 slice (110g)',       6),
(180,   5.00,   30.00,  3.00,   '1 mooncake (75g)',     7),
(220,   9.00,   32.00,  3.50,   '1 tart (80g)',         8),
(340,   14.00,  50.00,  5.00,   '1 muffin (110g)',      9),
(180,   8.00,   18.00,  9.00,   '1 sandwich (85g)',     10);


-- Order (depends on Customer, SalesChannel, SalesReport)
INSERT INTO `Order` (ORDER_DATE, ORDER_TIME, ORDER_TOTAL, CUSTOMER_ID, CHANNEL_ID, REPORT_ID) VALUES
('2024-11-05',  '08:30:00',     24.50,  1,  1,  4),
('2024-11-12',  '09:15:00',     18.00,  2,  1,  4),
('2024-11-20',  '10:45:00',     45.00,  3,  2,  4),
('2024-12-01',  '11:00:00',     96.00,  4,  3,  4),
('2024-12-10',  '14:30:00',     32.00,  5,  1,  4),
('2024-12-15',  '08:00:00',     27.50,  6,  1,  4),
('2024-12-16',  '09:30:00',     15.00,  6,  4,  4),
('2024-12-18',  '13:00:00',     42.00,  6,  2,  4),
('2024-12-20',  '16:00:00',     33.00,  6,  1,  4),
('2024-12-22',  '10:00:00',     19.50,  6,  3,  4),
('2024-12-24',  '11:30:00',     55.00,  6,  1,  4),
('2025-01-05',  '08:45:00',     28.00,  7,  1,  5),
('2025-01-10',  '10:00:00',     64.00,  8,  2,  5),
('2025-01-15',  '12:30:00',     37.50,  9,  1,  5),
('2025-01-20',  '15:00:00',     22.00,  10, 4,  5),
('2025-01-22',  '09:00:00',     18.50,  10, 1,  5),
('2025-01-25',  '11:00:00',     29.00,  10, 2,  5),
('2025-02-01',  '08:30:00',     41.00,  1,  1,  5),
('2025-02-14',  '10:15:00',     88.00,  2,  3,  5),
('2025-02-20',  '14:00:00',     33.50,  3,  1,  5);


-- Product (depends on ProductCategory)
INSERT INTO Product (PRODUCT_NAME, PRODUCT_PRICE, PRODUCT_TYPE, PRODUCT_DESCRIPTION, PCATEGORY_ID) VALUES
('Sourdough Loaf',          8.50,   'Baked Good',   'Classic sourdough with crispy crust',          1),
('Chocolate Fudge Cake',    32.00,  'Baked Good',   'Rich layered chocolate cake with fudge icing', 2),
('Butter Croissant',        4.50,   'Baked Good',   'Flaky golden croissant with butter layers',    3),
('Caffe Latte',             6.00,   'Beverage',     'Espresso with steamed whole milk',             4),
('Chocolate Chip Cookie',   3.00,   'Baked Good',   'Crispy edged chewy centered cookie',          5),
('Spinach Quiche',          9.50,   'Savory',       'Shortcrust pastry with spinach egg filling',   6),
('Mooncake',                12.00,  'Seasonal',     'Traditional lotus paste mooncake',             7),
('Strawberry Tart',         7.50,   'Baked Good',   'Custard tart topped with fresh strawberries',  9),
('Blueberry Muffin',        4.00,   'Baked Good',   'Moist muffin packed with fresh blueberries',   10),
('Catering Sandwich Platter', 45.00, 'Catering',     'Assorted finger sandwiches for events',        8);


-- ProductPromotion (depends on Product, Promotion)
INSERT INTO ProductPromotion (PRODUCT_PROMO_DATE, PRODUCT_PROMO_DEPT, PRODUCT_PROMO_CAT, PRODUCT_ID, PROMOTION_ID) VALUES
('2024-06-01',  'Pastry',       'Pastries',     3,  1),
('2024-12-15',  'Kitchen',      'Cakes',        2,  2),
('2025-02-10',  'Pastry',       'Tarts',        8,  3),
('2025-04-14',  'Kitchen',      'Seasonal',     7,  4),
('2025-01-01',  'Front of House','Beverages',   4,  5),
('2024-12-31',  'Kitchen',      'Bread',        1,  6),
('2024-09-10',  'Kitchen',      'Seasonal',     7,  7),
('2025-01-01',  'Pastry',       'Cookies',      5,  8),
('2025-01-04',  'Beverages',    'Beverages',    4,  9),
('2025-01-01',  'Catering',     'Catering Platters', 10, 10);


-- Role (depends on Department)
INSERT INTO Role (ROLE_NAME, ROLE_DESC, ROLE_WORKHOURS, ROLE_TYPE, DEPT_CODE) VALUES
('Head Baker',          'Leads all baking operations and recipe development',        40, 'Full-Time',    1),
('Pastry Chef',         'Specializes in pastries and dessert preparation',           40, 'Full-Time',    7),
('Barista',             'Prepares and serves all beverages',                         32, 'Part-Time',    8),
('Counter Staff',       'Handles customer orders and front of house service',        32, 'Part-Time',    2),
('Delivery Driver',     'Manages order deliveries to customers',                     40, 'Full-Time',    3),
('Catering Manager',    'Coordinates catering orders and event logistics',           40, 'Full-Time',    6),
('Store Manager',       'Oversees daily bakery operations and staff management',     40, 'Full-Time',    4),
('Marketing Officer',   'Manages promotions, social media, and customer outreach',   40, 'Full-Time',    5),
('Procurement Officer', 'Handles supplier relations and ingredient purchasing',      40, 'Full-Time',    10),
('Cleaning Staff',      'Maintains cleanliness and sanitation throughout the store', 24, 'Part-Time',    9);


-- CateringInvoice (depends on CateringOrder)
INSERT INTO CateringInvoice (CAT_INVOICE_DATE, CAT_INVOICE_TOTAL, CAT_INVOICE_STATUS, CATERING_ORDER_ID) VALUES
('2025-03-10',  4500.00,    'Unpaid',   1),
('2025-02-15',  1200.00,    'Paid',     2),
('2025-04-01',  8000.00,    'Unpaid',   3),
('2025-02-20',  650.00,     'Paid',     4),
('2025-04-20',  300.00,     'Paid',     5),
('2025-06-01',  2200.00,    'Unpaid',   6),
('2025-07-10',  5500.00,    'Unpaid',   7),
('2025-04-20',  400.00,     'Paid',     8),
('2025-05-10',  1800.00,    'Unpaid',   9),
('2025-03-20',  1100.00,    'Paid',     10);


-- CateringOrder (depends on Customer, Event)
INSERT INTO CateringOrder (CATERING_ORDER_DATE, CATERING_ORDER_TOTAL, CUSTOMER_ID, EVENT_ID) VALUES
('2025-03-10',  4500.00,    1,  1),
('2025-02-15',  1200.00,    2,  2),
('2025-04-01',  8000.00,    3,  3),
('2025-02-20',  650.00,     4,  4),
('2025-04-20',  300.00,     5,  5),
('2025-06-01',  2200.00,    6,  6),
('2025-07-10',  5500.00,    7,  7),
('2025-04-20',  400.00,     8,  8),
('2025-05-10',  1800.00,    9,  9),
('2025-03-20',  1100.00,    10, 10);


-- Delivery (depends on Order)
-- Only orders placed through Delivery channel (CHANNEL_ID 3)
INSERT INTO Delivery (DELIVERY_TYPE, DELIVERY_ADDRESS, DELIVERY_STATUS, ORDER_ID) VALUES
('Standard',    '22 Birchwood Drive, Springfield',     'Delivered',    4),
('Express',     '88 Sunset Boulevard, Riverside',      'Delivered',    10),
('Standard',    '14 Maple Court, Greenfield',          'In Transit',   19);


-- Expense (depends on SupplierInvoice)
INSERT INTO Expense (EXPENSE_AMOUNT, EXPENSE_DATE, SUP_INVOICE_ID) VALUES
(3200.00,   '2024-10-01',   1),
(1800.00,   '2024-10-15',   2),
(2400.00,   '2024-11-01',   3),
(950.00,    '2024-11-15',   4),
(4100.00,   '2024-12-01',   5),
(2200.00,   '2024-12-15',   6),
(3800.00,   '2025-01-01',   7),
(1100.00,   '2025-01-15',   8),
(2900.00,   '2025-02-01',   9),
(1600.00,   '2025-02-15',   10);


-- HolidayProductSales (depends on Holiday, Product)
INSERT INTO HolidayProductSales (HOLIDAY_SALES_START_DATE, HOLIDAY_SALES_END_DATE, HOLIDAY_SALES_VOLUME, HOLIDAY_SALES_REVENUE, HOLIDAY_ID, PRODUCT_ID) VALUES
('2024-12-20',  '2024-12-26',   320,    10240.00,   1,  2),
('2024-12-20',  '2024-12-26',   210,    1785.00,    1,  3),
('2024-12-31',  '2025-01-01',   180,    1530.00,    2,  3),
('2025-02-14',  '2025-02-14',   150,    1125.00,    3,  8),
('2025-04-18',  '2025-04-21',   200,    900.00,     4,  5),
('2024-09-17',  '2024-09-17',   1200,   14400.00,   5,  7),
('2025-05-11',  '2025-05-11',   175,    5600.00,    6,  2),
('2024-11-28',  '2024-11-28',   140,    6300.00,    7,  10),
('2025-01-29',  '2025-02-04',   380,    4560.00,    8,  7),
('2024-10-31',  '2024-10-31',   220,    660.00,     9,  5);


-- ProductAllergy (depends on Product, AllergyInfo)
INSERT INTO ProductAllergy (PRODUCT_ALLERGY_CONTENT, PRODUCT_ALLERGY_DISCLAIMER, ALLERGY_ID, PRODUCT_ID) VALUES
('Wheat flour',         'Contains gluten, not suitable for celiac',             1,  1),
('Milk, butter, eggs',  'Contains dairy and eggs',                              2,  2),
('Milk, butter, eggs',  'Contains dairy and eggs',                              3,  2),
('Milk',                'Contains dairy',                                       2,  4),
('Wheat, eggs',         'Contains gluten and eggs',                             3,  5),
('Wheat, eggs, milk',   'Contains gluten, eggs, and dairy',                     1,  6),
('Wheat, eggs, milk',   'Contains gluten, eggs, and dairy',                     3,  6),
('Wheat, eggs, milk',   'Contains gluten, eggs, and dairy',                     1,  8),
('Wheat, eggs, milk',   'Contains gluten, eggs, and dairy',                     2,  9),
('Wheat',               'Contains gluten',                                      1,  10);


-- Review (depends on Customer, Product)
CREATE TABLE Review (
    REVIEW_ID       INT             AUTO_INCREMENT PRIMARY KEY,
    REVIEW_RATING   INT             NOT NULL,
    REVIEW_COMMENT  VARCHAR(500),
    REVIEW_DATE     DATE            NOT NULL,
    CUSTOMER_ID     INT             NOT NULL,
    PRODUCT_ID      INT             NOT NULL,
    CONSTRAINT CHK_Rating CHECK (REVIEW_RATING BETWEEN 1 AND 5),
    FOREIGN KEY (CUSTOMER_ID)   REFERENCES Customer(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID)    REFERENCES Product(PRODUCT_ID)
);


-- SalesReport
INSERT INTO SalesReport (REPORT_START_DATE, REPORT_END_DATE, REPORT_TOTAL_REVENUE, REPORT_TOTAL_SALES, SALES_DESC) VALUES
('2024-01-01',  '2024-03-31',   125000.00,  4200.00,    'Q1 2024 Sales Report'),
('2024-04-01',  '2024-06-30',   138000.00,  4800.00,    'Q2 2024 Sales Report'),
('2024-07-01',  '2024-09-30',   142000.00,  5100.00,    'Q3 2024 Sales Report'),
('2024-10-01',  '2024-12-31',   168000.00,  5900.00,    'Q4 2024 Sales Report'),
('2025-01-01',  '2025-03-31',   131000.00,  4500.00,    'Q1 2025 Sales Report');


-- Shift (depends on Employee)
INSERT INTO Shift (SHIFT_DATE, SHIFT_START_TIME, SHIFT_END_TIME, EMP_CODE) VALUES
('2025-03-01',  '06:00:00',     '14:00:00',     1),
('2025-03-01',  '06:00:00',     '14:00:00',     2),
('2025-03-01',  '08:00:00',     '16:00:00',     3),
('2025-03-01',  '08:00:00',     '16:00:00',     4),
('2025-03-01',  '10:00:00',     '18:00:00',     5),
('2025-03-02',  '06:00:00',     '14:00:00',     1),
('2025-03-02',  '08:00:00',     '16:00:00',     3),
('2025-03-02',  '08:00:00',     '16:00:00',     4),
('2025-03-02',  '14:00:00',     '22:00:00',     6),
('2025-03-03',  '06:00:00',     '14:00:00',     2),
('2025-03-03',  '08:00:00',     '16:00:00',     7),
('2025-03-03',  '14:00:00',     '22:00:00',     8);


-- SupplierIngredient (depends on Supplier, Ingredient)
INSERT INTO SupplierIngredient (SUPPLY_UNIT, SUPPLY_PRICE, SUPPLIER_ID, INGREDIENT_ID) VALUES
('kg',  0.85,   1,  1),
('kg',  4.50,   2,  2),
('L',   1.20,   2,  3),
('kg',  1.10,   3,  4),
('unit',0.25,   5,  5),
('kg',  12.00,  4,  6),
('L',   3.80,   2,  7),
('L',   18.00,  9,  8),
('kg',  6.50,   1,  9),
('kg',  2.20,   8,  10);


-- SupplierInvoice (depends on Supplier)
INSERT INTO SupplierInvoice (SUP_INVOICE_DATE, SUP_INVOICE_TOTAL, SUP_INVOICE_STATUS, SUPPLIER_ID) VALUES
('2024-10-01',  3200.00,    'Paid',     1),
('2024-10-15',  1800.00,    'Paid',     2),
('2024-11-01',  2400.00,    'Paid',     3),
('2024-11-15',  950.00,     'Paid',     4),
('2024-12-01',  4100.00,    'Paid',     1),
('2024-12-15',  2200.00,    'Paid',     2),
('2025-01-01',  3800.00,    'Paid',     5),
('2025-01-15',  1100.00,    'Unpaid',   6),
('2025-02-01',  2900.00,    'Unpaid',   3),
('2025-02-15',  1600.00,    'Unpaid',   7);


-- WasteLog (depends on Ingredient, Supplier)
INSERT INTO WasteLog (WASTE_DATE, WASTE_QUANTITY, WASTE_REASON, INGREDIENT_ID, SUPPLIER_ID) VALUES
('2025-01-05',  2.50,   'Expired before use',           3,  2),
('2025-01-12',  1.00,   'Damaged packaging on delivery',1,  1),
('2025-01-18',  0.50,   'Expired before use',           7,  2),
('2025-01-25',  3.00,   'Overstock spoilage',           3,  NULL),
('2025-02-02',  0.75,   'Expired before use',           8,  9),
('2025-02-10',  1.50,   'Damaged packaging on delivery',2,  2),
('2025-02-14',  2.00,   'Overstock spoilage',           4,  NULL),
('2025-02-20',  0.25,   'Expired before use',           6,  4),
('2025-03-01',  1.00,   'Damaged packaging on delivery',5,  5),
('2025-03-05',  0.50,   'Overstock spoilage',           9,  NULL);


-- OrderAssignment (depends on Order, Employee)
INSERT INTO OrderAssignment (ORDER_ASSIGNMENT_TIME, ORDER_ASSIGNMENT_DATE, ORDER_ID, EMP_CODE) VALUES
-- Order 1
('08:25:00', '2024-11-05',  1,  4),
('08:20:00', '2024-11-05',  1,  1),
-- Order 2
('09:10:00', '2024-11-12',  2,  4),
('09:05:00', '2024-11-12',  2,  2),
-- Order 3
('10:40:00', '2024-11-20',  3,  4),
('10:35:00', '2024-11-20',  3,  1),
-- Order 4
('10:55:00', '2024-12-01',  4,  5),
('10:50:00', '2024-12-01',  4,  1),
-- Order 5
('14:25:00', '2024-12-10',  5,  4),
('14:20:00', '2024-12-10',  5,  2),
-- Order 6
('07:55:00', '2024-12-15',  6,  4),
('07:50:00', '2024-12-15',  6,  1),
-- Order 7
('09:25:00', '2024-12-16',  7,  4),
-- Order 8
('12:55:00', '2024-12-18',  8,  4),
('12:50:00', '2024-12-18',  8,  2),
-- Order 9
('15:55:00', '2024-12-20',  9,  4),
('15:50:00', '2024-12-20',  9,  1),
-- Order 10
('09:55:00', '2024-12-22',  10, 5),
-- Order 11
('11:25:00', '2024-12-24',  11, 4),
('11:20:00', '2024-12-24',  11, 1),
-- Order 12
('08:40:00', '2025-01-05',  12, 4),
('08:35:00', '2025-01-05',  12, 2),
-- Order 13
('09:55:00', '2025-01-10',  13, 4),
('09:50:00', '2025-01-10',  13, 1),
-- Order 14
('12:25:00', '2025-01-15',  14, 4),
('12:20:00', '2025-01-15',  14, 2),
-- Order 15
('14:55:00', '2025-01-20',  15, 4),
-- Order 16
('08:55:00', '2025-01-22',  16, 4),
('08:50:00', '2025-01-22',  16, 1),
-- Order 17
('10:55:00', '2025-01-25',  17, 4),
('10:50:00', '2025-01-25',  17, 2),
-- Order 18
('08:25:00', '2025-02-01',  18, 4),
('08:20:00', '2025-02-01',  18, 1),
-- Order 19
('10:10:00', '2025-02-14',  19, 5),
('10:05:00', '2025-02-14',  19, 2),
-- Order 20
('13:55:00', '2025-02-20',  20, 4),
('13:50:00', '2025-02-20',  20, 1);



-- OrderLine (depends on Order, Product)
INSERT INTO OrderLine (ORDERLINE_QUANTITY, ORDERLINE_PRICE, ORDER_ID, PRODUCT_ID) VALUES
-- Order 1: Emily Johnson, In-Store (total 24.50)
(2,     4.50,   1,  3),
(1,     8.50,   1,  1),
(2,     3.00,   1,  5),

-- Order 2: Michael Chen, In-Store (total 18.00)
(3,     4.00,   2,  9),
(1,     6.00,   2,  4),

-- Order 3: Sofia Martinez, Pickup (total 45.00)
(1,     9.50,   3,  6),
(1,     32.00,  3,  2),
(1,     3.50,   3,  8),

-- Order 4: James Williams, Delivery (total 96.00)
(2,     32.00,  4,  2),
(3,     4.50,   4,  3),
(3,     3.00,   4,  5),
(1,     9.50,   4,  6),

-- Order 5: Rachel Thompson, In-Store (total 32.00)
(2,     7.50,   5,  8),
(2,     4.00,   5,  9),
(3,     3.00,   5,  5),

-- Order 6: David Nguyen, In-Store (total 27.50)
(1,     8.50,   6,  1),
(2,     4.50,   6,  3),
(2,     3.00,   6,  5),

-- Order 7: David Nguyen, Online (total 15.00)
(1,     9.50,   7,  6),
(1,     6.00,   7,  4),

-- Order 8: David Nguyen, Pickup (total 42.00)
(1,     32.00,  8,  2),
(2,     4.00,   8,  9),
(1,     3.00,   8,  5),

-- Order 9: David Nguyen, In-Store (total 33.00)
(1,     7.50,   9,  8),
(1,     12.00,  9,  7),
(2,     6.00,   9,  4),
(1,     3.00,   9,  5),

-- Order 10: David Nguyen, Delivery (total 19.50)
(1,     12.00,  10, 7),
(2,     3.00,   10, 5),
(1,     1.50,   10, 9),

-- Order 11: David Nguyen, In-Store (total 55.00)
(1,     45.00,  11, 10),
(2,     4.50,   11, 3),
(1,     1.00,   11, 5),

-- Order 12: Priya Patel, In-Store (total 28.00)
(2,     8.50,   12, 1),
(1,     7.50,   12, 8),
(1,     3.50,   12, 3),

-- Order 13: Lucas Anderson, Pickup (total 64.00)
(2,     32.00,  13, 2),
(0,     0.00,   13, 4),
(0,     0.00,   13, 3),

-- Order 14: Jenny Kim, In-Store (total 37.50)
(3,     7.50,   14, 8),
(3,     4.50,   14, 3),
(1,     6.00,   14, 4),

-- Order 15: Oliver Brown, Online (total 22.00)
(1,     12.00,  15, 7),
(2,     4.00,   15, 9),
(1,     3.00,   15, 5),
(1,     3.00,   15, 5),

-- Order 16: Oliver Brown, In-Store (total 18.50)
(2,     4.50,   16, 3),
(1,     6.00,   16, 4),
(1,     3.50,   16, 8),

-- Order 17: Oliver Brown, Pickup (total 29.00)
(1,     8.50,   17, 1),
(1,     12.00,  17, 7),
(2,     4.50,   17, 3),

-- Order 18: Emily Johnson, In-Store (total 41.00)
(1,     32.00,  18, 2),
(3,     3.00,   18, 5),

-- Order 19: Michael Chen, Delivery (total 88.00)
(1,     45.00,  19, 10),
(1,     32.00,  19, 2),
(2,     4.50,   19, 3),
(1,     3.00,   19, 5),

-- Order 20: Sofia Martinez, In-Store (total 33.50)
(1,     8.50,   20, 1),
(2,     7.50,   20, 8),
(2,     4.50,   20, 3);
