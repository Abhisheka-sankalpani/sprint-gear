USE sprint_gear;

INSERT INTO Category (Category_Name, Description) VALUES
('Running','Running shoes and accessories'),
('Training','Training and gym equipment'),
('Sportswear','Sports clothing');

INSERT INTO Gender (Gender_Name) VALUES ('Male'),('Female'),('Unisex');
INSERT INTO Color (Color_Name,Color_Code) VALUES ('Black','#000000'),('White','#FFFFFF'),('Red','#FF0000');
INSERT INTO Material (Material_Name) VALUES ('Mesh'),('Cotton'),('Polyester');
INSERT INTO Size (Size_Name) VALUES ('S'),('M'),('L'),('XL'),('40'),('41'),('42'),('43');

INSERT INTO Product (Category_ID,Product_Name,Price,Description,Status) VALUES
(1,'Sprint Running Shoes',12500.00,'Lightweight running shoes for daily training.','Active'),
(2,'Pro Training T-Shirt',4500.00,'Comfortable performance training shirt.','Active'),
(3,'Performance Sports Shorts',3800.00,'Flexible shorts for sports and training.','Active');

INSERT INTO Product_Variant (Product_ID,Gender_ID,Color_ID,Material_ID,Size_ID,Price,Quantity) VALUES
(1,1,1,1,7,12500,20),(1,2,2,1,6,12500,15),
(2,3,3,3,2,4500,30),(2,1,1,3,3,4500,25),
(3,3,2,2,3,3800,20);

-- Register a user before testing checkout.
INSERT INTO User (User_Name,E_Mail,Password,Phone)
VALUES ('Demo User','demo@sprintgear.com','demo123','0712345678');
