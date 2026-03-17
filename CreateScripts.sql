-- CREATE Scripts for all tables

-- ==========================================================================================================================
-- Create independent tables
-- LoyaltyProgram table
CREATE TABLE LoyaltyProgram (
    LOYALTY_ID              INT             AUTO_INCREMENT PRIMARY KEY,
    LOYALTY_TIER            VARCHAR(20)     NOT NULL,
    LOYALTY_POINTS_MIN      INT             NOT NULL,
    LOYALTY_POINTS_MAX      INT
);

-- ProductCategory table
CREATE TABLE ProductCategory (
    PCATEGORY_ID    INT             AUTO_INCREMENT PRIMARY KEY,
    PCATEGORY_NAME  VARCHAR(100)    NOT NULL
);

-- Department table
CREATE TABLE Department (
    DEPT_CODE       INT             AUTO_INCREMENT PRIMARY KEY,
    DEPT_NAME       VARCHAR(100)    NOT NULL,
    DEPT_DESC       VARCHAR(100)
);

-- Ingredient table
CREATE TABLE Ingredient (
    INGREDIENT_ID   INT             AUTO_INCREMENT PRIMARY KEY,
    INGREDIENT_NAME VARCHAR(100)    NOT NULL,
    INGREDIENT_UNIT VARCHAR(50)     NOT NULL
);

-- Supplier table
CREATE TABLE Supplier (
    SUPPLIER_ID     INT             AUTO_INCREMENT PRIMARY KEY,
    SUPPLIER_NAME   VARCHAR(150)    NOT NULL,
    SUPPLIER_PHONE  VARCHAR(20),
    SUPPLIER_EMAIL  VARCHAR(100)
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

-- AllergyInfo table
CREATE TABLE AllergyInfo (
    ALLERGY_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    ALLERGY_NAME        VARCHAR(100)    NOT NULL,
    ALLERGY_DESC        VARCHAR(200),
    ALLERGY_TYPE        VARCHAR(100),
    ALLERGY_CONTENT     VARCHAR(100),
    ALLERGY_REACTION    VARCHAR(255)
);

-- Holiday table
CREATE TABLE Holiday (
    HOLIDAY_ID          INT             AUTO_INCREMENT PRIMARY KEY,
    HOLIDAY_NAME        VARCHAR(100)    NOT NULL,
    HOLIDAY_SEASON      VARCHAR(20),
    HOLIDAY_START_DATE  DATE            NOT NULL,
    HOLIDAY_END_DATE    DATE            NOT NULL
);

-- ==========================================================================================================================
-- Create tables dependent on independents
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

-- ==========================================================================================================================
-- Create table dependent on those above
-- SalesReport (no FK dependencies, but Order depends on it)
CREATE TABLE SalesReport (
    REPORT_ID               INT             AUTO_INCREMENT PRIMARY KEY,
    REPORT_START_DATE       DATE            NOT NULL,
    REPORT_END_DATE         DATE            NOT NULL,
    REPORT_TOTAL_REVENUE    DECIMAL(15,2)   NOT NULL    DEFAULT 0.00,
    REPORT_TOTAL_SALES      DECIMAL(15,2)   NOT NULL    DEFAULT 0.00,
    SALES_DESC              VARCHAR(200)
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

-- Shift (depends on Employee)
CREATE TABLE Shift (
    SHIFT_ID            INT             AUTO_INCREMENT PRIMARY KEY,
    SHIFT_DATE          DATE            NOT NULL,
    SHIFT_START_TIME    TIME            NOT NULL,
    SHIFT_END_TIME      TIME            NOT NULL,
    EMP_CODE            INT             NOT NULL,
    FOREIGN KEY (EMP_CODE) REFERENCES Employee(EMP_CODE)
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

-- SupplierInvoice (depends on Supplier)
CREATE TABLE SupplierInvoice (
    SUP_INVOICE_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    SUP_INVOICE_DATE    DATE            NOT NULL,
    SUP_INVOICE_TOTAL   DECIMAL(12,2)   NOT NULL,
    SUP_INVOICE_STATUS  VARCHAR(50)     NOT NULL    DEFAULT 'Unpaid',
    SUPPLIER_ID         INT             NOT NULL,
    FOREIGN KEY (SUPPLIER_ID) REFERENCES Supplier(SUPPLIER_ID)
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

-- Expense (depends on SupplierInvoice)
CREATE TABLE Expense (
    EXPENSE_ID      INT             AUTO_INCREMENT PRIMARY KEY,
    EXPENSE_AMOUNT  DECIMAL(12,2)   NOT NULL,
    EXPENSE_DATE    DATE            NOT NULL,
    SUP_INVOICE_ID  INT             NOT NULL    UNIQUE,
    FOREIGN KEY (SUP_INVOICE_ID) REFERENCES SupplierInvoice(SUP_INVOICE_ID)
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


-- ==========================================================================================================================
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
