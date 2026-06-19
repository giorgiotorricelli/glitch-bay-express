-- 1. Creazione del Database (se non esiste già)
CREATE DATABASE IF NOT EXISTS `glitch_bay` 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- 2. Selezione del database appena creato
USE `glitch_bay`;

-- 3. Creazione delle tabelle
CREATE TABLE `products`(
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `slug` VARCHAR(104) NOT NULL,
    `img` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `discount` TINYINT UNSIGNED NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
ALTER TABLE `products` ADD UNIQUE `products_slug_unique`(`slug`);

CREATE TABLE `categories`(
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(80) NOT NULL,
    `description` TEXT NOT NULL
);
ALTER TABLE `categories` ADD UNIQUE `categories_name_unique`(`name`);

CREATE TABLE `product_category`(
    `id_product` MEDIUMINT UNSIGNED NOT NULL,
    `id_category` MEDIUMINT UNSIGNED NOT NULL,
    PRIMARY KEY(`id_product`, `id_category`)
);

CREATE TABLE `invoices`(
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `total_amount` DECIMAL(6, 2) NOT NULL,
    `status` ENUM('paid', 'unpaid') NOT NULL DEFAULT 'unpaid',
    `shipping_cost` DECIMAL(4, 2) NOT NULL DEFAULT 9.99,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `tracking_number` CHAR(15) NOT NULL,
    `payment_method` ENUM('stripe', 'paypal', 'crypto') NOT NULL
);

CREATE TABLE `users`(
    `id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `id_invoice` MEDIUMINT UNSIGNED NOT NULL,
    `name` VARCHAR(255) NULL,
    `surname` VARCHAR(255) NULL,
    `mail` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(255) NOT NULL
);
ALTER TABLE `users` ADD UNIQUE `users_id_invoice_unique`(`id_invoice`);

CREATE TABLE `product_invoice`(
    `id_product` MEDIUMINT UNSIGNED NOT NULL,
    `id_invoice` MEDIUMINT UNSIGNED NOT NULL,
    `paid` DECIMAL(5, 2) NOT NULL,
    `qty` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY(`id_product`, `id_invoice`)
);

-- 4. Definizione dei Vincoli d'integrità (Foreign Keys)
ALTER TABLE `product_category` 
    ADD CONSTRAINT `product_category_id_category_foreign` FOREIGN KEY(`id_category`) REFERENCES `categories`(`id`);

ALTER TABLE `product_invoice` 
    ADD CONSTRAINT `product_invoice_id_invoice_foreign` FOREIGN KEY(`id_invoice`) REFERENCES `invoices`(`id`);

ALTER TABLE `product_category` 
    ADD CONSTRAINT `product_category_id_product_foreign` FOREIGN KEY(`id_product`) REFERENCES `products`(`id`);

ALTER TABLE `product_invoice` 
    ADD CONSTRAINT `product_invoice_id_product_foreign` FOREIGN KEY(`id_product`) REFERENCES `products`(`id`);

ALTER TABLE `users` 
    ADD CONSTRAINT `users_id_invoice_foreign` FOREIGN KEY(`id_invoice`) REFERENCES `invoices`(`id`);