-- MySQL Script generated by MySQL Workbench
-- Thu Apr 15 13:00:08 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema eif209_2021_01
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `eif209_2021_01` ;

-- -----------------------------------------------------
-- Schema eif209_2021_01
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `eif209_2021_01` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci ;
USE `eif209_2021_01` ;

-- -----------------------------------------------------
-- Table `eif209_2021_01`.`area_tematica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`area_tematica` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`area_tematica` (
  `id_area` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`curso` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`curso` (
  `id_curso` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `area_tematica_id` INT NOT NULL,
  PRIMARY KEY (`id_curso`),
  INDEX `fk_curso_area_tematica1_idx` (`area_tematica_id` ASC),
  CONSTRAINT `fk_curso_area_tematica1`
    FOREIGN KEY (`area_tematica_id`)
    REFERENCES `eif209_2021_01`.`area_tematica` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`rol` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`rol` (
  `id_rol` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_rol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`usuario` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`usuario` (
  `id_usuario` VARCHAR(45) NOT NULL,
  `rol_id` INT NOT NULL,
  `clave` VARCHAR(45) NOT NULL,
  `ultimo_aceso` TIMESTAMP NOT NULL,
  `activo` TINYINT NOT NULL,
  PRIMARY KEY (`id_usuario`, `rol_id`),
  INDEX `fk_usuario_rol_idx` (`rol_id` ASC),
  CONSTRAINT `fk_usuario_rol`
    FOREIGN KEY (`rol_id`)
    REFERENCES `eif209_2021_01`.`rol` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`profesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`profesor` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`profesor` (
  `id_profesor` INT NOT NULL,
  `usuario_id` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_profesor`),
  INDEX `fk_profesor_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_profesor_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `eif209_2021_01`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`grupo` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`grupo` (
  `num_grupo` INT NOT NULL,
  `curso_id` INT NOT NULL,
  `profesor_id` INT NOT NULL,
  PRIMARY KEY (`num_grupo`, `curso_id`),
  INDEX `fk_grupo_curso1_idx` (`curso_id` ASC),
  INDEX `fk_grupo_profesor1_idx` (`profesor_id` ASC),
  CONSTRAINT `fk_grupo_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `eif209_2021_01`.`curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupo_profesor1`
    FOREIGN KEY (`profesor_id`)
    REFERENCES `eif209_2021_01`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`estudiante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`estudiante` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`estudiante` (
  `id_estudiante` INT NOT NULL,
  `usuario_id` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  INDEX `fk_estudiante_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_estudiante_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `eif209_2021_01`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`estado` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`estado` (
  `id_estado` INT NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`matricula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`matricula` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`matricula` (
  `estudiante_id` INT NOT NULL,
  `grupo_num` INT NOT NULL,
  `curso_id` INT NOT NULL,
  `estado_id` INT NOT NULL,
  `nota` INT NOT NULL,
  PRIMARY KEY (`estudiante_id`, `grupo_num`, `curso_id`),
  INDEX `fk_matricula_grupo1_idx` (`grupo_num` ASC, `curso_id` ASC),
  INDEX `fk_matricula_estado1_idx` (`estado_id` ASC),
  CONSTRAINT `fk_matricula_estudiante1`
    FOREIGN KEY (`estudiante_id`)
    REFERENCES `eif209_2021_01`.`estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_grupo1`
    FOREIGN KEY (`grupo_num` , `curso_id`)
    REFERENCES `eif209_2021_01`.`grupo` (`num_grupo` , `curso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `eif209_2021_01`.`estado` (`id_estado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`administrador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`administrador` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`administrador` (
  `id_administrador` INT NOT NULL,
  `usuario_id` VARCHAR(45) NOT NULL,
  `apellido1` VARCHAR(45) NOT NULL,
  `apellido2` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `e_mail` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_administrador`),
  INDEX `fk_administrador_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_administrador_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `eif209_2021_01`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`especialidad` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`especialidad` (
  `profesor_id_profesor` INT NOT NULL,
  `area_tematica_id` INT NOT NULL,
  PRIMARY KEY (`profesor_id_profesor`, `area_tematica_id`),
  INDEX `fk_especialidad_area_tematica1_idx` (`area_tematica_id` ASC),
  CONSTRAINT `fk_especialidad_profesor1`
    FOREIGN KEY (`profesor_id_profesor`)
    REFERENCES `eif209_2021_01`.`profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_especialidad_area_tematica1`
    FOREIGN KEY (`area_tematica_id`)
    REFERENCES `eif209_2021_01`.`area_tematica` (`id_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `eif209_2021_01`.`horario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `eif209_2021_01`.`horario` ;

CREATE TABLE IF NOT EXISTS `eif209_2021_01`.`horario` (
  `seq` INT NOT NULL AUTO_INCREMENT,
  `grupo_num` INT NOT NULL,
  `grupo_curso_id` INT NOT NULL,
  `dia` INT NOT NULL,
  `hora` INT NOT NULL,
  PRIMARY KEY (`seq`, `grupo_num`, `grupo_curso_id`),
  INDEX `fk_horario_grupo1_idx` (`grupo_num` ASC, `grupo_curso_id` ASC),
  CONSTRAINT `fk_horario_grupo1`
    FOREIGN KEY (`grupo_num` , `grupo_curso_id`)
    REFERENCES `eif209_2021_01`.`grupo` (`num_grupo` , `curso_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into rol(id_rol, descripcion) values(1, "Administrador");
insert into rol(id_rol, descripcion) values(2, "Profesor");
insert into rol(id_rol, descripcion) values(3, "Estudiante");
insert into usuario(id_usuario, rol_id, clave, ultimo_aceso, activo) 
    values("12345", 1, "qwerty", CURDATE(), 1);
insert into usuario(id_usuario, rol_id, clave, ultimo_aceso, activo) 
    values("6789", 1, "qaqaqa", CURDATE(), 1);
insert into usuario(id_usuario, rol_id, clave, ultimo_aceso, activo) 
    values("11111", 2, "qqqq", CURDATE(), 1);
insert into usuario(id_usuario, rol_id, clave, ultimo_aceso, activo) 
    values("1212", 3, "1111", CURDATE(), 1);
    
insert into administrador(id_administrador, usuario_id, apellido1, apellido2, nombre, telefono, e_mail)
        values(123456, "12345", "Barrientos", "Monge", "Joaquin", "1010911", "admin01@cursoslibres.com");
insert into administrador(id_administrador, usuario_id, apellido1, apellido2, nombre, telefono, e_mail)
        values(6789, "6789", "Sandoval", "Blandon", "Kathy", "0544245", "admin02@cursoslibres.com");
insert into profesor(id_profesor, usuario_id, apellido1, apellido2, nombre, telefono, e_mail)
        values(11111, "11111", "Elizondo", "Quesada", "Ramiro", "90909090", "profe01@cursoslibres.com");
insert into estudiante(id_estudiante, usuario_id, apellido1, apellido2, nombre, telefono, e_mail)
        values(1212, "1212", "Herrera", "Viquez", "Fulano", "666999666", "estudiante01@cursoslibres.com");


insert into estado (id_estado, descripcion) values(101, "Aprobado");
insert into estado (id_estado, descripcion) values(102, "En Progreso");
insert into estado (id_estado, descripcion) values(103, "Reprobado");


insert into area_tematica (id_area, descripcion) values (100, "Redes");
insert into area_tematica (id_area, descripcion) values (200, "Base de Datos");
insert into area_tematica (id_area, descripcion) values (300, "Idiomas");


insert into curso (id_curso, descripcion, area_tematica_id) values (2000, "Introduccion a Base de Datos",200);
insert into usuario(id_usuario, rol_id, clave, ultimo_aceso, activo) 
    values("437837123", 2, "profe", '2020-01-01 00:00:01', 1);

