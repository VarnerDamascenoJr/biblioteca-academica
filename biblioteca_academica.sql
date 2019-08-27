

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `nome_categoria` VARCHAR(20) NULL,
  `descricao` VARCHAR(80) NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`livro` (
  `ISBN` INT NOT NULL auto_increment,
  `titulo` VARCHAR(30) NULL,
  `anoLancamento` DATE NOT NULL,
  `autor` VARCHAR(20) NULL,
  `editora` VARCHAR(15) NULL,
  `coAutor` VARCHAR(20) NULL,
  `quantLivro` INT NULL,
  `dia_emprestimo` DATE NULL,
  `dia_entrega` DATE NULL,
  `categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`ISBN`, `categoria_idcategoria`),
  UNIQUE INDEX `ISBN_UNIQUE` (`ISBN` ASC),
  INDEX `fk_livro_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_livro_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `mydb`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autor` (
  `CPF` INT NULL,
  `nome` VARCHAR(20) NULL,
  `nacionalidade` VARCHAR(45) NULL,
  `idautor` INT NOT NULL,
  PRIMARY KEY (`idautor`),
  UNIQUE INDEX `idautor_UNIQUE` (`idautor` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`curso` (
  `cod_Curso` INT NOT NULL AUTO_INCREMENT,
  `nomeCurso` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_Curso`),
  UNIQUE INDEX `cod_Curso_UNIQUE` (`cod_Curso` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno` (
  `matricula` INT NOT NULL AUTO_INCREMENT,
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
    REFERENCES `mydb`.`curso` (`cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`funcionario` (
  `matricula` INT NOT NULL,
  `nome` VARCHAR(20) NULL,
  `endereco` VARCHAR(15) NULL,
  `cargaHora` INT NULL,
  PRIMARY KEY (`matricula`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `usuario` INT NULL,
  `aluno_matricula` INT NOT NULL,
  `aluno_curso_cod_Curso` INT NOT NULL,
  `funcionario_matricula` INT NOT NULL,
  PRIMARY KEY (`idtipo_usuario`, `aluno_matricula`, `aluno_curso_cod_Curso`, `funcionario_matricula`),
  UNIQUE INDEX `idtipo_usuario_UNIQUE` (`idtipo_usuario` ASC),
  INDEX `fk_tipo_usuario_aluno1_idx` (`aluno_matricula` ASC, `aluno_curso_cod_Curso` ASC),
  INDEX `fk_tipo_usuario_funcionario1_idx` (`funcionario_matricula` ASC),
  CONSTRAINT `fk_tipo_usuario_aluno1`
    FOREIGN KEY (`aluno_matricula` , `aluno_curso_cod_Curso`)
    REFERENCES `mydb`.`aluno` (`matricula` , `curso_cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_usuario_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor` (
  `mat_siap` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `endereco` VARCHAR(15) NULL,
  `cod_Curso` INT NULL,
  `data_contratacao` DATE NULL,
  `cargaHora` INT NULL,
  `curso_cod_Curso` INT NOT NULL,
  `tipo_usuario_idtipo_usuario` INT NOT NULL,
  PRIMARY KEY (`mat_siap`, `curso_cod_Curso`, `tipo_usuario_idtipo_usuario`),
  UNIQUE INDEX `mat_siap_UNIQUE` (`mat_siap` ASC),
  INDEX `fk_professor_curso1_idx` (`curso_cod_Curso` ASC),
  INDEX `fk_professor_tipo_usuario1_idx` (`tipo_usuario_idtipo_usuario` ASC),
  CONSTRAINT `fk_professor_curso1`
    FOREIGN KEY (`curso_cod_Curso`)
    REFERENCES `mydb`.`curso` (`cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_tipo_usuario1`
    FOREIGN KEY (`tipo_usuario_idtipo_usuario`)
    REFERENCES `mydb`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone` (
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
    REFERENCES `mydb`.`aluno` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_telefone_professor1`
    FOREIGN KEY (`professor_mat_siap`)
    REFERENCES `mydb`.`professor` (`mat_siap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`regime_de_trabalho`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`regime_de_trabalho` (
  `idregime_de_trabalho` INT NOT NULL AUTO_INCREMENT,
  `regime_de_trabalho` VARCHAR(4) NULL,
  `professor_mat_siap` INT NOT NULL,
  `funcionario_matricula` INT NOT NULL,
  PRIMARY KEY (`idregime_de_trabalho`, `professor_mat_siap`, `funcionario_matricula`),
  INDEX `fk_regime_de_trabalho_professor1_idx` (`professor_mat_siap` ASC),
  INDEX `fk_regime_de_trabalho_funcionario1_idx` (`funcionario_matricula` ASC),
  CONSTRAINT `fk_regime_de_trabalho_professor1`
    FOREIGN KEY (`professor_mat_siap`)
    REFERENCES `mydb`.`professor` (`mat_siap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_regime_de_trabalho_funcionario1`
    FOREIGN KEY (`funcionario_matricula`)
    REFERENCES `mydb`.`funcionario` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`autor_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`autor_has_livro` (
  `autor_idautor` INT NOT NULL AUTO_INCREMENT,
  `livro_ISBN` INT NOT NULL,
  `livro_categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`autor_idautor`, `livro_ISBN`, `livro_categoria_idcategoria`),
  INDEX `fk_autor_has_livro_livro1_idx` (`livro_ISBN` ASC, `livro_categoria_idcategoria` ASC),
  INDEX `fk_autor_has_livro_autor1_idx` (`autor_idautor` ASC),
  CONSTRAINT `fk_autor_has_livro_autor1`
    FOREIGN KEY (`autor_idautor`)
    REFERENCES `mydb`.`autor` (`idautor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_autor_has_livro_livro1`
    FOREIGN KEY (`livro_ISBN` , `livro_categoria_idcategoria`)
    REFERENCES `mydb`.`livro` (`ISBN` , `categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`professor_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`professor_has_livro` (
  `professor_mat_siap` INT NOT NULL AUTO_INCREMENT,
  `professor_curso_cod_Curso` INT NOT NULL,
  `professor_tipo_usuario_idtipo_usuario` INT NOT NULL,
  `livro_ISBN` INT NOT NULL,
  `livro_categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`professor_mat_siap`, `professor_curso_cod_Curso`, `professor_tipo_usuario_idtipo_usuario`, `livro_ISBN`, `livro_categoria_idcategoria`),
  INDEX `fk_professor_has_livro_livro1_idx` (`livro_ISBN` ASC, `livro_categoria_idcategoria` ASC),
  INDEX `fk_professor_has_livro_professor1_idx` (`professor_mat_siap` ASC, `professor_curso_cod_Curso` ASC, `professor_tipo_usuario_idtipo_usuario` ASC),
  CONSTRAINT `fk_professor_has_livro_professor1`
    FOREIGN KEY (`professor_mat_siap` , `professor_curso_cod_Curso` , `professor_tipo_usuario_idtipo_usuario`)
    REFERENCES `mydb`.`professor` (`mat_siap` , `curso_cod_Curso` , `tipo_usuario_idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_professor_has_livro_livro1`
    FOREIGN KEY (`livro_ISBN` , `livro_categoria_idcategoria`)
    REFERENCES `mydb`.`livro` (`ISBN` , `categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`aluno_has_livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`aluno_has_livro` (
  `aluno_matricula` INT NOT NULL AUTO_INCREMENT,
  `aluno_curso_cod_Curso` INT NOT NULL,
  `livro_ISBN` INT NOT NULL,
  `livro_categoria_idcategoria` INT NOT NULL,
  PRIMARY KEY (`aluno_matricula`, `aluno_curso_cod_Curso`, `livro_ISBN`, `livro_categoria_idcategoria`),
  INDEX `fk_aluno_has_livro_livro1_idx` (`livro_ISBN` ASC, `livro_categoria_idcategoria` ASC),
  INDEX `fk_aluno_has_livro_aluno1_idx` (`aluno_matricula` ASC, `aluno_curso_cod_Curso` ASC),
  CONSTRAINT `fk_aluno_has_livro_aluno1`
    FOREIGN KEY (`aluno_matricula` , `aluno_curso_cod_Curso`)
    REFERENCES `mydb`.`aluno` (`matricula` , `curso_cod_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_aluno_has_livro_livro1`
    FOREIGN KEY (`livro_ISBN` , `livro_categoria_idcategoria`)
    REFERENCES `mydb`.`livro` (`ISBN` , `categoria_idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

#----------------------------------------------------------------------------------------------------------
#------------------------VIEWS-----------------------------------------------------------------------------

CREATE VIEW vw_listar01 AS
SELECT livro.titulo AS Título,
       categoria.nome_categoria AS Categoria,
       livro.editora AS Editora,
       livro.anoLancamento AS Ano_publicacao
FROM livro INNER JOIN categoria ON livro.categoria_idcategoria = categoria.idcategoria;

#-------

CREATE VIEW vw_listar02 AS
SELECT autor.nome AS Autor,
       livro.titulo AS Título
FROM autor INNER JOIN autor_has_livro ON autor.idautor = autor_has_livro.autor_idautor
		   INNER JOIN livro           ON autor_has_livro.livro_ISBN = livro.ISBN;

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

CREATE VIEW vw_listar06 AS
SELECT livro.titulo AS Título,
	   livro.dia_emprestimo AS Dia_saida,
       livro.dia_entrega AS Dia_entrega,
       livro.ISBN AS ISBN,
       professor.nome AS Professor
FROM professor INNER JOIN professor_has_livro ON professor.mat_siap = professor_has_livro.professor_mat_siap
			   INNER JOIN livro               ON professor_has_livro.livro_ISBN = livro.ISBN;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
