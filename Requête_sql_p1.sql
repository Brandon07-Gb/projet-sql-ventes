-- Création de la base de données

CREATE DATABASE sql_project_p1;


-- Création des tables

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    products_id SERIAL PRIMARY KEY,
    Products_name VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE orders (
    orders_id SERIAL PRIMARY KEY,
    customers_id INT REFERENCES customers(Customers_id),
    products_id INT REFERENCES products(products_id),
    order_date DATE NOT NULL
);

CREATE TABLE payments (
    payments_id SERIAL PRIMARY KEY,
    orders_id INT REFERENCES orders(orders_id),
    amount DECIMAL(10, 2) NOT NULL,
    payments_methodes VARCHAR(50) NOT NULL
);

-- Ajout des données aux tables

INSERT INTO customers (customers_name, email, city)
VALUES 
('Amoin alice', '123@gmail.com', 'Abidjan'),
('jean kouadio', 'jeankouadio@gyahoo.fr','Bouaké'),
('fatou camara', 'camara07@gmail.com', 'Yamoussoukro'),
('eric bamba','ericbamgmail.com', 'San-pedro'),
('aminata traoré', 'Tra_aminata@gmail.com', 'Korhogo'),
('gue robert', 'robertjoieyahoo.com', 'Man'),
('zagba cédric', 'Czagba@gmail.com', 'Abidjan'),
('moayé aline', 'aline@0gmail.com', 'Dimbokro'),
('touré koffi', 'ktour99@gmail.com', 'Tanda'),
('Gbali zady', 'zadygba@gmail.com', 'Gagnoa');


INSERT INTO products (products_name, category, price)
VALUES
('Sac à main', 'Accessoires', 50.00),
('Pantalon', 'Vêtements', 25.00),
('Colier', 'Accessoires', 8.00),
('Ordinateur', 'Electronique', 150.00),
('Téléphone', 'Electronique', 99.00),
('Veste', 'Vêtements', 77.00),
('Bracelet', 'Accessoires', 7.00),
('Robe', 'Vêtements', 5.00),
('Ecouteurs', 'Electronique', 1.00),
('Boubou', 'Vêtements', 45.00);


INSERT INTO orders (customers_id, products_id, orders_date)
VALUES 
(1,1,'2024-12-2'),
(2,2,'2024-12-6'),
(3,3,'2024-12-7'),
(4,4,'2024-12-10'),
(5,5,'2024-12-11'),
(6,6,'2024-12-13'),
(7,7,'2024-12-15'),
(8,8,'2024-12-17'),
(9,9,'2024-12-20'),
(10,10,'2024-12-22');


INSERT INTO payments (orders_id, amount, payments_methodes)
VALUES
(1, 50.00, 'Carte Bancaire'),
(2, 25.00, 'Mobile money'),
(3, 8.00, 'Espèces'),
(4, 150.00,'Carte Bancaire'),
(5, 99.00, 'Carte Bancaire'),
(6, 77.00, 'Mobile money'),
(7, 7.00, 'Espèces'),
(8, 5.00, 'Espèces'),
(9, 1.00, 'Mobile money'),
(10, 45, 'Carte Bancaire');


-- Étape 1 : Analyse exploratoire des données (EDA)

-- Q1 : nombre total de clients

SELECT COUNT(*) AS TotalClients FROM customers;

-- Q2: nombre total de produits

SELECT COUNT(*) AS TotalProducts FROM products;

-- Q3: nombre total de commandes

SELECT COUNT(*) AS TotalOrders FROM orders;

-- Q4: Chiffres d'affaires total

SELECT SUM(Amount) AS TotalRevenue FROM payments;

-- Q5: Répartition des paiements par méthode

SELECT payment_methodes, COUNT(*) AS PaymentCount
FROM payments
GROUP BY payment_methodes
ORDER BY PaymentCount DESC;


-- Étape 2 : Requêtes commerciales spécifiques

-- Q1: Clients ayant dépensé le plus

SELECT c.customer_name, SUM(p.amount) AS TotalSpent
FROM customers c
JOIN orders o ON c.customers_id = o.customers_id
JOIN payments p ON o.orders_id = p.orders_id
GROUP BY c.customer_name
ORDER BY TotalSpent DESC;

-- Q2: Produits les plus vendus par catégorie

SELECT p.category AS categorie, p.products_name AS produit, 
	SUM(py.amount) AS total_revenu
FROM products p
JOIN orders o ON p.products_id = o.products_id
JOIN payments py ON o.orders_id = py.orders_id
GROUP BY p.category, p.products_name
ORDER BY p.category, total_revenu DESC;


-- Q3:Top 3 des villes avec le plus de commandes

SELECT c.city, COUNT(o.orders_id) AS OrderCount
FROM customers c
JOIN orders o ON c.customers_id = o.customers_id
GROUP BY c.city
ORDER BY OrderCount DESC;

-- Q4: Chiffre d’affaires par méthode de paiement

SELECT payments_methodes, SUM(amount) AS TotalRevenue
FROM payments
GROUP BY payments_methodes
ORDER BY TotalRevenue DESC;

