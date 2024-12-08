CREATE database thucung default CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE user 'thucung_user'@'%.%.%.%' identified by '123456';
GRANT ALL PRIVILEGES ON thucung.* TO 'thucung_user'@'%.%.%.%';

use thucung;

CREATE TABLE Pet (
    id INT PRIMARY KEY AUTO_INCREMENT,
    petCode VARCHAR(50) NOT NULL, -- Mã thú cưng
    petName VARCHAR(100) NOT NULL, -- Tên thú cưng
    age INT NOT NULL, -- Số tuổi
    careTask VARCHAR(255), -- Công việc chăm sóc (tắm, cạo lông, v.v.)
    notes TEXT -- Ghi chú
);

INSERT INTO Pet (petCode, petName, age, careTask, notes) VALUES
('P001', 'Lucky', 2, 'Tắm, cạo lông', 'Thú cưng ngoan, không hung dữ'),
('P002', 'Milo', 3, 'Tiêm vaccine, khám sức khỏe', 'Cần chăm sóc đặc biệt'),
('P003', 'Snowy', 1, 'Tỉa móng, cạo lông', 'Rất thân thiện');

