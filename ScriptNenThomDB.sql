create database NenThomDB
go
use NenThomDB
go
-- Tạo bảng Account với AccountID tự động tăng bắt đầu từ 0
CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(0,1),    -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    Username VARCHAR(50) NOT NULL UNIQUE,   
    Password VARCHAR(255) NOT NULL     
);

-- Tạo bảng Users với UserID tự động tăng bắt đầu từ 0 và tham chiếu đến AccountID
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(0,1),       -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    AccountID INT NOT NULL,                       -- Tham chiếu đến bảng Account
    Email VARCHAR(100) UNIQUE,           -- Địa chỉ email của người dùng
    PhoneNumber VARCHAR(15),                     -- Số điện thoại
    Address NVARCHAR(1000),                      -- Địa chỉ của người dùng
    FOREIGN KEY (AccountID) REFERENCES Account(AccountID) ON DELETE CASCADE
);

-- Tạo bảng Role với RoleID tự động tăng bắt đầu từ 0
CREATE TABLE Role (
    RoleID INT PRIMARY KEY IDENTITY(0,1),        -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    Code NVARCHAR(50) NOT NULL UNIQUE,            -- Ví dụ: 'ADMIN', 'EMPLOYEE'
    Name NVARCHAR(255) NOT NULL                   -- Ví dụ: 'Quản lý', 'Nhân viên'
);

-- Tạo bảng UserRole với khóa chính là UserID và RoleID
CREATE TABLE UserRole (
    UserID INT NOT NULL,
    RoleID INT NOT NULL,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID) ON DELETE CASCADE
);

-- Tạo bảng Products với ProductID tự động tăng bắt đầu từ 0
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(0,1),    -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(1000),
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    ImageBase64 TEXT
);

-- Tạo bảng Categories với CategoryID tự động tăng bắt đầu từ 0
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(0,1),   -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    Name NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(1000)
);

-- Tạo bảng ProductCategories với khóa chính là ProductID và CategoryID
CREATE TABLE ProductCategories (
    ProductID INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) ON DELETE CASCADE
);

-- Tạo bảng Orders với OrderID tự động tăng bắt đầu từ 0
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(0,1),      -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    UserID INT NOT NULL,
    TotalPrice DECIMAL(10, 2) NOT NULL,
    OrderStatus NVARCHAR(20) NOT NULL CHECK (OrderStatus IN ('pending', 'confirmed', 'shipped', 'completed', 'cancelled')),
    ShippingAddress NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Tạo bảng OrderDetails với khóa chính là OrderID và ProductID
CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (OrderID, ProductID), -- Cặp khóa chính
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Reviews với ReviewID tự động tăng bắt đầu từ 0
CREATE TABLE Reviews (
    ReviewID INT PRIMARY KEY IDENTITY(0,1),     -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    ProductID INT NOT NULL,
    UserID INT NOT NULL,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5), -- Điểm đánh giá từ 1 đến 5
    Comment NVARCHAR(1000),
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE
);

-- Tạo bảng Cart với CartID tự động tăng bắt đầu từ 0
CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(0,1),       -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);

-- Tạo bảng Discounts với DiscountID tự động tăng bắt đầu từ 0
CREATE TABLE Discounts (
    DiscountID INT PRIMARY KEY IDENTITY(0,1),    -- IDENTITY(0,1) sẽ bắt đầu từ 0 và tăng dần
    DiscountName NVARCHAR(255) NOT NULL,     
    DiscountType NVARCHAR(20) NOT NULL CHECK (DiscountType IN ('percentage', 'fixed')),
    DiscountValue DECIMAL(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    IsActive BIT DEFAULT 1 -- BIT thay thế cho BOOLEAN, 1 là đang hoạt động
);

INSERT INTO Categories (Name, Description) 
VALUES 
('Scented Candles', NULL),
('Candle Holders', NULL),
('Candle Accessories', NULL),
('Gift Sets', NULL);

-- Thêm 5 sản phẩm cho loại "Scented Candles" 
INSERT INTO Products (Name, Description, Price, Stock, ImageBase64) 
VALUES 
('Lavender Scented Candle', NULL, 15.00, 100, NULL),
('Vanilla Scented Candle', NULL, 12.00, 150, NULL),
('Rose Scented Candle', NULL, 18.00, 80, NULL),
('Citrus Scented Candle', NULL, 10.00, 120, NULL),
('Jasmine Scented Candle', NULL, 20.00, 60, NULL);

-- Thêm 5 sản phẩm cho loại "Candle Holders"
INSERT INTO Products (Name, Description, Price, Stock, ImageBase64) 
VALUES 
('Wooden Candle Holder', NULL, 25.00, 50, NULL),
('Glass Candle Holder', NULL, 30.00, 40, NULL),
('Metal Candle Holder', NULL, 35.00, 70, NULL),
('Ceramic Candle Holder', NULL, 20.00, 90, NULL),
('Stone Candle Holder', NULL, 40.00, 30, NULL);

-- Thêm 5 sản phẩm cho loại "Candle Accessories"
INSERT INTO Products (Name, Description, Price, Stock, ImageBase64) 
VALUES 
('Candle Snuffer', NULL, 8.00, 200, NULL),
('Candle Wick Trimmer', NULL, 12.00, 180, NULL),
('Candle Lighter', NULL, 5.00, 250, NULL),
('Candle Tins', NULL, 7.00, 150, NULL),
('Candle Wax Melts', NULL, 6.00, 300, NULL);

-- Thêm 5 sản phẩm cho loại "Gift Sets"
INSERT INTO Products (Name, Description, Price, Stock, ImageBase64) 
VALUES 
('Lavender Gift Set', NULL, 40.00, 50, NULL),
('Vanilla Gift Set', NULL, 45.00, 60, NULL),
('Rose Gift Set', NULL, 50.00, 40, NULL),
('Citrus Gift Set', NULL, 35.00, 80, NULL),
('Jasmine Gift Set', NULL, 55.00, 30, NULL);





-- Liên kết sản phẩm với "Scented Candles" (CategoryID = 0)
INSERT INTO ProductCategories (ProductID, CategoryID)
VALUES 
(0, 0),  -- Lavender Scented Candle
(1, 0),  -- Vanilla Scented Candle
(2, 0),  -- Rose Scented Candle
(3, 0),  -- Citrus Scented Candle
(4, 0);  -- Jasmine Scented Candle

-- Liên kết sản phẩm với "Candle Holders" (CategoryID = 1)
INSERT INTO ProductCategories (ProductID, CategoryID)
VALUES 
(5, 1),  -- Wooden Candle Holder
(6, 1),  -- Glass Candle Holder
(7, 1),  -- Metal Candle Holder
(8, 1),  -- Ceramic Candle Holder
(9, 1);  -- Stone Candle Holder

-- Liên kết sản phẩm với "Candle Accessories" (CategoryID = 2)
INSERT INTO ProductCategories (ProductID, CategoryID)
VALUES 
(10, 2), -- Candle Snuffer
(11, 2), -- Candle Wick Trimmer
(12, 2), -- Candle Lighter
(13, 2), -- Candle Tins
(14, 2); -- Candle Wax Melts

-- Liên kết sản phẩm với "Gift Sets" (CategoryID = 3)
INSERT INTO ProductCategories (ProductID, CategoryID)
VALUES 
(15, 3), -- Lavender Gift Set
(16, 3), -- Vanilla Gift Set
(17, 3), -- Rose Gift Set
(18, 3), -- Citrus Gift Set
(19, 3); -- Jasmine Gift Set



-- Thêm role "Quản Lý"
INSERT INTO Role (Code, Name) 
VALUES (N'manager', N'Quản Lý');

-- Thêm role "Khách Hàng"
INSERT INTO Role (Code, Name) 
VALUES (N'user', N'Khách Hàng');

-- 1. Cho phép chèn vào cột IDENTITY
SET IDENTITY_INSERT Account ON;

-- Thêm tài khoản người quản lý và khách hàng
INSERT INTO Account (AccountID, Username, Password)
VALUES (0, N'm1', N'm1'),  -- Người quản lý 1
       (1, N'm2', N'm2'),  -- Người quản lý 2
       (2, N'u1', N'u1'),  -- Khách hàng 1
       (3, N'u2', N'u2');  -- Khách hàng 2

-- 2. Tắt tính năng cho phép chèn vào cột IDENTITY
SET IDENTITY_INSERT Account OFF;

-- 3. Thêm thông tin người quản lý và khách hàng vào bảng Users
SET IDENTITY_INSERT Users ON;
INSERT INTO Users (UserID, AccountID, Email, PhoneNumber, Address) 
VALUES 
    (0, 0, N'quanly1@nenthom.com', N'0901234567', N'123 Đường A, TP.HCM'),  -- Người quản lý 1
    (1, 1, N'quanly2@nenthom.com', N'0902345678', N'456 Đường B, TP.HCM'),  -- Người quản lý 2
    (2, 2, N'khachhang1@nenthom.com', N'0903456789', N'789 Đường C, TP.HCM'),  -- Khách hàng 1
    (3, 3, N'khachhang2@nenthom.com', N'0904567890', N'101 Đường D, TP.HCM');  -- Khách hàng 2
SET IDENTITY_INSERT Users OFF;

-- 4. Gán vai trò cho người quản lý và khách hàng vào bảng UserRole
INSERT INTO UserRole (UserID, RoleID)
VALUES
    (0, 0),  -- Người quản lý 1 (RoleID = 0)
    (1, 0),  -- Người quản lý 2 (RoleID = 0)
    (2, 1),  -- Khách hàng 1 (RoleID = 1)
    (3, 1);  -- Khách hàng 2 (RoleID = 1)
INSERT INTO Cart (UserID, ProductID, Quantity, CreatedAt)
VALUES
    (2, 0, 1, CURRENT_TIMESTAMP),
    (2, 1, 1, CURRENT_TIMESTAMP),
    (2, 2, 1, CURRENT_TIMESTAMP),
    (2, 3, 1, CURRENT_TIMESTAMP),
    (2, 4, 1, CURRENT_TIMESTAMP);

INSERT INTO Discounts (DiscountName, DiscountType, DiscountValue, StartDate, EndDate)
VALUES 
(N'Ưu đãi đơn hàng 5%', 'percentage', 5, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 10%', 'percentage', 10, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 15%', 'percentage', 15, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 20%', 'percentage', 20, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 25%', 'percentage', 25, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 30%', 'percentage', 30, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 35%', 'percentage', 35, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 40%', 'percentage', 40, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 45%', 'percentage', 45, '2024-06-01', '2024-12-31'),
(N'Ưu đãi đơn hàng 50%', 'percentage', 50, '2024-06-01', '2024-12-31');
