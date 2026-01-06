USE NazSushiBar;
GO

INSERT INTO dbo.menu (product_id, product_name, category, price_gbp) VALUES
(1,'Sushi','Main',10.00),
(2,'Ramen','Main',12.00),
(3,'Curry','Main',11.00),
(4,'Miso Soup','Side',3.50),
(5,'Green Tea','Drink',2.50),
(6,'Mochi','Dessert',4.00);

INSERT INTO dbo.members (customer_id, join_date) VALUES
('A','2025-01-07'),
('B','2025-01-09'),
('C','2025-01-15');

INSERT INTO dbo.sales (customer_id, order_date, product_id, quantity) VALUES
('A','2025-01-01',1,1),
('A','2025-01-01',4,1),
('A','2025-01-04',2,1),
('A','2025-01-06',1,2),
('A','2025-01-08',3,1),
('A','2025-01-10',6,1),

('B','2025-01-01',2,1),
('B','2025-01-02',5,1),
('B','2025-01-04',1,1),
('B','2025-01-08',1,1),
('B','2025-01-11',3,1),
('B','2025-01-16',2,1),

('C','2025-01-03',3,1),
('C','2025-01-05',1,1),
('C','2025-01-07',4,2),
('C','2025-01-12',2,1),
('C','2025-01-18',1,1);
GO
