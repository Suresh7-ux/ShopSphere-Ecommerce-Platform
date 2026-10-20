CREATE DATABASE IF NOT EXISTS shopsphere CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE shopsphere;
CREATE TABLE users(user_id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,email VARCHAR(150) UNIQUE NOT NULL,
 password VARCHAR(255) NOT NULL,mobile VARCHAR(20),role ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',
 status TINYINT DEFAULT 1,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE categories(category_id INT AUTO_INCREMENT PRIMARY KEY,name VARCHAR(100) NOT NULL,description VARCHAR(255),status TINYINT DEFAULT 1);
CREATE TABLE products(product_id INT AUTO_INCREMENT PRIMARY KEY,category_id INT,name VARCHAR(150) NOT NULL,brand VARCHAR(100),
 description TEXT,price DECIMAL(10,2) NOT NULL,discount DECIMAL(5,2) DEFAULT 0,stock INT DEFAULT 0,
 image_url VARCHAR(500),status TINYINT DEFAULT 1,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(category_id) REFERENCES categories(category_id));
CREATE TABLE cart(cart_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,product_id INT,quantity INT NOT NULL,
 UNIQUE KEY uq_cart(user_id,product_id),FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,
 FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE);
CREATE TABLE wishlist(wishlist_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,product_id INT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 UNIQUE KEY uq_wish(user_id,product_id),FOREIGN KEY(user_id) REFERENCES users(user_id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(product_id) ON DELETE CASCADE);
CREATE TABLE addresses(address_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,address_line VARCHAR(255),city VARCHAR(80),state VARCHAR(80),pincode VARCHAR(10),address_type VARCHAR(30));
CREATE TABLE orders(order_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,address_id INT,total_amount DECIMAL(10,2),discount DECIMAL(10,2) DEFAULT 0,
 payment_method VARCHAR(30),payment_status VARCHAR(30),order_status VARCHAR(30) DEFAULT 'PLACED',created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(user_id),FOREIGN KEY(address_id) REFERENCES addresses(address_id));
CREATE TABLE order_items(order_item_id INT AUTO_INCREMENT PRIMARY KEY,order_id INT,product_id INT,quantity INT,price DECIMAL(10,2),
 FOREIGN KEY(order_id) REFERENCES orders(order_id) ON DELETE CASCADE,FOREIGN KEY(product_id) REFERENCES products(product_id));
CREATE TABLE payments(payment_id INT AUTO_INCREMENT PRIMARY KEY,order_id INT,payment_method VARCHAR(30),transaction_reference VARCHAR(100),
 amount DECIMAL(10,2),payment_status VARCHAR(30),created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE reviews(review_id INT AUTO_INCREMENT PRIMARY KEY,user_id INT,product_id INT,rating INT,review_text TEXT,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY(user_id) REFERENCES users(user_id),FOREIGN KEY(product_id) REFERENCES products(product_id));
CREATE TABLE coupons(coupon_id INT AUTO_INCREMENT PRIMARY KEY,code VARCHAR(40) UNIQUE,discount_type VARCHAR(20),discount_value DECIMAL(10,2),
 minimum_order DECIMAL(10,2) DEFAULT 0,maximum_discount DECIMAL(10,2),expiry_date DATE,status TINYINT DEFAULT 1);
CREATE TABLE coupon_usage(usage_id INT AUTO_INCREMENT PRIMARY KEY,coupon_id INT,user_id INT,order_id INT,used_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT INTO categories(name,description) VALUES
('Electronics','Smart devices and accessories'),('Fashion','Clothing and lifestyle'),('Gaming','Gaming products'),('Books','Books and learning');

INSERT INTO products(category_id,name,brand,description,price,discount,stock,image_url) VALUES
(1,'Wireless Headphones','SoundMax','Comfortable Bluetooth headphones with deep bass.',2999,15,25,'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=800&q=80'),
(1,'Smart Watch Pro','TimeX','Fitness tracking and notifications.',4999,20,18,'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=800&q=80'),
(2,'Classic Sneakers','UrbanStep','Everyday casual sneakers.',3499,10,30,'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=800&q=80'),
(3,'Mechanical Keyboard','KeyForge','RGB mechanical keyboard for gaming and coding.',4499,12,12,'https://images.unsplash.com/photo-1587829741301-dc798b83add3?auto=format&fit=crop&w=800&q=80'),
(4,'Java Programming Book','TechPress','Advanced Java reference for students.',899,5,50,'https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=800&q=80');

-- Additional catalogue: 30 more products (35 total). Product cards use a shared image aspect ratio.
INSERT INTO products(category_id,name,brand,description,price,discount,stock,image_url) VALUES
(1,'Bluetooth Speaker','AudioPeak','Portable wireless speaker with rich sound and long battery life.',1899,12,24,'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?auto=format&fit=crop&w=900&q=85'),
(1,'Noise Cancelling Earbuds','SoundMax','Compact wireless earbuds with clear calls and charging case.',2499,18,20,'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?auto=format&fit=crop&w=900&q=85'),
(1,'Mirrorless Camera','PixelPro','Lightweight digital camera for travel and creative photography.',45999,8,6,'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=900&q=85'),
(1,'Laptop Backpack','CarryCraft','Padded laptop backpack with organised storage pockets.',1599,10,30,'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'),
(1,'USB-C Hub','ConnectPro','Multiport USB-C hub for everyday laptop connectivity.',1299,5,35,'https://images.unsplash.com/photo-1625842268584-8f3296236761?auto=format&fit=crop&w=900&q=85'),
(1,'Power Bank 20000mAh','VoltGo','High-capacity portable charging for compatible devices.',1799,15,28,'https://images.unsplash.com/photo-1609592424848-1b4b6c6e9e23?auto=format&fit=crop&w=900&q=85'),
(1,'Wireless Mouse','ClickPro','Ergonomic wireless mouse for study, work and travel.',799,10,40,'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?auto=format&fit=crop&w=900&q=85'),
(1,'27-inch Monitor','ViewMax','Full-size monitor for productivity, learning and entertainment.',14999,7,10,'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=900&q=85'),
(1,'Tablet 10-inch','TabSphere','Versatile tablet for reading, streaming and everyday tasks.',12999,9,12,'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?auto=format&fit=crop&w=900&q=85'),
(2,'Everyday Hoodie','NorthThread','Soft regular-fit hoodie for relaxed everyday wear.',1499,15,22,'https://images.unsplash.com/photo-1556821840-3a63f95609a7?auto=format&fit=crop&w=900&q=85'),
(2,'Classic Denim Jacket','UrbanStep','Timeless denim layer designed for casual outfits.',2299,10,16,'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=900&q=85'),
(2,'Minimal Backpack','CarryCraft','Clean everyday backpack with a roomy main compartment.',1199,8,25,'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=900&q=85'),
(2,'Running Shoes','UrbanStep','Lightweight trainers for daily walks and running.',2799,12,18,'https://images.unsplash.com/photo-1460353581641-37bADDab0fa2?auto=format&fit=crop&w=900&q=85'),
(2,'Classic Sunglasses','SunLine','Versatile sunglasses with a timeless everyday frame.',999,5,30,'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=900&q=85'),
(2,'Analog Wristwatch','TimeX','Minimal analog watch suitable for casual and formal looks.',2199,14,14,'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=900&q=85'),
(2,'Everyday T-Shirt','NorthThread','Breathable cotton-blend tee with a comfortable fit.',599,0,50,'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=85'),
(2,'Travel Duffel Bag','CarryCraft','Spacious weekender bag for gym sessions and short trips.',1899,10,17,'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=85'),
(3,'Gaming Headset','GameForge','Over-ear headset with cushioned ear cups and clear audio.',2599,13,15,'https://images.unsplash.com/photo-1599669454699-248893623440?auto=format&fit=crop&w=900&q=85'),
(3,'Wireless Game Controller','GameForge','Comfortable controller for compatible gaming systems and PC.',2199,8,14,'https://images.unsplash.com/photo-1600080972464-8e5f35f63d08?auto=format&fit=crop&w=900&q=85'),
(3,'Gaming Mouse Pad','KeyForge','Smooth desk mat with a non-slip base for gaming setups.',699,5,32,'https://images.unsplash.com/photo-1615663245857-ac93bb7c39e7?auto=format&fit=crop&w=900&q=85'),
(3,'RGB Gaming Mouse','KeyForge','Responsive gaming mouse with programmable lighting.',1499,10,20,'https://images.unsplash.com/photo-1613141411244-0e4ac259d217?auto=format&fit=crop&w=900&q=85'),
(3,'Gaming Chair','GameForge','Supportive adjustable chair for long gaming or study sessions.',8999,7,5,'https://images.unsplash.com/photo-1598550476439-6847785fcea6?auto=format&fit=crop&w=900&q=85'),
(3,'Streaming Microphone','StreamLab','USB microphone for streaming, meetings and voice recording.',3299,9,9,'https://images.unsplash.com/photo-1590602847861-f357a9332bbc?auto=format&fit=crop&w=900&q=85'),
(3,'Laptop Cooling Stand','CoolDesk','Raised laptop stand designed to improve desk comfort and airflow.',1099,6,19,'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?auto=format&fit=crop&w=900&q=85'),
(3,'Gaming Desk Light','GlowDesk','Ambient desk lighting for a more immersive gaming setup.',899,5,21,'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?auto=format&fit=crop&w=900&q=85'),
(4,'Clean Code','Prentice Hall','A practical software craftsmanship book for developers.',799,10,25,'https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=900&q=85'),
(4,'Data Structures Handbook','TechPress','Study-friendly guide to core data structures and algorithms.',649,5,30,'https://images.unsplash.com/photo-1519682337058-a94d519337bc?auto=format&fit=crop&w=900&q=85'),
(4,'Database Systems','LearnWell','Introduction to relational databases, SQL and data modelling.',899,8,18,'https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&w=900&q=85'),
(4,'Design Patterns','CodeShelf','Reusable object-oriented design solutions explained with examples.',999,10,15,'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=crop&w=900&q=85'),
(4,'Python Projects for Beginners','LearnWell','Hands-on Python exercises for new programmers and students.',549,0,35,'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=crop&w=900&q=85');
