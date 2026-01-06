IF DB_ID('NazSushiBar') IS NULL
    CREATE DATABASE NazSushiBar;
GO

USE NazSushiBar;
GO

IF OBJECT_ID('dbo.sales','U') IS NOT NULL DROP TABLE dbo.sales;
IF OBJECT_ID('dbo.members','U') IS NOT NULL DROP TABLE dbo.members;
IF OBJECT_ID('dbo.menu','U') IS NOT NULL DROP TABLE dbo.menu;
GO

CREATE TABLE dbo.menu (
    product_id   INT         NOT NULL PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category     VARCHAR(30) NOT NULL,
    price_gbp    DECIMAL(10,2) NOT NULL
);

CREATE TABLE dbo.members (
    customer_id  CHAR(1) NOT NULL PRIMARY KEY,
    join_date    DATE    NOT NULL
);

CREATE TABLE dbo.sales (
    order_id     INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    customer_id  CHAR(1) NOT NULL,
    order_date   DATE    NOT NULL,
    product_id   INT     NOT NULL,
    quantity     INT     NOT NULL DEFAULT 1,
    CONSTRAINT FK_sales_menu FOREIGN KEY (product_id) REFERENCES dbo.menu(product_id)
);
GO

CREATE INDEX IX_sales_customer_date ON dbo.sales(customer_id, order_date);
CREATE INDEX IX_sales_product ON dbo.sales(product_id);
GO
