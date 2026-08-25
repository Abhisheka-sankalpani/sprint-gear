
USE sprint_gear;


-- =========================================
-- 1. USER
-- =========================================
CREATE TABLE User (
    User_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_Name VARCHAR(100) NOT NULL,
    E_Mail VARCHAR(150) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20)
);


-- =========================================
-- 2. ADDRESS
-- User 1 : N Address
-- =========================================
CREATE TABLE Address (
    Address_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Address_Line VARCHAR(255) NOT NULL,
    City VARCHAR(100),
    Postal_Code VARCHAR(20),

    FOREIGN KEY (User_ID)
        REFERENCES User(User_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 3. CATEGORY
-- =========================================
CREATE TABLE Category (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL,
    Parent_Category_ID INT NULL,
    Description TEXT,

    FOREIGN KEY (Parent_Category_ID)
        REFERENCES Category(Category_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- =========================================
-- 4. PRODUCT
-- Category 1 : N Product
-- =========================================
CREATE TABLE Product (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_ID INT NOT NULL,
    Product_Name VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Description TEXT,
    Status VARCHAR(30),

    FOREIGN KEY (Category_ID)
        REFERENCES Category(Category_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- =========================================
-- 5. GENDER
-- =========================================
CREATE TABLE Gender (
    Gender_ID INT AUTO_INCREMENT PRIMARY KEY,
    Gender_Name VARCHAR(50) NOT NULL
);


-- =========================================
-- 6. COLOR
-- =========================================
CREATE TABLE Color (
    Color_ID INT AUTO_INCREMENT PRIMARY KEY,
    Color_Name VARCHAR(50) NOT NULL,
    Color_Code VARCHAR(20)
);


-- =========================================
-- 7. MATERIAL
-- =========================================
CREATE TABLE Material (
    Material_ID INT AUTO_INCREMENT PRIMARY KEY,
    Material_Name VARCHAR(100) NOT NULL
);


-- =========================================
-- 8. SIZE
-- =========================================
CREATE TABLE Size (
    Size_ID INT AUTO_INCREMENT PRIMARY KEY,
    Size_Name VARCHAR(50) NOT NULL
);


-- =========================================
-- 9. PRODUCT VARIANT
-- Product 1 : N Product_Variant
-- Gender 1 : N Product_Variant
-- Color 1 : N Product_Variant
-- Material 1 : N Product_Variant
-- Size 1 : N Product_Variant
-- =========================================
CREATE TABLE Product_Variant (
    Variant_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Gender_ID INT,
    Color_ID INT,
    Material_ID INT,
    Size_ID INT,
    Price DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 0,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Gender_ID)
        REFERENCES Gender(Gender_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (Color_ID)
        REFERENCES Color(Color_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (Material_ID)
        REFERENCES Material(Material_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE,

    FOREIGN KEY (Size_ID)
        REFERENCES Size(Size_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);


-- =========================================
-- 10. PRODUCT IMAGE
-- Product 1 : N Product_Image
-- =========================================
CREATE TABLE Product_Image (
    Image_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Image_URL VARCHAR(500) NOT NULL,
    Is_Main BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 11. CART
-- User 1 : 1 Cart
-- =========================================
CREATE TABLE Cart (
    Cart_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL UNIQUE,
    Created_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (User_ID)
        REFERENCES User(User_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 12. CART ITEM
-- Cart 1 : N Cart_Item
-- Product_Variant 1 : N Cart_Item
-- =========================================
CREATE TABLE Cart_Item (
    Cart_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Cart_ID INT NOT NULL,
    Variant_ID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,

    FOREIGN KEY (Cart_ID)
        REFERENCES Cart(Cart_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Variant_ID)
        REFERENCES Product_Variant(Variant_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 13. ORDER
-- User 1 : N Order
-- =========================================
CREATE TABLE `Order` (
    Order_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Total_Amount DECIMAL(10,2) NOT NULL,
    Status VARCHAR(50),
    Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (User_ID)
        REFERENCES User(User_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- =========================================
-- 14. ORDER ITEM
-- Order 1 : N Order_Item
-- Product_Variant 1 : N Order_Item
-- =========================================
CREATE TABLE Order_Item (
    Order_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL,
    Variant_ID INT NOT NULL,
    Quantity INT NOT NULL,
    Unit_Price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Order_ID)
        REFERENCES `Order`(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Variant_ID)
        REFERENCES Product_Variant(Variant_ID)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);


-- =========================================
-- 15. DELIVERY
-- Order 1 : 1 Delivery
-- =========================================
CREATE TABLE Delivery (
    Delivery_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Delivery_Address VARCHAR(255) NOT NULL,
    Delivery_Date DATE,
    Delivery_Status VARCHAR(50),
    Tracking_No VARCHAR(100),

    FOREIGN KEY (Order_ID)
        REFERENCES `Order`(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 16. PAYMENT
-- Order 1 : 1 Payment
-- =========================================
CREATE TABLE Payment (
    Payment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID INT NOT NULL UNIQUE,
    Payment_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Payment_Method VARCHAR(50),
    Payment_Status VARCHAR(50),
    Amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (Order_ID)
        REFERENCES `Order`(Order_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 17. REVIEW
-- User 1 : N Review
-- Product 1 : N Review
-- =========================================
CREATE TABLE Review (
    Review_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Rating INT,
    Comment TEXT,
    Review_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (User_ID)
        REFERENCES User(User_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 18. WISHLIST
-- User 1 : 1 Wishlist
-- =========================================
CREATE TABLE Wishlist (
    Wishlist_ID INT AUTO_INCREMENT PRIMARY KEY,
    User_ID INT NOT NULL UNIQUE,
    Created_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (User_ID)
        REFERENCES User(User_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- =========================================
-- 19. WISHLIST ITEM
-- Wishlist 1 : N Wishlist_Item
-- Product 1 : N Wishlist_Item
-- =========================================
CREATE TABLE Wishlist_Item (
    Wishlist_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
    Wishlist_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Added_Date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (Wishlist_ID)
        REFERENCES Wishlist(Wishlist_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);