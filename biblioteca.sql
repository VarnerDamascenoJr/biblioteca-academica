-- Author: Varnerdjr@gmail.com


SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `biblioteca` DEFAULT CHARACTER SET utf8 ;
USE `biblioteca` ;

-- -----------------------------------------------------
-- Table `biblioteca`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`categoria` (
  `idcategoria` INT NOT NULL,
  `nome_categoria` VARCHAR(20) NULL,
  `descricao` VARCHAR(80) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`livro` (
  `ISBN` INT NOT NULL,
  `titulo` VARCHAR(30) NULL,
  `anoLancamento` DATE NOT NULL,
  `autor` VARCHAR(20) NULL,
  `editora` VARCHAR(15) NULL,
  `coAutor` VARCHAR(20) NULL,
  `quantLivro` INT NULL,
  `dia_emprestimo` DATE NULL,
  `dia_entrega` DATE NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC),
  INDEX `fk_livro_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_livro_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `biblioteca`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`autor` (
  `CPF` INT NULL,
  `nome` VARCHAR(20) NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `idautor` INT NOT NULL,
  PRIMARY KEY (`idautor`),
  UNIQUE INDEX `idautor_UNIQUE` (`idautor` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`curso` (
  `cod_Curso` INT NOT NULL,
  `nomeCurso` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_Curso`),
  UNIQUE INDEX `cod_Curso_UNIQUE` (`cod_Curso` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`aluno` (
  `matricula` INT NOT NULL,
  `nome` VARCHAR(20) NULL,
  `endereco` VARCHAR(15) NULL,
  `id_Curso` VARCHAR(45) NULL,
  `data_Entrada` DATE NULL,
  `data_Saida` DATE NULL,
  `curso_cod_Curso` INT NOT NULL,
  PRIMARY KEY (`matricula`, `curso_cod_Curso`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC),
  INDEX `fk_aluno_curso1_idx` (`curso_cod_Curso` ASC),
  CONSTRAINT `fk_aluno_curso1`
    FOREIGN KEY (`curso_cod_Curso`)
    REFERENCES `biblioteca`.`curso` (`cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`professor` (
  `mat_siap` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(15) NULL,
  `cod_Curso` INT NULL,
  `data_contratacao` DATE NULL,
  `cargaHora` INT NULL,
  `curso_cod_Curso` INT NOT NULL,
  PRIMARY KEY (`mat_siap`, `curso_cod_Curso`),
  UNIQUE INDEX `mat_siap_UNIQUE` (`mat_siap` ASC),
  INDEX `fk_professor_curso1_idx` (`curso_cod_Curso` ASC),
  CONSTRAINT `fk_professor_curso1`
    FOREIGN KEY (`curso_cod_Curso`)
    REFERENCES `biblioteca`.`curso` (`cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`funcionario` (
  `matricula` INT NOT NULL,
  `nome` VARCHAR(20) NULL,
  `endereco` VARCHAR(15) NULL,
  `cargaHora` INT NULL,
  PRIMARY KEY (`matricula`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`telefone` (
  `idtelefone` INT NOT NULL AUTO_INCREMENT,
  `numero` INT NULL,
  `funcionario_matricula` INT NOT NULL,
  `aluno_matricula` INT NOT NULL,
  `professor_mat_siap` INT NOT NULL,
  PRIMARY KEY (`idtelefone`, `funcionario_matricula`, `aluno_matricula`, `professor_mat_siap`),
  UNIQUE INDEX `idtelefone_UNIQUE` (`idtelefone` ASC),
  INDEX `fk_telefone_funcionario1_idx` (`funcionario_matricula` ASC),
  INDEX `fk_telefone_aluno1_idx` (`aluno_matricula` ASC),
  INDEX `fk_telefone_professor1_idx` (`professor_mat_siap` ASC),
  CONSTRAINT `fk_telefone_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_aluno1`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `biblioteca`.`aluno` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_professor1`
    FOREIGN KEY (`professor_mat_siap`)
    REFERENCES `biblioteca`.`professor` (`mat_siap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`regime_de_trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`regime_de_trabalho` (
  `idregime_de_trabalho` INT NOT NULL,
  `regime_de_trabalho` VARCHAR(4) NULL,
  `professor_mat_siap` INT NOT NULL,
  `funcionario_matricula` INT NOT NULL,
  PRIMARY KEY (`idregime_de_trabalho`, `professor_mat_siap`, `funcionario_matricula`),
  INDEX `fk_regime_de_trabalho_professor1_idx` (`professor_mat_siap` ASC),
  INDEX `fk_regime_de_trabalho_funcionario1_idx` (`funcionario_matricula` ASC),
  CONSTRAINT `fk_regime_de_trabalho_professor1`
    FOREIGN KEY (`professor_mat_siap`)
    REFERENCES `biblioteca`.`professor` (`mat_siap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_regime_de_trabalho_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `biblioteca`.`funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL,
  `usuario` INT NULL,
  PRIMARY KEY (`idtipo_usuario`),
  UNIQUE INDEX `idtipo_usuario_UNIQUE` (`idtipo_usuario` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`livro_has_autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`livro_has_autor` (
  `livro_ISBN` INT NOT NULL,
  `autor_idautor` INT NOT NULL,
  PRIMARY KEY (`livro_ISBN`, `autor_idautor`),
  INDEX `fk_livro_has_autor_autor1_idx` (`autor_idautor` ASC),
  INDEX `fk_livro_has_autor_livro_idx` (`livro_ISBN` ASC),
  CONSTRAINT `fk_livro_has_autor_livro`
    FOREIGN KEY (`livro_ISBN`)
    REFERENCES `biblioteca`.`livro` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_livro_has_autor_autor1`
    FOREIGN KEY (`autor_idautor`)
    REFERENCES `biblioteca`.`autor` (`idautor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`aluno_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`aluno_has_livro` (
  `aluno_matricula` INT NOT NULL,
  `aluno_curso_cod_Curso` INT NOT NULL,
  `livro_ISBN` INT NOT NULL,
  PRIMARY KEY (`aluno_matricula`, `aluno_curso_cod_Curso`, `livro_ISBN`),
  INDEX `fk_aluno_has_livro_livro1_idx` (`livro_ISBN` ASC),
  INDEX `fk_aluno_has_livro_aluno1_idx` (`aluno_matricula` ASC, `aluno_curso_cod_Curso` ASC),
  CONSTRAINT `fk_aluno_has_livro_aluno1`
    FOREIGN KEY (`aluno_matricula` , `aluno_curso_cod_Curso`)
    REFERENCES `biblioteca`.`aluno` (`matricula` , `curso_cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_has_livro_livro1`
    FOREIGN KEY (`livro_ISBN`)
    REFERENCES `biblioteca`.`livro` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `biblioteca`.`professor_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `biblioteca`.`professor_has_livro` (
  `professor_mat_siap` INT NOT NULL,
  `professor_curso_cod_Curso` INT NOT NULL,
  `livro_ISBN` INT NOT NULL,
  PRIMARY KEY (`professor_mat_siap`, `professor_curso_cod_Curso`, `livro_ISBN`),
  INDEX `fk_professor_has_livro_livro1_idx` (`livro_ISBN` ASC),
  INDEX `fk_professor_has_livro_professor1_idx` (`professor_mat_siap` ASC, `professor_curso_cod_Curso` ASC),
  CONSTRAINT `fk_professor_has_livro_professor1`
    FOREIGN KEY (`professor_mat_siap` , `professor_curso_cod_Curso`)
    REFERENCES `biblioteca`.`professor` (`mat_siap` , `curso_cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_livro_livro1`
    FOREIGN KEY (`livro_ISBN`)
    REFERENCES `biblioteca`.`livro` (`ISBN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

---------------------ESPAÇO PARA A CRIAÇÃO DE VIEWS----------------------------------------

CREATE VIEW vw_listar01 AS
SELECT livro.titulo AS Título,
       categoria.nome_categoria AS Categoria,
       livro.editora AS Editora,
       livro.anoLancamento AS Ano_publicacao
FROM livro INNER JOIN categoria ON livro.categoria_idcategoria = categoria.idcategoria;

CREATE VIEW vw_listar05 AS
SELECT livro.titulo AS Título,
	   livro.editora AS Editora,
       categoria.nome_categoria AS Categoria
FROM livro INNER JOIN categoria ON livro.categoria_idcategoria = categoria.idcategoria; 

CREATE VIEW vw_listar04 AS
SELECT professor.nome AS Professor,
       curso.nomeCurso AS Curso
FROM professor INNER JOIN curso ON professor.curso_cod_Curso = curso.cod_Curso
ORDER BY Curso ASC;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
