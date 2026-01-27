-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema culampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema culampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culampolla` DEFAULT CHARACTER SET utf8mb4 ;
USE `culampolla` ;

-- -----------------------------------------------------
-- Table `culampolla`.`adresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`adresses` (
  `ID_adreca` INT(11) NOT NULL AUTO_INCREMENT,
  `carrer` INT NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `pis` VARCHAR(3) NOT NULL,
  `porta` VARCHAR(2) NOT NULL,
  `ciutat` VARCHAR(50) NOT NULL,
  `codi_postal` INT(11) NOT NULL,
  `pais` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID_adreca`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`clients` (
  `ID_client` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `ID_adreca` INT(11) NULL DEFAULT NULL,
  `telefon` VARCHAR(15) NULL DEFAULT NULL,
  `correu_electronic` VARCHAR(200) NULL DEFAULT NULL,
  `data_registre` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `establiment recomenat` VARCHAR(50) NULL DEFAULT NULL,
  `clients_IDClient` INT(11) NOT NULL,
  UNIQUE INDEX `IDClient` (`ID_client` ASC) ,
  INDEX `IDClient_2` (`ID_client` ASC) ,
  INDEX `IDAdreca` (`ID_adreca` ASC) ,
  PRIMARY KEY (`ID_client`, `clients_IDClient`),
  INDEX `fk_clients_clients1_idx` (`clients_IDClient` ASC) ,
  CONSTRAINT `clients_ibfk_1`
    FOREIGN KEY (`ID_adreca`)
    REFERENCES `culampolla`.`adresses` (`ID_adreca`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clients_clients1`
    FOREIGN KEY (`clients_IDClient`)
    REFERENCES `culampolla`.`clients` (`ID_client`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`empleats` (
  `ID_empleat` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `establiment` VARCHAR(50) NOT NULL,
  UNIQUE INDEX `IDEmpleat` (`ID_empleat` ASC) ,
  INDEX `IDEmpleat_2` (`ID_empleat` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`proveidors` (
  `ID_proveidor` INT(11) NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(50) NOT NULL,
  `ID_adreca` INT(11) NOT NULL,
  `telefon` VARCHAR(15) NOT NULL,
  `fax` VARCHAR(15) NULL DEFAULT NULL,
  `NIF` VARCHAR(10) NOT NULL,
  UNIQUE INDEX `IDProveidor` (`ID_proveidor` ASC) ,
  INDEX `IDAdreca` (`ID_adreca` ASC) ,
  CONSTRAINT `proveidors_ibfk_1`
    FOREIGN KEY (`ID_adreca`)
    REFERENCES `culampolla`.`adresses` (`ID_adreca`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`ulleres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`ulleres` (
  `ID_ullera` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(50) NOT NULL,
  `graduacio_dret` DECIMAL(10,0) NOT NULL,
  `graduacio_esquerre` DECIMAL(10,0) NOT NULL,
  `color_dret` VARCHAR(20) NOT NULL,
  `color_esquerre` VARCHAR(20) NOT NULL,
  `tipus_muntura` VARCHAR(10) NOT NULL,
  `color_muntura` VARCHAR(20) NOT NULL,
  `preu` DECIMAL(10,0) NOT NULL,
  `ID_proveidor` INT(11) NOT NULL,
  UNIQUE INDEX `IDUllera` (`ID_ullera` ASC) ,
  INDEX `IDProveidor` (`ID_proveidor` ASC) ,
  CONSTRAINT `ulleres_ibfk_1`
    FOREIGN KEY (`ID_proveidor`)
    REFERENCES `culampolla`.`proveidors` (`ID_proveidor`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `culampolla`.`vendes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`vendes` (
  `ID_venta` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `ID_empleat` INT(11) NOT NULL,
  `ID_client` INT(11) NOT NULL,
  `ID_ullera` INT(11) NOT NULL,
  `data_venta` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  UNIQUE INDEX `IDVenda` (`ID_venta` ASC) ,
  UNIQUE INDEX `Numempleat` (`ID_empleat` ASC) ,
  INDEX `IDEmpleat` (`ID_empleat` ASC, `ID_client` ASC, `ID_ullera` ASC) ,
  INDEX `IDUllera` (`ID_ullera` ASC) ,
  INDEX `IDClient` (`ID_client` ASC) ,
  CONSTRAINT `vendes_ibfk_1`
    FOREIGN KEY (`ID_empleat`)
    REFERENCES `culampolla`.`empleats` (`ID_empleat`)
    ON UPDATE CASCADE,
  CONSTRAINT `vendes_ibfk_2`
    FOREIGN KEY (`ID_ullera`)
    REFERENCES `culampolla`.`ulleres` (`ID_ullera`)
    ON UPDATE CASCADE,
  CONSTRAINT `vendes_ibfk_3`
    FOREIGN KEY (`ID_client`)
    REFERENCES `culampolla`.`clients` (`ID_client`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




INSERT INTO `culampolla`.`adresses` (`ID_adreca`, `carrer`, `numero`, `pis`, `porta`, `ciutat`, `codi_postal`, `pais`) VALUES ('1', 'diagonal', '2', '1', '3', 'Barcelona', '08001', 'Espanya');
INSERT INTO `culampolla`.`adresses` (`ID_adreca`, `carrer`, `numero`, `pis`, `porta`, `ciutat`, `codi_postal`, `pais`) VALUES ('2', 'mallorca', '11', '1', '1', 'Barcelona', '08002', 'Espanya');
INSERT INTO `culampolla`.`adresses` (`ID_adreca`, `carrer`, `numero`, `pis`, `porta`, `ciutat`, `codi_postal`, `pais`) VALUES ('3', 'meridiana', '3', '3', '3', 'Barcelona', '08003', 'Espanya');

INSERT INTO `culampolla`.`clients` (`ID_client`, `nom`, `ID_adreca`, `telefon`, `correu_electronic`, `data_registre`, `establiment_recomenat`) VALUES ('1', 'client 1', '1', '123456789', 'mail@mail.es', '2026-01-01', '1');
INSERT INTO `culampolla`.`clients` (`ID_client`, `nom`, `ID_adreca`, `telefon`, `correu_electronic`, `data_registre`, `establiment_recomenat`) VALUES ('2', 'client2', '3', '444555666', 'client2@mail.es', '2026-01-12', '1');

INSERT INTO `culampolla`.`proveidors` (`ID_proveidor`, `nom`, `ID_adreca`, `telefon`, `fax`, `NIF`) VALUES ('1', 'Proveidor1', '1', '123456789', '987654321', '87654123A');
INSERT INTO `culampolla`.`proveidors` (`ID_proveidor`, `nom`, `ID_adreca`, `telefon`, `fax`, `NIF`) VALUES ('2', 'Proveidor2', '2', '123456789', '987654321', '12345678B');

INSERT INTO `culampolla`.`empleats` (`ID_empleat`, `nom`, `establiment`) VALUES ('1', 'Empleat 1', '1');
INSERT INTO `culampolla`.`empleats` (`ID_empleat`, `nom`, `establiment`) VALUES ('2', 'Empleat2', '1');

INSERT INTO `culampolla`.`ulleres` (`ID_ullera`, `marca`, `graduacio_dret`, `graduacio_esquerre`, `color_dret`, `color_esquerre`, `tipus_muntura`, `color_muntura`, `preu`, `ID_proveidor`) VALUES ('1', 'Marca1', '1', '2', 'blau', 'verd', 'pasta', 'blau', '100', '1');
INSERT INTO `culampolla`.`ulleres` (`ID_ullera`, `marca`, `graduacio_dret`, `graduacio_esquerre`, `color_dret`, `color_esquerre`, `tipus_muntura`, `color_muntura`, `preu`, `ID_proveidor`) VALUES ('2', 'Marca2', '1', '2.5', 'blau', 'blau', 'ferro', 'blau', '110', '1');

INSERT INTO `culampolla`.`vendes` (`ID_venta`, `ID_empleat`, `ID_client`, `ID_ullera`, `data_venta`) VALUES ('1', '1', '1', '1', '2026/01/02');
INSERT INTO `culampolla`.`vendes` (`ID_venta`, `ID_empleat`, `ID_client`, `ID_ullera`, `data_venta`) VALUES ('2', '1', '1', '2', '2026-01-04');