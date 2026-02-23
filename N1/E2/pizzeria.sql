-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`stores` (
  `id_store` INT(11) NOT NULL AUTO_INCREMENT,
  `id_order` INT(11) NOT NULL,
  `id_address` INT(11) NOT NULL,
  `store_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id_store`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`addresses` (
  `id_address` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(150) NOT NULL,
  `zip_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NULL DEFAULT NULL,
  `telephone` VARCHAR(15) NULL DEFAULT NULL,
  `stores_id_store` INT(11) NOT NULL,
  PRIMARY KEY (`id_address`),
  INDEX `fk_addresses_stores1_idx` (`stores_id_store` ASC) ,
  CONSTRAINT `fk_addresses_stores1`
    FOREIGN KEY (`stores_id_store`)
    REFERENCES `pizzeria`.`stores` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `surname` VARCHAR(100) NOT NULL,
  `id_address` INT(11) NOT NULL,
  `addresses_id_address` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_client`),
  INDEX `fk_client_addresses1_idx` (`addresses_id_address` ASC) ,
  CONSTRAINT `fk_client_addresses1`
    FOREIGN KEY (`addresses_id_address`)
    REFERENCES `pizzeria`.`addresses` (`id_address`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `id_employee` INT(11) NOT NULL AUTO_INCREMENT,
  `id_store` INT(11) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `surname` VARCHAR(100) NULL DEFAULT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `telephone` VARCHAR(15) NULL DEFAULT NULL,
  `type_employee` TINYINT(4) NOT NULL,
  `stores_idstore` INT(11) NOT NULL,
  PRIMARY KEY (`id_employee`),
  INDEX `fk_employees_stores1_idx` (`stores_idstore` ASC) ,
  CONSTRAINT `fk_employees_stores1`
    FOREIGN KEY (`stores_idstore`)
    REFERENCES `pizzeria`.`stores` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `id_orders` INT(11) NOT NULL,
  `date_time_order` DATETIME NOT NULL,
  `to_home` TINYINT NOT NULL,
  `total_products` INT(11) NOT NULL,
  `total_price` DECIMAL(10,0) NOT NULL,
  `id_employee` INT(11) NOT NULL,
  `date_time_delivery` DATETIME NOT NULL,
  `employees_id_employee` INT(11) NOT NULL,
  `client_id_client` INT(11) NOT NULL,
  `stores_id_store` INT(11) NOT NULL,
  PRIMARY KEY (`id_orders`),
  INDEX `fk_orders_employees1_idx` (`employees_id_employee` ASC) ,
  INDEX `fk_orders_client1_idx` (`client_id_client` ASC) ,
  INDEX `fk_orders_stores1_idx` (`stores_id_store` ASC) ,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employees_id_employee`)
    REFERENCES `pizzeria`.`employees` (`id_employee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_client1`
    FOREIGN KEY (`client_id_client`)
    REFERENCES `pizzeria`.`client` (`id_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_stores1`
    FOREIGN KEY (`stores_id_store`)
    REFERENCES `pizzeria`.`stores` (`id_store`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categories` (
  `id_pizza_category` INT(11) NOT NULL AUTO_INCREMENT,
  `name_pizza_category` VARCHAR(100) NOT NULL,
  `initial_time` DATE NOT NULL,
  `final_time` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_pizza_category`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `id_product` INT(11) NOT NULL AUTO_INCREMENT,
  `product_type` ENUM('Pizza', 'Hamburguesa', 'Bebida') NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` LONGTEXT NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  `price` DECIMAL(10,0) NOT NULL,
  `pizza_categories_id_pizza_category` INT(11) NULL,
  PRIMARY KEY (`id_product`, `pizza_categories_id_pizza_category`),
  INDEX `fk_products_pizza_categories1_idx` (`pizza_categories_id_pizza_category` ASC) ,
  CONSTRAINT `fk_products_pizza_categories1`
    FOREIGN KEY (`pizza_categories_id_pizza_category`)
    REFERENCES `pizzeria`.`pizza_categories` (`id_pizza_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders_has_products` (
  `orders_id_orders` INT(11) NOT NULL,
  `products_id_product` INT(11) NOT NULL,
  `product_quantity` INT NOT NULL,
  PRIMARY KEY (`orders_id_orders`, `products_id_product`),
  INDEX `fk_orders_has_products_products1_idx` (`products_id_product` ASC) ,
  INDEX `fk_orders_has_products_orders_idx` (`orders_id_orders` ASC) ,
  CONSTRAINT `fk_orders_has_products_orders`
    FOREIGN KEY (`orders_id_orders`)
    REFERENCES `pizzeria`.`orders` (`id_orders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`products_id_product`)
    REFERENCES `pizzeria`.`products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO `pizzeria`.`addresses` (`id_address`, `address`, `zipcode`, `city`, `province`, `telephone`) VALUES ('1', 'Carrer A, num 1, 1º 1ª', '08001', 'Barcelona', 'Barcelona', '123456789');
INSERT INTO `pizzeria`.`addresses` (`id_address`, `address`, `zipcode`, `city`, `province`, `telephone`) VALUES ('2', 'Carrer B, num 2, 1º 1ª', '08002', 'Barcelona', 'Barcelona', '987654321');

INSERT INTO `pizzeria`.`client` (`id_client`, `name`, `surname`, `id_address`) VALUES ('1', 'Client 1', 'Cognom client 1', '1');
INSERT INTO `pizzeria`.`client` (`id_client`, `name`, `surname`, `id_address`) VALUES ('2', 'Client 2', 'Cognom client 2', '2');

INSERT INTO `pizzeria`.`stores` (`id_store`, `id_order`, `id_address`, `store_name`) VALUES ('1', '1', '0', 'Tenda 1');
INSERT INTO `pizzeria`.`stores` (`id_store`, `id_order`, `id_address`, `store_name`) VALUES ('2', '2', '1', 'Tenda 2');

INSERT INTO `pizzeria`.`employees` (`id_employee`, `id_store`, `name`, `surname`, `NIF`, `telephone`, `type_employee`) VALUES ('1', '1', 'Empleat 1', 'Surname 1', '12345678A', '123456789', 'Repartidor');
INSERT INTO `pizzeria`.`employees` (`id_employee`, `id_store`, `name`, `surname`, `NIF`, `telephone`, `type_employee`) VALUES ('2', '1', 'Empleat 2', 'Surname 2', '87654321B', '87654321', 'Cuiner');

INSERT INTO `pizzeria`.`orders` (`id_orders`, `date_time_order`, `to_home`, `total_products`, `total_price`, `id_employee`, `date_time_delivery`) VALUES ('1', '2026-01-01 20:03:30', '1', '4', '20.24', '1', '2026-01-01 20:20:20');
INSERT INTO `pizzeria`.`orders` (`id_orders`, `date_time_order`, `to_home`, `total_products`, `total_price`, `id_employee`, `date_time_delivery`) VALUES ('2', '2026-01-01 20:10:02', '1', '2', '10.00', '1', '2026-01-01 20:40:00');
INSERT INTO `pizzeria`.`orders` (`id_orders`, `date_time_order`, `to_home`, `total_products`, `total_price`, `id_employee`, `date_time_delivery`) VALUES ('3', '2026-01-08 12:58:05', '1', '1', '8,5', '2', '2026-01-08 12:59:59');

INSERT INTO `pizzeria`.`products` (`id_product`, `product_type`, `name`, `description`, `price`) VALUES ('1', 'Pizza', 'Barbacoa petita', 'Molta carn', '12.5');
INSERT INTO `pizzeria`.`products` (`id_product`, `product_type`, `name`, `description`, `price`) VALUES ('2', 'Pizza', 'Barbacoa gran', 'Molt mes carn', '20.3');
INSERT INTO `pizzeria`.`products` (`id_product`, `product_type`, `name`, `description`, `price`) VALUES ('3', 'Hamburguesa', 'Clasica', 'Brutal', '13.5');

INSERT INTO `pizzeria`.`pizza_categories` (`id_pizza_category`, `name_pizza_category`, `initial_time`, `final_time`) VALUES ('1', 'Petita 2025', '01/01/2025', '31/12/2025');
INSERT INTO `pizzeria`.`pizza_categories` (`id_pizza_category`, `name_pizza_category`, `initial_time`) VALUES ('2', 'Petita 2026', '01/01/2026');
INSERT INTO `pizzeria`.`pizza_categories` (`id_pizza_category`, `name_pizza_category`, `initial_time`) VALUES ('3', 'Gran permanent', '01/01/2000');

INSERT INTO `pizzeria`.`orders_has_products` (`orders_id_orders`, `products_id_product`, `product_quantity`) VALUES ('1', '1', '2');
INSERT INTO `pizzeria`.`orders_has_products` (`orders_id_orders`, `products_id_product`, `product_quantity`) VALUES ('1', '4', '1');
INSERT INTO `pizzeria`.`orders_has_products` (`orders_id_orders`, `products_id_product`, `product_quantity`) VALUES ('1', '5', '3');