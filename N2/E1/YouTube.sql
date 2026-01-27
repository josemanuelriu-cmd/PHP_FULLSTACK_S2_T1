-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema YouTube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `YouTube` DEFAULT CHARACTER SET utf8 ;
USE `YouTube` ;

-- -----------------------------------------------------
-- Table `YouTube`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(100) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `UserName` VARCHAR(45) NOT NULL,
  `Birthdate` DATE NOT NULL,
  `Gender` VARCHAR(1) NOT NULL,
  `Country` VARCHAR(45) NOT NULL,
  `ZipCode` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idUsers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Videos` (
  `idVideo` INT NOT NULL AUTO_INCREMENT,
  `Tittle` VARCHAR(45) NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `Weight` DECIMAL(10,2) UNSIGNED NOT NULL,
  `VideoName` VARCHAR(100) NOT NULL,
  `Duration` INT UNSIGNED NOT NULL,
  `Thumbnail` BLOB NOT NULL,
  `ReproductionNumber` INT UNSIGNED NULL,
  `Likes` INT UNSIGNED NULL,
  `Dislikes` INT UNSIGNED NULL,
  `PublicationDate` DATETIME NOT NULL,
  `State` ENUM('public', 'ocult', 'privat') NOT NULL,
  PRIMARY KEY (`idVideo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Tags` (
  `idTags` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idTags`),
  UNIQUE INDEX `Name_UNIQUE` (`Name` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Channels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Channels` (
  `idChannel` INT NOT NULL AUTO_INCREMENT,
  `ChannelName` VARCHAR(45) NOT NULL,
  `Description` LONGTEXT NOT NULL,
  `CreationDate` DATETIME NOT NULL,
  `IdOwner` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idChannel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Playlists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Playlists` (
  `idPlaylists` INT NOT NULL AUTO_INCREMENT,
  `PlaylistName` VARCHAR(45) NOT NULL,
  `CreationDate` DATETIME NOT NULL,
  `State` ENUM('Public', 'Privat') NOT NULL,
  `Users_idUsers` INT NOT NULL,
  PRIMARY KEY (`idPlaylists`),
  INDEX `fk_Playlists_Users1_idx` (`Users_idUsers` ASC) ,
  CONSTRAINT `fk_Playlists_Users1`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `YouTube`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Comments` (
  `idComment` INT NOT NULL AUTO_INCREMENT,
  `CommentText` MEDIUMTEXT NOT NULL,
  `ComentariDate` DATETIME NOT NULL,
  PRIMARY KEY (`idComment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Subscriptions` (
  `idSubscriptions` INT NOT NULL,
  `Users_idUsers` INT NOT NULL,
  `Channels_idChannel` INT NOT NULL,
  PRIMARY KEY (`idSubscriptions`),
  INDEX `fk_Subscriptions_Users_idx` (`Users_idUsers` ASC) ,
  INDEX `fk_Subscriptions_Channels1_idx` (`Channels_idChannel` ASC) ,
  CONSTRAINT `fk_Subscriptions_Users`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `YouTube`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Subscriptions_Channels1`
    FOREIGN KEY (`Channels_idChannel`)
    REFERENCES `YouTube`.`Channels` (`idChannel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Playlist_videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Playlist_videos` (
  `Playlists_idPlaylists` INT NOT NULL,
  `Videos_idVideo` INT NOT NULL,
  INDEX `fk_Playlist_videos_Playlists1_idx` (`Playlists_idPlaylists` ASC) ,
  INDEX `fk_Playlist_videos_Videos1_idx` (`Videos_idVideo` ASC) ,
  CONSTRAINT `fk_Playlist_videos_Playlists1`
    FOREIGN KEY (`Playlists_idPlaylists`)
    REFERENCES `YouTube`.`Playlists` (`idPlaylists`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Playlist_videos_Videos1`
    FOREIGN KEY (`Videos_idVideo`)
    REFERENCES `YouTube`.`Videos` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Video_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Video_tags` (
  `Videos_idVideo` INT NOT NULL,
  `Tags_idTags` INT NOT NULL,
  INDEX `fk_Video_tags_Videos1_idx` (`Videos_idVideo` ASC) ,
  INDEX `fk_Video_tags_Tags1_idx` (`Tags_idTags` ASC) ,
  CONSTRAINT `fk_Video_tags_Videos1`
    FOREIGN KEY (`Videos_idVideo`)
    REFERENCES `YouTube`.`Videos` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_tags_Tags1`
    FOREIGN KEY (`Tags_idTags`)
    REFERENCES `YouTube`.`Tags` (`idTags`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Video_votes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Video_votes` (
  `Type` ENUM('1') NOT NULL,
  `Date` DATETIME NOT NULL,
  `Users_idUsers` INT NOT NULL,
  `Videos_idVideo` INT NOT NULL,
  INDEX `fk_Video_votes_Users1_idx` (`Users_idUsers` ASC) ,
  INDEX `fk_Video_votes_Videos1_idx` (`Videos_idVideo` ASC) ,
  CONSTRAINT `fk_Video_votes_Users1`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `YouTube`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_votes_Videos1`
    FOREIGN KEY (`Videos_idVideo`)
    REFERENCES `YouTube`.`Videos` (`idVideo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `YouTube`.`Comment_votes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `YouTube`.`Comment_votes` (
  `Type` ENUM('1') NOT NULL,
  `Date` DATETIME NOT NULL,
  `Users_idUsers` INT NOT NULL,
  `Comments_idComment` INT NOT NULL,
  INDEX `fk_Comment_votes_Users1_idx` (`Users_idUsers` ASC) ,
  INDEX `fk_Comment_votes_Comments1_idx` (`Comments_idComment` ASC) ,
  CONSTRAINT `fk_Comment_votes_Users1`
    FOREIGN KEY (`Users_idUsers`)
    REFERENCES `YouTube`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comment_votes_Comments1`
    FOREIGN KEY (`Comments_idComment`)
    REFERENCES `YouTube`.`Comments` (`idComment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
