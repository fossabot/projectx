DROP DATABASE IF EXISTS `db_shop_fashionExperts`;
CREATE DATABASE `db_shop_fashionExperts`;
USE `db_shop_fashionExperts`;

CREATE TABLE `t_user` (
	`id_user` INT NOT NULL AUTO_INCREMENT,
	`firstName` TEXT NOT NULL,
	`lastName` TEXT NOT NULL,
	`id_role` INT NOT NULL,
	`age` INT NOT NULL,
	`id_shippingAdress` INT NOT NULL,
	`id_billingAdress` INT NOT NULL,
	PRIMARY KEY (`id_user`)
);

CREATE TABLE `t_product` (
	`id_product` INT NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	`id_brand` INT NOT NULL,
	`id_inventory` INT NOT NULL,
	`price` FLOAT NOT NULL,
	PRIMARY KEY (`id_product`)
);

CREATE TABLE `t_categories` (
	`id_category` INT NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	`id_product` INT NOT NULL,
	PRIMARY KEY (`id_category`)
);

CREATE TABLE `t_brands` (
	`id_brand` INT NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	PRIMARY KEY (`id_brand`)
);

CREATE TABLE `t_paymentMethods` (
	`id_paymentMethods` INT NOT NULL,
	`name` TEXT NOT NULL,
	`apiKey` TEXT NOT NULL,
	PRIMARY KEY (`id_paymentMethods`)
);

CREATE TABLE `t_orders` (
	`id_order` INT NOT NULL AUTO_INCREMENT,
	`id_user` INT NOT NULL,
	`id_orderDetail` INT NOT NULL,
	PRIMARY KEY (`id_order`)
);

CREATE TABLE `t_shippingAdresses` (
	`id_shippingAdress` INT NOT NULL AUTO_INCREMENT,
	`street` TEXT NOT NULL,
	`number` TEXT NOT NULL,
	`postalCode` TEXT NOT NULL,
	`city` TEXT NOT NULL,
	`country` TEXT NOT NULL,
	PRIMARY KEY (`id_shippingAdress`)
);

CREATE TABLE `t_tags` (
	`id_tag` INT NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	`priority` INT NOT NULL,
	`id_product` INT NOT NULL,
	PRIMARY KEY (`id_tag`)
);

CREATE TABLE `t_billingAdress` (
	`id_billingAdress` INT NOT NULL AUTO_INCREMENT,
	`street` TEXT NOT NULL,
	`number` TEXT NOT NULL,
	`postalCode` TEXT NOT NULL,
	`city` TEXT NOT NULL,
	`country` TEXT NOT NULL,
	PRIMARY KEY (`id_billingAdress`)
);

CREATE TABLE `t_productDetail` (
	`id_productDetail` INT NOT NULL AUTO_INCREMENT,
	`id_product` INT NOT NULL,
	`quantity` INT NOT NULL,
	`quantityMin` INT NOT NULL,
	`quantityMax` INT NOT NULL,
	`size` VARCHAR(255) NOT NULL,
	`color` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id_productDetail`)
);

CREATE TABLE `t_basket` (
	`id_basket` INT NOT NULL AUTO_INCREMENT,
	`id_basketDetail` INT NOT NULL,
	`id_user` INT NOT NULL,
	PRIMARY KEY (`id_basket`)
);

CREATE TABLE `t_invoice` (
	`id_invoice` INT NOT NULL AUTO_INCREMENT,
	`id_basketDetail` INT NOT NULL,
	`id_voucher` INT NOT NULL,
	`id_user` INT NOT NULL,
	`id_payment` INT NOT NULL,
	`date` DATE NOT NULL,
	PRIMARY KEY (`id_invoice`)
);

CREATE TABLE `t_ordeDetail` (
	`id_orderDetail` INT NOT NULL AUTO_INCREMENT,
	`id_invoice` INT NOT NULL,
	`id_user` INT NOT NULL,
	`id_basketDetail` INT NOT NULL,
	PRIMARY KEY (`id_orderDetail`)
);

CREATE TABLE `t_vouchers` (
	`id_voucher` INT NOT NULL AUTO_INCREMENT,
	`name` TEXT NOT NULL,
	`discount` INT NOT NULL,
	`minTotalAmount` INT NOT NULL,
	PRIMARY KEY (`id_voucher`)
);

CREATE TABLE `t_basketDetail` (
	`id_basketDetail` INT NOT NULL AUTO_INCREMENT,
	`id_productDetail` INT NOT NULL,
	`totalAmount` INT NOT NULL,
	PRIMARY KEY (`id_basketDetail`)
);

CREATE TABLE `t_payment` (
	`id_payment` INT NOT NULL AUTO_INCREMENT,
	`id_paymentMethods` INT NOT NULL,
	`id_user` INT NOT NULL,
	`name` VARCHAR(255) NOT NULL,
	`IBAN` VARCHAR(255) NOT NULL,
	`BIC` VARCHAR(255) NOT NULL,
	`SESSION_KEY` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`id_payment`)
);

CREATE TABLE `t_role` (
	`id_role` INT NOT NULL,
	`name` TEXT NOT NULL,
	`editProduct` BOOLEAN NOT NULL,
	`editOrder` BOOLEAN NOT NULL,
	`editUser` BOOLEAN NOT NULL,
	`editVoucher` BOOLEAN NOT NULL,
	`editCategories` BOOLEAN NOT NULL,
	`editBrands` BOOLEAN NOT NULL,
	`editTags` BOOLEAN NOT NULL,
	`editAdress` BOOLEAN NOT NULL,
	PRIMARY KEY (`id_role`)
);

ALTER TABLE `t_user` ADD CONSTRAINT `t_user_fk0` FOREIGN KEY (`id_role`) REFERENCES `t_role`(`id_role`);

ALTER TABLE `t_user` ADD CONSTRAINT `t_user_fk1` FOREIGN KEY (`id_shippingAdress`) REFERENCES `t_shippingAdresses`(`id_shippingAdress`);

ALTER TABLE `t_user` ADD CONSTRAINT `t_user_fk2` FOREIGN KEY (`id_billingAdress`) REFERENCES `t_billingAdress`(`id_billingAdress`);

ALTER TABLE `t_product` ADD CONSTRAINT `t_product_fk0` FOREIGN KEY (`id_brand`) REFERENCES `t_brands`(`id_brand`);

ALTER TABLE `t_categories` ADD CONSTRAINT `t_categories_fk0` FOREIGN KEY (`id_product`) REFERENCES `t_product`(`id_product`);

ALTER TABLE `t_orders` ADD CONSTRAINT `t_orders_fk0` FOREIGN KEY (`id_user`) REFERENCES `t_user`(`id_user`);

ALTER TABLE `t_orders` ADD CONSTRAINT `t_orders_fk1` FOREIGN KEY (`id_orderDetail`) REFERENCES `t_ordeDetail`(`id_orderDetail`);

ALTER TABLE `t_tags` ADD CONSTRAINT `t_tags_fk0` FOREIGN KEY (`id_product`) REFERENCES `t_product`(`id_product`);

ALTER TABLE `t_productDetail` ADD CONSTRAINT `t_productDetail_fk0` FOREIGN KEY (`id_product`) REFERENCES `t_product`(`id_product`);

ALTER TABLE `t_basket` ADD CONSTRAINT `t_basket_fk0` FOREIGN KEY (`id_basketDetail`) REFERENCES `t_basketDetail`(`id_basketDetail`);

ALTER TABLE `t_basket` ADD CONSTRAINT `t_basket_fk1` FOREIGN KEY (`id_user`) REFERENCES `t_user`(`id_user`);

ALTER TABLE `t_invoice` ADD CONSTRAINT `t_invoice_fk0` FOREIGN KEY (`id_basketDetail`) REFERENCES `t_basketDetail`(`id_basketDetail`);

ALTER TABLE `t_invoice` ADD CONSTRAINT `t_invoice_fk1` FOREIGN KEY (`id_voucher`) REFERENCES `t_vouchers`(`id_voucher`);

ALTER TABLE `t_invoice` ADD CONSTRAINT `t_invoice_fk2` FOREIGN KEY (`id_user`) REFERENCES `t_user`(`id_user`);

ALTER TABLE `t_invoice` ADD CONSTRAINT `t_invoice_fk3` FOREIGN KEY (`id_payment`) REFERENCES `t_payment`(`id_payment`);

ALTER TABLE `t_ordeDetail` ADD CONSTRAINT `t_ordeDetail_fk0` FOREIGN KEY (`id_invoice`) REFERENCES `t_invoice`(`id_invoice`);

ALTER TABLE `t_ordeDetail` ADD CONSTRAINT `t_ordeDetail_fk1` FOREIGN KEY (`id_user`) REFERENCES `t_user`(`id_user`);

ALTER TABLE `t_ordeDetail` ADD CONSTRAINT `t_ordeDetail_fk2` FOREIGN KEY (`id_basketDetail`) REFERENCES `t_basketDetail`(`id_basketDetail`);

ALTER TABLE `t_basketDetail` ADD CONSTRAINT `t_basketDetail_fk0` FOREIGN KEY (`id_productDetail`) REFERENCES `t_productDetail`(`id_productDetail`);

ALTER TABLE `t_payment` ADD CONSTRAINT `t_payment_fk0` FOREIGN KEY (`id_paymentMethods`) REFERENCES `t_paymentMethods`(`id_paymentMethods`);

ALTER TABLE `t_payment` ADD CONSTRAINT `t_payment_fk1` FOREIGN KEY (`id_user`) REFERENCES `t_user`(`id_user`);
