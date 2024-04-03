-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema carreraciclismo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema carreraciclismo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `carreraciclismo` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `carreraciclismo` ;

-- -----------------------------------------------------
-- Table `carreraciclismo`.`equipos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`equipos` (
  `IdEquipo` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`IdEquipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 503
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`ciclistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`ciclistas` (
  `IdCiclista` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(255) NOT NULL,
  `Edad` INT NULL DEFAULT NULL,
  `Nacionalidad` VARCHAR(255) NULL DEFAULT NULL,
  `EquipoId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`IdCiclista`),
  INDEX `EquipoId` (`EquipoId` ASC) VISIBLE,
  CONSTRAINT `ciclistas_ibfk_1`
    FOREIGN KEY (`EquipoId`)
    REFERENCES `carreraciclismo`.`equipos` (`IdEquipo`))
ENGINE = InnoDB
AUTO_INCREMENT = 304
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`tipo_liderazgo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`tipo_liderazgo` (
  `id_Tipo` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Tipo`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`perfiles_etapas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`perfiles_etapas` (
  `id_perfi` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_perfi`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`lugares`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`lugares` (
  `IdLugar` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(255) NOT NULL,
  `Latitud` DECIMAL(10,6) NULL DEFAULT NULL,
  `Longitud` DECIMAL(10,6) NULL DEFAULT NULL,
  PRIMARY KEY (`IdLugar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`etapas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`etapas` (
  `IdEtapa` INT NOT NULL AUTO_INCREMENT,
  `Numero` INT NULL DEFAULT NULL,
  `Distancia` DECIMAL(10,2) NULL DEFAULT NULL,
  `Perfil` INT NULL DEFAULT NULL,
  `FechaInicio` DATETIME NULL DEFAULT NULL,
  `InicioId` INT NULL DEFAULT NULL,
  `FinId` INT NULL DEFAULT NULL,
  PRIMARY KEY (`IdEtapa`),
  INDEX `InicioId` (`InicioId` ASC) VISIBLE,
  INDEX `FinId` (`FinId` ASC) VISIBLE,
  INDEX `etapa_perfiles_fk_idx` (`Perfil` ASC) VISIBLE,
  CONSTRAINT `etapa_perfiles_fk`
    FOREIGN KEY (`Perfil`)
    REFERENCES `carreraciclismo`.`perfiles_etapas` (`id_perfi`),
  CONSTRAINT `etapas_ibfk_1`
    FOREIGN KEY (`InicioId`)
    REFERENCES `carreraciclismo`.`lugares` (`IdLugar`),
  CONSTRAINT `etapas_ibfk_2`
    FOREIGN KEY (`FinId`)
    REFERENCES `carreraciclismo`.`lugares` (`IdLugar`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`clasificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`clasificacion` (
  `Id-clasificacion` INT NOT NULL AUTO_INCREMENT,
  `EtapaId` INT NULL DEFAULT NULL,
  `CiclistaId` INT NULL DEFAULT NULL,
  `TipoLiderazgo` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Id-clasificacion`),
  INDEX `EtapaId` (`EtapaId` ASC) VISIBLE,
  INDEX `CiclistaId` (`CiclistaId` ASC) VISIBLE,
  INDEX `ideres_tipos_fk_idx` (`TipoLiderazgo` ASC) VISIBLE,
  CONSTRAINT `ideres_tipos_fk`
    FOREIGN KEY (`TipoLiderazgo`)
    REFERENCES `carreraciclismo`.`tipo_liderazgo` (`id_Tipo`),
  CONSTRAINT `lideres_ibfk_1`
    FOREIGN KEY (`EtapaId`)
    REFERENCES `carreraciclismo`.`etapas` (`IdEtapa`),
  CONSTRAINT `lideres_ibfk_2`
    FOREIGN KEY (`CiclistaId`)
    REFERENCES `carreraciclismo`.`ciclistas` (`IdCiclista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`patrocinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`patrocinador` (
  `id_patrocinador` INT NOT NULL,
  `nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_patrocinador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`patrocinador_has_ciclistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`patrocinador_has_ciclistas` (
  `Patrocinador_id_patrocinador` INT NOT NULL,
  `ciclistas_IdCiclista` INT NOT NULL,
  PRIMARY KEY (`Patrocinador_id_patrocinador`, `ciclistas_IdCiclista`),
  INDEX `fk_Patrocinador_has_ciclistas_ciclistas1_idx` (`ciclistas_IdCiclista` ASC) VISIBLE,
  INDEX `fk_Patrocinador_has_ciclistas_Patrocinador1_idx` (`Patrocinador_id_patrocinador` ASC) VISIBLE,
  CONSTRAINT `fk_Patrocinador_has_ciclistas_ciclistas1`
    FOREIGN KEY (`ciclistas_IdCiclista`)
    REFERENCES `carreraciclismo`.`ciclistas` (`IdCiclista`),
  CONSTRAINT `fk_Patrocinador_has_ciclistas_Patrocinador1`
    FOREIGN KEY (`Patrocinador_id_patrocinador`)
    REFERENCES `carreraciclismo`.`patrocinador` (`id_patrocinador`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`resultados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`resultados` (
  `IdResultado` INT NOT NULL AUTO_INCREMENT,
  `EtapaId` INT NULL DEFAULT NULL,
  `CiclistaId` INT NULL DEFAULT NULL,
  `TiempoLlegada` TIME NULL DEFAULT NULL,
  `Posicion` INT NULL DEFAULT NULL,
  PRIMARY KEY (`IdResultado`),
  INDEX `EtapaId` (`EtapaId` ASC) VISIBLE,
  INDEX `CiclistaId` (`CiclistaId` ASC) VISIBLE,
  CONSTRAINT `resultados_ibfk_1`
    FOREIGN KEY (`EtapaId`)
    REFERENCES `carreraciclismo`.`etapas` (`IdEtapa`),
  CONSTRAINT `resultados_ibfk_2`
    FOREIGN KEY (`CiclistaId`)
    REFERENCES `carreraciclismo`.`ciclistas` (`IdCiclista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `carreraciclismo`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `carreraciclismo`.`ventas` (
  `id_venta` INT NOT NULL AUTO_INCREMENT,
  `valor` DOUBLE NULL DEFAULT NULL,
  PRIMARY KEY (`id_venta`))
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
