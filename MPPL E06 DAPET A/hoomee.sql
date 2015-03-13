SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `hoomee` ;
CREATE SCHEMA IF NOT EXISTS `hoomee` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `hoomee` ;

-- -----------------------------------------------------
-- Table `hoomee`.`Login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Login` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Login` (
  `idLogin` INT NOT NULL AUTO_INCREMENT ,
  `namaLogin` VARCHAR(45) NOT NULL ,
  `akunLogin` VARCHAR(45) NOT NULL ,
  `passLogin` VARCHAR(45) NOT NULL ,
  `jenisLogin` INT NOT NULL ,
  `availability` INT NOT NULL ,
  PRIMARY KEY (`idLogin`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`Supplier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Supplier` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Supplier` (
  `idSupplier` INT NOT NULL AUTO_INCREMENT ,
  `namaSupplier` VARCHAR(45) NOT NULL ,
  `nominalTransaksiSupplier` INT NOT NULL ,
  `keteranganBarangSupplier` VARCHAR(1028) NOT NULL ,
  `catatanSupplier` VARCHAR(1028) NULL ,
  `tanggalSupplier` DATETIME NULL ,
  `Login_idLogin` INT NOT NULL ,
  PRIMARY KEY (`idSupplier`) ,
  INDEX `fk_Supplier_Login_idx` (`Login_idLogin` ASC) ,
  CONSTRAINT `fk_Supplier_Login`
    FOREIGN KEY (`Login_idLogin` )
    REFERENCES `hoomee`.`Login` (`idLogin` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`Diskon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Diskon` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Diskon` (
  `idDiskon` INT NOT NULL AUTO_INCREMENT ,
  `temaDiskon` VARCHAR(45) NOT NULL ,
  `persentaseDiskon` DOUBLE NOT NULL ,
  PRIMARY KEY (`idDiskon`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`Meja`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Meja` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Meja` (
  `idMeja` VARCHAR(50) NOT NULL ,
  `Transaksi_idTransaksi` INT NULL ,
  PRIMARY KEY (`idMeja`) ,
  INDEX `fk_Meja_Transaksi1_idx` (`Transaksi_idTransaksi` ASC) ,
  CONSTRAINT `fk_Meja_Transaksi1`
    FOREIGN KEY (`Transaksi_idTransaksi` )
    REFERENCES `hoomee`.`Transaksi` (`idTransaksi` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`Transaksi`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Transaksi` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Transaksi` (
  `idTransaksi` INT NOT NULL AUTO_INCREMENT ,
  `tanggalTransaksi` DATETIME NULL ,
  `tipePembayaran` VARCHAR(50) NULL ,
  `subtotalPembayaran` INT NULL DEFAULT 0 ,
  `totalPembayaran` INT NULL DEFAULT 0 ,
  `uangPembayaran` INT NULL DEFAULT 0 ,
  `uangKembalian` INT NULL DEFAULT 0 ,
  `Diskon_idDiskon` INT NULL ,
  `Login_idLogin` INT NOT NULL ,
  `Meja_idMeja` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idTransaksi`) ,
  INDEX `fk_Transaksi_Diskon1_idx` (`Diskon_idDiskon` ASC) ,
  INDEX `fk_Transaksi_Login1_idx` (`Login_idLogin` ASC) ,
  INDEX `fk_Transaksi_Meja1_idx` (`Meja_idMeja` ASC) ,
  CONSTRAINT `fk_Transaksi_Diskon1`
    FOREIGN KEY (`Diskon_idDiskon` )
    REFERENCES `hoomee`.`Diskon` (`idDiskon` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaksi_Login1`
    FOREIGN KEY (`Login_idLogin` )
    REFERENCES `hoomee`.`Login` (`idLogin` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transaksi_Meja1`
    FOREIGN KEY (`Meja_idMeja` )
    REFERENCES `hoomee`.`Meja` (`idMeja` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`Menu` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`Menu` (
  `idMenu` INT NOT NULL AUTO_INCREMENT ,
  `namaMenu` VARCHAR(50) NOT NULL ,
  `hargaMenu` INT NOT NULL ,
  `jenisMenu` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idMenu`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoomee`.`TransaksiMenu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoomee`.`TransaksiMenu` ;

CREATE  TABLE IF NOT EXISTS `hoomee`.`TransaksiMenu` (
  `Quantity` INT NOT NULL DEFAULT 0 ,
  `Total` INT NOT NULL DEFAULT 0 ,
  `Menu_idMenu` INT NOT NULL ,
  `Transaksi_idTransaksi` INT NOT NULL ,
  INDEX `fk_TransaksiMenu_Menu1_idx` (`Menu_idMenu` ASC) ,
  INDEX `fk_TransaksiMenu_Transaksi1_idx` (`Transaksi_idTransaksi` ASC) ,
  CONSTRAINT `fk_TransaksiMenu_Menu1`
    FOREIGN KEY (`Menu_idMenu` )
    REFERENCES `hoomee`.`Menu` (`idMenu` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TransaksiMenu_Transaksi1`
    FOREIGN KEY (`Transaksi_idTransaksi` )
    REFERENCES `hoomee`.`Transaksi` (`idTransaksi` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `hoomee` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Login`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Login` (`idLogin`, `namaLogin`, `akunLogin`, `passLogin`, `jenisLogin`, `availability`) VALUES (1, 'jordy', 'manager', 'manager', 0, 0);
INSERT INTO `hoomee`.`Login` (`idLogin`, `namaLogin`, `akunLogin`, `passLogin`, `jenisLogin`, `availability`) VALUES (2, 'komang', 'pegawai', 'pegawai', 1, 0);

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Supplier`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Supplier` (`idSupplier`, `namaSupplier`, `nominalTransaksiSupplier`, `keteranganBarangSupplier`, `catatanSupplier`, `tanggalSupplier`, `Login_idLogin`) VALUES (1, 'komo', 100000, 'susu', 'lunas', NULL, 2);

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Diskon`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Diskon` (`idDiskon`, `temaDiskon`, `persentaseDiskon`) VALUES (1, 'Liburan', 10);
INSERT INTO `hoomee`.`Diskon` (`idDiskon`, `temaDiskon`, `persentaseDiskon`) VALUES (2, 'Valentine', 20);

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Meja`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A1', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A2', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A3', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A4', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A5', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('A6', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B1', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B2', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B3', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B4', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B5', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('B6', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C1', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C2', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C3', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C4', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C5', NULL);
INSERT INTO `hoomee`.`Meja` (`idMeja`, `Transaksi_idTransaksi`) VALUES ('C6', NULL);

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Transaksi`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Transaksi` (`idTransaksi`, `tanggalTransaksi`, `tipePembayaran`, `subtotalPembayaran`, `totalPembayaran`, `uangPembayaran`, `uangKembalian`, `Diskon_idDiskon`, `Login_idLogin`, `Meja_idMeja`) VALUES (1, NULL, 'Cash', 100000, 100000, 150000, 50000, NULL, 2, 'A1');

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`Menu`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`Menu` (`idMenu`, `namaMenu`, `hargaMenu`, `jenisMenu`) VALUES (1, 'Churros', 20000, 'Makanan');
INSERT INTO `hoomee`.`Menu` (`idMenu`, `namaMenu`, `hargaMenu`, `jenisMenu`) VALUES (2, 'Espresso', 15000, 'Minuman');

COMMIT;

-- -----------------------------------------------------
-- Data for table `hoomee`.`TransaksiMenu`
-- -----------------------------------------------------
START TRANSACTION;
USE `hoomee`;
INSERT INTO `hoomee`.`TransaksiMenu` (`Quantity`, `Total`, `Menu_idMenu`, `Transaksi_idTransaksi`) VALUES (2, 40000, 1, 1);
INSERT INTO `hoomee`.`TransaksiMenu` (`Quantity`, `Total`, `Menu_idMenu`, `Transaksi_idTransaksi`) VALUES (2, 30000, 2, 1);

COMMIT;
