-- ฐานข้อมูลระบบโหวตสัตว์ป่า
-- Wildlife Voting System Database Schema

-- ตาราง animals - เก็บข้อมูลสัตว์ป่า
CREATE TABLE animals (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    scientific_name VARCHAR(150),
    animal_type ENUM('Mammal', 'Bird', 'Reptile', 'Amphibian') NOT NULL,
    subtype VARCHAR(50),
    description TEXT,
    habitat VARCHAR(255),
    conservation_status VARCHAR(50),
    image_url VARCHAR(500),
    sound VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ตาราง votes - เก็บคะแนนโหวต
CREATE TABLE votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    animal_id INT NOT NULL,
    voter_ip VARCHAR(45),
    vote_date DATE NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE,
    INDEX idx_animal_votes (animal_id),
    INDEX idx_vote_date (vote_date)
);

-- ตาราง users (Optional - สำหรับระบบ login)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_admin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert ข้อมูลสัตว์ป่าตัวอย่าง

-- สัตว์เลี้ยงลูกด้วยนม (Mammals)
INSERT INTO animals (name, scientific_name, animal_type, subtype, description, habitat, conservation_status, image_url, sound) VALUES
('เสือโคร่ง', 'Panthera tigris', 'Mammal', 'Tiger', 'เสือที่มีขนาดใหญ่ที่สุดในโลก มีลายสีส้มดำที่สวยงาม เป็นสัตว์กินเนื้อขนาดใหญ่', 'ป่าดงดิบ ป่าเบญจพรรณ', 'ใกล้สูญพันธุ์ (EN)', 'https://images.unsplash.com/photo-1561731216-c3a4d99437d5?w=400', 'Roar!'),
('ช้างเอเชีย', 'Elephas maximus', 'Mammal', 'Elephant', 'สัตว์บกที่ใหญ่ที่สุดในเอเชีย มีความฉลาดสูง สามารถใช้งวงจับของได้', 'ป่าดิบแล้ง ป่าเต็งรัง', 'ใกล้สูญพันธุ์ (EN)', 'https://images.unsplash.com/photo-1564760055775-d63b17a55c44?w=400', 'Trumpet!'),
('หมีหมา', 'Helarctos malayanus', 'Mammal', 'Bear', 'หมีที่มีขนาดเล็กที่สุด มีจุดเด่นที่อกมีรูปตัว V สีเหลือง ชอบกินผลไม้และน้ำผึ้ง', 'ป่าดงดิบเขตร้อน', 'เสี่ยงต่อการสูญพันธุ์ (VU)', 'https://images.unsplash.com/photo-1589656966895-2f33e7653819?w=400', 'Growl'),
('เก้ง', 'Muntiacus muntjak', 'Mammal', 'Deer', 'กวางขนาดเล็ก มีเขาสั้น ชอบอาศัยในป่าเขา ออกหากินในเวลากลางคืน', 'ป่าเขตร้อนทั่วไป', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1551969014-7d2c4cddf0b6?w=400', 'Bark'),
('กระรอกบิน', 'Petaurista petaurista', 'Mammal', 'FlyingSquirrel', 'กระรอกขนาดใหญ่ที่สามารถโผบินได้ระหว่างต้นไม้ด้วยเยื่อบินที่แขนและขา', 'ป่าเต็งรัง ป่าดิบเขา', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1603403178099-2a1e3c4744e5?w=400', 'Squeak'),

-- นก (Birds)
('นกแก้วโม่ง', 'Psittacula alexandri', 'Bird', 'Parrot', 'นกแก้วสีเขียวสดใส มีศีรษะสีชมพูอมม่วง สามารถเลียนเสียงคนพูดได้', 'ป่าไม้ผลัดใบ สวนป่า', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1552728089-57bdde30beb3?w=400', 'Squawk squawk'),
('เหยี่ยว', 'Spilornis cheela', 'Bird', 'Eagle', 'นกล่าเหยื่อขนาดใหญ่ มีความสามารถในการมองเห็นและบินสูง ล่าเหยื่อได้แม่นยำ', 'ป่าเขา ป่าดิบชื้น', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1611689037241-d8dfe4280f2e?w=400', 'Screech!'),
('นกกระเรียน', 'Grus antigone', 'Bird', 'Crane', 'นกขนาดใหญ่ที่สวยงาม มีสีเทาและแดง มักอาศัยเป็นคู่ผัวเมีย มีความจงรักภักดี', 'ทุ่งนา ป่าชายเลน', 'เสี่ยงต่อการสูญพันธุ์ (VU)', 'https://images.unsplash.com/photo-1551769901-3099dc7f7d7b?w=400', 'Kur-r-r-r-oo'),
('นกเงือก', 'Buceros bicornis', 'Bird', 'Hornbill', 'นกขนาดใหญ่ที่มีปากใหญ่สีเหลืองและส่วนยื่นบนปาก เป็นนกคู่ครองที่ซื่อสัตย์', 'ป่าดงดิบ ป่าเบญจพรรณ', 'เสี่ยงต่อการสูญพันธุ์ (VU)', 'https://images.unsplash.com/photo-1598968946657-5e95ea5e6934?w=400', 'Tok tok tok'),

-- สัตว์เลื้อยคลาน (Reptiles)
('งูเหลือม', 'Python reticulatus', 'Reptile', 'Python', 'งูขนาดใหญ่ที่สุดในโลก ไม่มีพิษ ใช้การรัดเหยื่อจนหมดสติ', 'ป่าดิบแล้ง ป่าชายเลน', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1531386450450-969f935bd522?w=400', 'Hiss'),
('ตะพาบน้ำ', 'Crocodylus siamensis', 'Reptile', 'Crocodile', 'จระเข้ขนาดกลาง มีจมูกกว้าง อาศัยในแม่น้ำและทะเลสาบ เป็นสัตว์ที่หายากมาก', 'แม่น้ำ ทะเลสาบ บึง', 'สูญพันธุ์ขั้นวิกฤต (CR)', 'https://images.unsplash.com/photo-1549098549-f15f2422a152?w=400', 'Snap!'),
('เต่าตะพาบ', 'Cuora amboinensis', 'Reptile', 'Turtle', 'เต่าน้ำจืดขนาดกลาง มีกระดองสีน้ำตาลเข้ม สามารถปิดกระดองได้สนิท', 'บึง หนอง ลำห้วย', 'เสี่ยงต่อการสูญพันธุ์ (VU)', 'https://images.unsplash.com/photo-1508013861127-514c8b9cc63e?w=400', 'Silent'),
('ตุ๊กแกจอมทัพ', 'Varanus salvator', 'Reptile', 'Monitor', 'จิ้งเหลนขนาดใหญ่ ว่ายน้ำเก่ง กินเนื้อ สามารถปีนต้นไม้ได้', 'ป่าดงดิบ ป่าชายเลน', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1582407947304-fd86f028f716?w=400', 'Hiss hiss'),

-- สัตว์สะเทินน้ำสะเทินบก (Amphibians)
('กบเขียว', 'Rana erythraea', 'Amphibian', 'Frog', 'กบขนาดกลางสีเขียวสดใส มักพบตามทุ่งนาและบึง มีเสียงร้องดังในช่วงฤดูฝน', 'ทุ่งนา บึง', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1580268053897-234d3e71b83b?w=400', 'Ribbit ribbit'),
('คางคกตัวเขียว', 'Duttaphrynus melanostictus', 'Amphibian', 'Toad', 'คางคกขนาดกลางถึงใหญ่ ผิวหนังหยาบ มีต่อมพิษที่หลัง สามารถปรับตัวได้ดี', 'บริเวณบ้านเรือน สวน', 'ไม่น่ากังวล (LC)', 'https://images.unsplash.com/photo-1564349683136-77e08dba1ef7?w=400', 'Croak croak'),
('ซาลาแมนเดอร์', 'Tylototriton verrucosus', 'Amphibian', 'Salamander', 'สัตว์สะเทินน้ำสะเทินบกหางยาว ผิวหนังเป็นปุ่ม มีพิษ อาศัยในป่าภูเขา', 'ป่าภูเขา ลำธาร', 'ใกล้สูญพันธุ์ (EN)', 'https://images.unsplash.com/photo-1585421514738-01798e348b17?w=400', 'Silent');

-- สร้าง Admin User ตัวอย่าง (password: admin123)
INSERT INTO users (username, email, password_hash, is_admin) VALUES
('admin', 'admin@wildlife.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', TRUE);
