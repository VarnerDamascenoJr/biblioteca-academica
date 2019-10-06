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
FROM livro INNER JOIN professor_has_livro ON livro.ISBN = professor_has_livro.livro_ISBN;
