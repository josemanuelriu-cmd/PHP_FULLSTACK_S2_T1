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
-- Table `pizzeria`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`addresses` (
  `idAddress` INT(11) NOT NULL AUTO_INCREMENT ,
  `Address` VARCHAR(150) NOT NULL,
  `ZipCode` VARCHAR(5) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Province` VARCHAR(45) NULL DEFAULT NULL,
  `Telefon` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`idAddress`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`client` (
  `idClient` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Surname` VARCHAR(100) NOT NULL,
  `idAddress` INT(11) NOT NULL,
  `addresses_idAddress` INT(11) NOT NULL,
  PRIMARY KEY (`idClient`),
  INDEX `fk_client_addresses1_idx` (`addresses_idAddress` ASC) ,
  CONSTRAINT `fk_client_addresses1`
    FOREIGN KEY (`addresses_idAddress`)
    REFERENCES `pizzeria`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`stores` (
  `idstore` INT(11) NOT NULL AUTO_INCREMENT,
  `idOrder` INT(11) NOT NULL,
  `idAddress` INT(11) NOT NULL,
  `StoreName` VARCHAR(100) NOT NULL,
  `addresses_idAddress` INT(11) NOT NULL,
  PRIMARY KEY (`idstore`),
  INDEX `fk_stores_addresses1_idx` (`addresses_idAddress` ASC) ,
  CONSTRAINT `fk_stores_addresses1`
    FOREIGN KEY (`addresses_idAddress`)
    REFERENCES `pizzeria`.`addresses` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `idEmployee` INT(11) NOT NULL AUTO_INCREMENT,
  `idStore` INT(11) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Surname` VARCHAR(100) NULL DEFAULT NULL,
  `NIF` VARCHAR(15) NOT NULL,
  `Telefon` VARCHAR(15) NULL DEFAULT NULL,
  `TypeEmployee` TINYINT(4) NOT NULL,
  `stores_idstore` INT(11) NOT NULL,
  PRIMARY KEY (`idEmployee`),
  INDEX `fk_employees_stores1_idx` (`stores_idstore` ASC) ,
  CONSTRAINT `fk_employees_stores1`
    FOREIGN KEY (`stores_idstore`)
    REFERENCES `pizzeria`.`stores` (`idstore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `idorders` INT(11) NOT NULL AUTO_INCREMENT,
  `idClient` INT(11) NOT NULL,
  `DateTimeOrder` DATETIME NOT NULL,
  `ToHome` TINYINT(4) NOT NULL,
  `TotalProducts` INT(11) NOT NULL,
  `TotalPrice` DECIMAL(10,2) NOT NULL,
  `idEmployee` INT(11) NOT NULL,
  `DateTimeDelivery` DATETIME NOT NULL,
  `client_idClient` INT(11) NOT NULL,
  `employees_idEmployee` INT(11) NOT NULL,
  `client_idClient1` INT(11) NOT NULL,
  `stores_idstore` INT(11) NOT NULL,
  PRIMARY KEY (`idorders`),
  INDEX `fk_orders_employees1_idx` (`employees_idEmployee` ASC) ,
  INDEX `fk_orders_client1_idx` (`client_idClient1` ASC) ,
  INDEX `fk_orders_stores1_idx` (`stores_idstore` ASC) ,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employees_idEmployee`)
    REFERENCES `pizzeria`.`employees` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_client1`
    FOREIGN KEY (`client_idClient1`)
    REFERENCES `pizzeria`.`client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_stores1`
    FOREIGN KEY (`stores_idstore`)
    REFERENCES `pizzeria`.`stores` (`idstore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizza_categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`pizza_categories` (
  `idPizzaCategory` INT(11) NOT NULL AUTO_INCREMENT,
  `NamePizzaCategory` VARCHAR(100) NOT NULL,
  `InitialTime` DATE NOT NULL,
  `FinalTime` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`idPizzaCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `idproduct` INT(11) NOT NULL AUTO_INCREMENT,
  `ProductType` INT(11) NOT NULL,
  `Name` VARCHAR(100) NOT NULL,
  `Description` LONGTEXT NULL DEFAULT NULL,
  `Image` BLOB NULL DEFAULT NULL,
  `Price` DECIMAL(10,2) NOT NULL,
  `pizza_categories_idPizzaCategory` INT(11) NOT NULL,
  PRIMARY KEY (`idproduct`),
  INDEX `fk_products_pizza_categories1_idx` (`pizza_categories_idPizzaCategory` ASC) ,
  CONSTRAINT `fk_products_pizza_categories1`
    FOREIGN KEY (`pizza_categories_idPizzaCategory`)
    REFERENCES `pizzeria`.`pizza_categories` (`idPizzaCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `pizzeria`.`orders_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzeria`.`orders_has_products` (
  `orders_idorders` INT(11) NOT NULL,
  `products_idproduct` INT(11) NOT NULL,
  `productQuantity` INT NOT NULL,
  PRIMARY KEY (`orders_idorders`, `products_idproduct`),
  INDEX `fk_orders_has_products_products1_idx` (`products_idproduct` ASC) ,
  INDEX `fk_orders_has_products_orders_idx` (`orders_idorders` ASC) ,
  CONSTRAINT `fk_orders_has_products_orders`
    FOREIGN KEY (`orders_idorders`)
    REFERENCES `pizzeria`.`orders` (`idorders`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`products_idproduct`)
    REFERENCES `pizzeria`.`products` (`idproduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `pizzeria`.`addresses` (`idAddress`, `Address`, `ZipCode`, `City`, `Province`, `Telefon`) VALUES ('1', 'Carrer A, num 1, 1º 1ª', '08001', 'Barcelona', 'Barcelona', '123456789');
INSERT INTO `pizzeria`.`addresses` (`idAddress`, `Address`, `ZipCode`, `City`, `Province`, `Telefon`) VALUES ('2', 'Carrer B, num 2, 1º 1ª', '08002', 'Barcelona', 'Barcelona', '987654321');

INSERT INTO `pizzeria`.`client` (`idClient`, `Name`, `Surname`, `idAddress`) VALUES ('1', 'Client 1', 'Cognom client 1', '1');
INSERT INTO `pizzeria`.`client` (`idClient`, `Name`, `Surname`, `idAddress`) VALUES ('2', 'Client 2', 'Cognom client 2', '2');

INSERT INTO `pizzeria`.`stores` (`idstore`, `idOrder`, `idAddress`, `StoreName`) VALUES ('1', '1', '0', 'Tenda 1');
INSERT INTO `pizzeria`.`stores` (`idstore`, `idOrder`, `idAddress`, `StoreName`) VALUES ('2', '2', '1', 'Tenda 2');

INSERT INTO `pizzeria`.`employees` (`idEmployee`, `idStore`, `Name`, `Surname`, `NIF`, `Telefon`, `TypeEmployee`) VALUES ('1', '1', 'Empleat 1', 'Surname 1', '12345678A', '123456789', 'Repartidor');
INSERT INTO `pizzeria`.`employees` (`idEmployee`, `idStore`, `Name`, `Surname`, `NIF`, `Telefon`, `TypeEmployee`) VALUES ('2', '1', 'Empleat 2', 'Surname 2', '87654321B', '87654321', 'Cuiner');

INSERT INTO `pizzeria`.`orders` (`idorders`, `idClient`, `DateTimeOrder`, `ToHome`, `TotalProducts`, `TotalPrice`, `idEmployee`, `DateTimeDelivery`, `client_idClient`) VALUES ('1', '1', '2026-01-01 20:03:30', '1', '4', '20.24', '1', '2026-01-01 20:20:20', '1');
INSERT INTO `pizzeria`.`orders` (`idorders`, `idClient`, `DateTimeOrder`, `ToHome`, `TotalProducts`, `TotalPrice`, `idEmployee`, `DateTimeDelivery`, `client_idClient`) VALUES ('2', '2', '2026-01-01 20:10:02', '1', '2', '10.00', '1', '2026-01-01 20:40:00', '2');
INSERT INTO `pizzeria`.`orders` (`idorders`, `idClient`, `DateTimeOrder`, `ToHome`, `TotalProducts`, `TotalPrice`, `idEmployee`, `DateTimeDelivery`, `client_idClient`) VALUES ('3', '1', '2026-01-08 12:58:05', '1', '1', '8,5', '2', '2026-01-08 12:59:59', '1');

INSERT INTO `pizzeria`.`products` (`idproduct`, `ProductType`, `Name`, `Description`, `Price`) VALUES ('1', 'Pizza', 'Barbacoa petita', 'Molta carn', '12.5');
INSERT INTO `pizzeria`.`products` (`idproduct`, `ProductType`, `Name`, `Description`, `Price`) VALUES ('2', 'Pizza', 'Barbacoa gran', 'Molt mes carn', '20.3');
INSERT INTO `pizzeria`.`products` (`idproduct`, `ProductType`, `Name`, `Description`, `Price`) VALUES ('3', 'Hamburguesa', 'Clasica', 'Brutal', '13.5');

INSERT INTO `pizzeria`.`pizza_categories` (`idPizzaCategory`, `NamePizzaCategory`, `InitialTime`, `FinalTime`) VALUES ('1', 'Petita 2025', '01/01/2025', '31/12/2025');
INSERT INTO `pizzeria`.`pizza_categories` (`idPizzaCategory`, `NamePizzaCategory`, `InitialTime`) VALUES ('2', 'Petita 2026', '01/01/2026');
INSERT INTO `pizzeria`.`pizza_categories` (`idPizzaCategory`, `NamePizzaCategory`, `InitialTime`) VALUES ('3', 'Gran permanent', '01/01/2000');

INSERT INTO `pizzeria`.`orders_has_products` (`orders_idorders`, `products_idproduct`, `productQuantity`) VALUES ('1', '1', '2');
INSERT INTO `pizzeria`.`orders_has_products` (`orders_idorders`, `products_idproduct`, `productQuantity`) VALUES ('1', '4', '1');
INSERT INTO `pizzeria`.`orders_has_products` (`orders_idorders`, `products_idproduct`, `productQuantity`) VALUES ('1', '5', '3');