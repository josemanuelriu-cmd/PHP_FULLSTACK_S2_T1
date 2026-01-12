-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


-- -----------------------------------------------------
-- Schema culampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culampolla` DEFAULT CHARACTER SET utf8mb4 ;
USE `culampolla` ;

-- -----------------------------------------------------
-- Table `culampolla`.`adreses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`adreses` (
  `IDAdreca` INT(11) NOT NULL AUTO_INCREMENT,
  `Carrer` VARCHAR(100) NOT NULL,
  `Numero` VARCHAR(10) NOT NULL,
  `Pis` VARCHAR(3) NOT NULL,
  `Porta` VARCHAR(2) NOT NULL,
  `Ciutat` VARCHAR(50) NOT NULL,
  `Codi_postal` INT(11) NOT NULL,
  `Pais` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IDAdreca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`clients` (
  `IDClient` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(50) NOT NULL,
  `IDAdreca` INT(11) NULL DEFAULT NULL,
  `Telefon` VARCHAR(15) NULL DEFAULT NULL,
  `Correu electronic` VARCHAR(200) NULL DEFAULT NULL,
  `Data registre` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `Establiment recomenat` VARCHAR(50) NULL DEFAULT NULL,
  UNIQUE INDEX `IDClient` (`IDClient` ASC) ,
  INDEX `IDClient_2` (`IDClient` ASC) ,
  INDEX `IDAdreca` (`IDAdreca` ASC) ,
  CONSTRAINT `clients_ibfk_1`
    FOREIGN KEY (`IDAdreca`)
    REFERENCES `culampolla`.`adreses` (`IDAdreca`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`empleats` (
  `IDEmpleat` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(50) NOT NULL,
  `Establiment` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `IDEmpleat` (`IDEmpleat` ASC) ,
  INDEX `IDEmpleat_2` (`IDEmpleat` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`proveidors` (
  `IDProveidor` INT(11) NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(50) NOT NULL,
  `IDAdreca` INT(11) NOT NULL,
  `Telefon` VARCHAR(15) NOT NULL,
  `Fax` VARCHAR(15) NULL DEFAULT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  UNIQUE INDEX `IDProveidor` (`IDProveidor` ASC) ,
  INDEX `IDAdreca` (`IDAdreca` ASC) ,
  CONSTRAINT `proveidors_ibfk_1`
    FOREIGN KEY (`IDAdreca`)
    REFERENCES `culampolla`.`adreses` (`IDAdreca`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`ulleres` (
  `IDUllera` INT(11) NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(50) NOT NULL,
  `Graduacio dret` DECIMAL(10,0) NOT NULL,
  `Graduacio esquerre` DECIMAL(10,0) NOT NULL,
  `Color dret` VARCHAR(20) NOT NULL,
  `Color esquerre` VARCHAR(20) NOT NULL,
  `Tipus muntura` VARCHAR(10) NOT NULL,
  `Color muntura` VARCHAR(20) NOT NULL,
  `Preu` DECIMAL(10,2) NOT NULL,
  `IDProveidor` INT(11) NOT NULL,
  UNIQUE INDEX `IDUllera` (`IDUllera` ASC) ,
  INDEX `IDProveidor` (`IDProveidor` ASC) ,
  CONSTRAINT `ulleres_ibfk_1`
    FOREIGN KEY (`IDProveidor`)
    REFERENCES `culampolla`.`proveidors` (`IDProveidor`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`vendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`vendes` (
  `IDVenta` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `IDEmpleat` INT(11) NOT NULL,
  `IDClient` INT(11) NOT NULL,
  `IDUllera` INT(11) NOT NULL,
  `Data venta` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  UNIQUE INDEX `IDVenda` (`IDVenta` ASC) ,
  UNIQUE INDEX `Numempleat` (`IDEmpleat` ASC) ,
  INDEX `IDEmpleat` (`IDEmpleat` ASC, `IDClient` ASC, `IDUllera` ASC) ,
  INDEX `IDUllera` (`IDUllera` ASC) ,
  INDEX `IDClient` (`IDClient` ASC) ,
  CONSTRAINT `vendes_ibfk_1`
    FOREIGN KEY (`IDEmpleat`)
    REFERENCES `culampolla`.`empleats` (`IDEmpleat`)
    ON UPDATE CASCADE,
  CONSTRAINT `vendes_ibfk_2`
    FOREIGN KEY (`IDUllera`)
    REFERENCES `culampolla`.`ulleres` (`IDUllera`)
    ON UPDATE CASCADE,
  CONSTRAINT `vendes_ibfk_3`
    FOREIGN KEY (`IDClient`)
    REFERENCES `culampolla`.`clients` (`IDClient`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



INSERT INTO `culampolla`.`adresses` (`IDAdreca`, `Carrer`, `Numero`, `Pis`, `Porta`, `Ciutat`, `Codi_postal`, `Pais`) VALUES ('1', 'diagonal', '2', '1', '3', 'Barcelona', '08001', 'Espanya');
INSERT INTO `culampolla`.`adresses` (`IDAdreca`, `Carrer`, `Numero`, `Pis`, `Porta`, `Ciutat`, `Codi_postal`, `Pais`) VALUES ('2', 'mallorca', '11', '1', '1', 'Barcelona', '08002', 'Espanya');
INSERT INTO `culampolla`.`adresses` (`IDAdreca`, `Carrer`, `Numero`, `Pis`, `Porta`, `Ciutat`, `Codi_postal`, `Pais`) VALUES ('3', 'meridiana', '3', '3', '3', 'Barcelona', '08003', 'Espanya');

INSERT INTO `culampolla`.`clients` (`IDClient`, `Nom`, `IDAdreca`, `Telefon`, `Correu electronic`, `Data registre`, `Establiment recomenat`) VALUES ('1', 'client 1', '1', '123456789', 'mail@mail.es', '2026-01-01', '1');
INSERT INTO `culampolla`.`clients` (`IDClient`, `Nom`, `IDAdreca`, `Telefon`, `Correu electronic`, `Data registre`, `Establiment recomenat`) VALUES ('2', 'client2', '3', '444555666', 'client2@mail.es', '2026-01-12', '1');

INSERT INTO `culampolla`.`proveidors` (`IDProveidor`, `Nom`, `IDAdreca`, `Telefon`, `Fax`, `NIF`) VALUES ('1', 'Proveidor1', '1', '123456789', '987654321', '87654123A');
INSERT INTO `culampolla`.`proveidors` (`IDProveidor`, `Nom`, `IDAdreca`, `Telefon`, `Fax`, `NIF`) VALUES ('2', 'Proveidor2', '2', '123456789', '987654321', '12345678B');

INSERT INTO `culampolla`.`empleats` (`IDEmpleat`, `Nom`, `Establiment`) VALUES ('1', 'Empleat 1', '1');
INSERT INTO `culampolla`.`empleats` (`IDEmpleat`, `Nom`, `Establiment`) VALUES ('2', 'Empleat2', '1');

INSERT INTO `culampolla`.`ulleres` (`IDUllera`, `Marca`, `Graduacio dret`, `Graduacio esquerre`, `Color dret`, `Color esquerre`, `Tipus muntura`, `Color muntura`, `Preu`, `IDProveidor`) VALUES ('1', 'Marca1', '1', '2', 'blau', 'verd', 'pasta', 'blau', '100', '1');
INSERT INTO `culampolla`.`ulleres` (`IDUllera`, `Marca`, `Graduacio dret`, `Graduacio esquerre`, `Color dret`, `Color esquerre`, `Tipus muntura`, `Color muntura`, `Preu`, `IDProveidor`) VALUES ('2', 'Marca2', '1', '2.5', 'blau', 'blau', 'ferro', 'blau', '110', '1');

INSERT INTO `culampolla`.`vendes` (`IDVenta`, `IDEmpleat`, `IDClient`, `IDUllera`, `Data venta`) VALUES ('1', '1', '1', '1', '2026/01/02');
INSERT INTO `culampolla`.`vendes` (`IDVenta`, `IDEmpleat`, `IDClient`, `IDUllera`, `Data venta`) VALUES ('2', '1', '1', '2', '2026-01-04');