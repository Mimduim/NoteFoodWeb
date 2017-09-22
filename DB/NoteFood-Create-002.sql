drop schema notefood;
CREATE SCHEMA IF NOT EXISTS notefood DEFAULT CHARACTER SET utf8 ;
USE notefood ;

-- -----------------------------------------------------
-- Tabela USUARIO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.USUARIO (
  Usuario_Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Usuario_Nome VARCHAR(45) NOT NULL,
  Usuario_Email VARCHAR(45) NOT NULL,
  Usuario_DataNasc VARCHAR(45) NOT NULL,
  Usuario_Sexo CHAR(1) NOT NULL,
  Usuario_Peso FLOAT UNSIGNED NOT NULL,
  Usuario_Altura FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (Usuario_Id),
  UNIQUE INDEX USUARIO_ID_UNIQUE (Usuario_Id ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela REFEICAO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.REFEICAO (
  Refeicao_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Usuario_Id INT UNSIGNED NOT NULL,
  Refeicao_Nome VARCHAR(45) NOT NULL,
  Refeicao_Data VARCHAR(45) NOT NULL,
  Refeicao_Hora VARCHAR(45) NOT NULL,
  PRIMARY KEY (Refeicao_id),
  UNIQUE INDEX Refeicao_id_UNIQUE (Refeicao_id ASC),
  INDEX fk_REFEICAO_USUARIO1_idx (Usuario_Id ASC),
  CONSTRAINT fk_REFEICAO_USUARIO1
    FOREIGN KEY (Usuario_Id)
    REFERENCES notefood.USUARIO (Usuario_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela GRUPO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.GRUPO (
  Grupo_Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Grupo_Nome VARCHAR(45) NOT NULL,
  Grupo_Nutriente_Principal VARCHAR(45) NOT NULL,
  Grupo_Qt_Diaria_Recomendada INT NOT NULL,
  PRIMARY KEY (Grupo_Id),
  UNIQUE INDEX GRUPO_ID_UNIQUE (Grupo_Id ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela SUB_GRUPO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.SUB_GRUPO (
  Sub_Grupo_Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Sub_Grupo_Nome VARCHAR(45) NOT NULL,
  Grupo_Id INT UNSIGNED NOT NULL,
  PRIMARY KEY (Sub_Grupo_Id),
  UNIQUE INDEX SUB_GRUPO_ID_UNIQUE (Sub_Grupo_Id ASC),
  INDEX fk_SUB_GRUPO_GRUPO1_idx (Grupo_Id ASC),
  CONSTRAINT fk_SUB_GRUPO_GRUPO1
    FOREIGN KEY (Grupo_Id)
    REFERENCES notefood.GRUPO (Grupo_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela ALIMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.ALIMENTO (
  Alimento_Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  Alimento_Nome VARCHAR(45) NOT NULL,
  Alimento_Descrição VARCHAR(100) NOT NULL,
  Sub_Grupo_Id INT UNSIGNED NOT NULL,
  PRIMARY KEY (Alimento_Id),
  UNIQUE INDEX ALIMENTO_ID_UNIQUE (Alimento_Id ASC),
  INDEX fk_ALIMENTO_SUB_GRUPO1_idx (Sub_Grupo_Id ASC),
  CONSTRAINT fk_ALIMENTO_SUB_GRUPO1
    FOREIGN KEY (Sub_Grupo_Id)
    REFERENCES notefood.SUB_GRUPO (Sub_Grupo_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela CONSTRUTOR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.CONSTRUTOR (
  Alimento_Id INT UNSIGNED NOT NULL,
  Construtor_Qt_Proteina FLOAT NOT NULL,
  PRIMARY KEY (Alimento_Id),
  CONSTRAINT fk_CONSTRUTOR_ALIMENTO1
    FOREIGN KEY (Alimento_Id)
    REFERENCES notefood.ALIMENTO (Alimento_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela REGULADOR
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.REGULADOR (
  Alimento_Id INT UNSIGNED NOT NULL,
  Regulador_Qt_Fibra INT NOT NULL,
  PRIMARY KEY (Alimento_Id),
  CONSTRAINT fk_REGULADOR_ALIMENTO1
    FOREIGN KEY (Alimento_Id)
    REFERENCES notefood.ALIMENTO (Alimento_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela ENERGETICO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.ENERGETICO (
  Alimento_Id INT UNSIGNED NOT NULL,
  Energetico_Qt_Carboidrato FLOAT NOT NULL,
  PRIMARY KEY (Alimento_Id),
  CONSTRAINT fk_ENERGETICO_ALIMENTO1
    FOREIGN KEY (Alimento_Id)
    REFERENCES notefood.ALIMENTO (Alimento_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'C';


-- -----------------------------------------------------
-- Tabela ENERGETICO_EXTRA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.ENERGETICO_EXTRA (
  Alimento_Id INT UNSIGNED NOT NULL,
  Energetico_Extra_Qt_Permitida FLOAT NOT NULL,
  PRIMARY KEY (Alimento_Id),
  CONSTRAINT fk_ENERGETICO_EXTRA_ALIMENTO1
    FOREIGN KEY (Alimento_Id)
    REFERENCES notefood.ALIMENTO (Alimento_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabela ALIMENTO_SELECIONADO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS notefood.ALIMENTO_SELECIONADO (
  Alimento_Id INT UNSIGNED NOT NULL,
  Usuario_Id INT UNSIGNED NOT NULL,
  Refeicao_id INT UNSIGNED NOT NULL,
  INDEX fk_ALIMENTO_SELECIONADO_ALIMENTO1_idx (Alimento_Id ASC),
  INDEX fk_ALIMENTO_SELECIONADO_USUARIO1_idx (Usuario_Id ASC),
  INDEX fk_ALIMENTO_SELECIONADO_REFEICAO1_idx (Refeicao_id ASC),
  CONSTRAINT fk_ALIMENTO_SELECIONADO_ALIMENTO1
    FOREIGN KEY (Alimento_Id)
    REFERENCES notefood.ALIMENTO (Alimento_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ALIMENTO_SELECIONADO_USUARIO1
    FOREIGN KEY (Usuario_Id)
    REFERENCES notefood.USUARIO (Usuario_Id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_ALIMENTO_SELECIONADO_REFEICAO1
    FOREIGN KEY (Refeicao_id)
    REFERENCES notefood.REFEICAO (Refeicao_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Inserção de Grupos
-- -----------------------------------------------------

insert grupo (Grupo_Nome,Grupo_Nutriente_Principal,Grupo_Qt_Diaria_Recomendada) values
('Energético','Carboidrato', 9),
('Regulador','Fibra', 5),
('Construtor','Proteina', 2),
('Energético_Extra','Açucar', 2);

-- -----------------------------------------------------
-- Inserção de Sub_Grupos
-- -----------------------------------------------------

insert sub_grupo (Sub_Grupo_Nome,Grupo_Id) values

('Cereais',1),
('Paes',1),
('Massas',1),
('Tuberculos',1),
('Raizes',1),
('Hortaliças',2),
('Frutas',2),
('Leguminosas',3),
('Laticínios',3),
('Carnes_Ovos',3),
('Oleos_Gorduras',4),
('Açucares_Doces',4);

select * from sub_grupo;
