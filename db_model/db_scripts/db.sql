-- MySQL Script generated by MySQL Workbench
-- Sun Nov 12 21:24:58 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema check_ins_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema check_ins_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `check_ins_db` DEFAULT CHARACTER SET utf8 ;
USE `check_ins_db` ;

-- -----------------------------------------------------
-- Table `check_ins_db`.`Gender`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`Gender` (
  `idGender` INT NOT NULL AUTO_INCREMENT,
  `nameGender` VARCHAR(45) NOT NULL,
  `codeGender` CHAR NOT NULL,
  PRIMARY KEY (`idGender`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`Person` (
  `idPerson` INT NOT NULL AUTO_INCREMENT,
  `givenName` VARCHAR(45) NULL,
  `familyName` VARCHAR(45) NULL,
  `preferredName` VARCHAR(45) NULL,
  `idGenderFK` INT NOT NULL DEFAULT 3,
  `isMember` TINYINT NOT NULL DEFAULT 0,
  `isBaptised` TINYINT NULL DEFAULT 0,
  `contactCreated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPerson`),
  UNIQUE INDEX `idPerson_UNIQUE` (`idPerson` ASC),
  INDEX `idGenderKey_idx` (`idGenderFK` ASC),
  CONSTRAINT `idGenderFK`
    FOREIGN KEY (`idGenderFK`)
    REFERENCES `check_ins_db`.`Gender` (`idGender`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`Visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`Visit` (
  `idVisit` INT NOT NULL AUTO_INCREMENT,
  `idPersonFK` INT NOT NULL,
  `dateTimeVisit` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idVisit`),
  INDEX `idPerson_idx` (`idPersonFK` ASC),
  CONSTRAINT `idPersonFK`
    FOREIGN KEY (`idPersonFK`)
    REFERENCES `check_ins_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`ContactType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`ContactType` (
  `idContactType` INT NOT NULL AUTO_INCREMENT,
  `nameContactType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContactType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`Contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`Contact` (
  `idContact` INT NOT NULL AUTO_INCREMENT,
  `idContactTypeFK` INT NOT NULL,
  `entryContact` VARCHAR(100) NULL,
  `isPreferred` TINYINT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idContact`),
  INDEX `idContactType_idx` (`idContactTypeFK` ASC),
  CONSTRAINT `idContactTypeFK`
    FOREIGN KEY (`idContactTypeFK`)
    REFERENCES `check_ins_db`.`ContactType` (`idContactType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`PersonContact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`PersonContact` (
  `idPersonContact` INT NOT NULL AUTO_INCREMENT,
  `idPersonFK` INT NOT NULL,
  `idContactFK` INT NOT NULL,
  PRIMARY KEY (`idPersonContact`),
  INDEX `idPerson_idx` (`idPersonFK` ASC),
  INDEX `idContact_idx` (`idContactFK` ASC),
  CONSTRAINT `idPersonFK`
    FOREIGN KEY (`idPersonFK`)
    REFERENCES `check_ins_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idContactFK`
    FOREIGN KEY (`idContactFK`)
    REFERENCES `check_ins_db`.`Contact` (`idContact`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`State`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`State` (
  `idState` VARCHAR(3) NOT NULL,
  `nameState` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idState`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`Address` (
  `idAddress` INT NOT NULL AUTO_INCREMENT,
  `addressStreet` VARCHAR(100) NULL,
  `addressSuburb` VARCHAR(45) NULL,
  `idStateFK` VARCHAR(3) NOT NULL,
  `createdDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idAddress`),
  INDEX `idState_idx` (`idStateFK` ASC),
  CONSTRAINT `idStateFK`
    FOREIGN KEY (`idStateFK`)
    REFERENCES `check_ins_db`.`State` (`idState`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `check_ins_db`.`PersonAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `check_ins_db`.`PersonAddress` (
  `idPersonAddress` INT NOT NULL AUTO_INCREMENT,
  `idPersonFK` INT NOT NULL,
  `idAddressFK` INT NOT NULL,
  `creationDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastUpdated` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idPersonAddress`),
  INDEX `idPerson_idx` (`idPersonFK` ASC),
  INDEX `idAddress_idx` (`idAddressFK` ASC),
  CONSTRAINT `idPersonFK`
    FOREIGN KEY (`idPersonFK`)
    REFERENCES `check_ins_db`.`Person` (`idPerson`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idAddressFK`
    FOREIGN KEY (`idAddressFK`)
    REFERENCES `check_ins_db`.`Address` (`idAddress`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
