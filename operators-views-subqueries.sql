SELECT * FROM curso;
SELECT * FROM categoria;

SELECT * FROM curso WHERE categoria_id = 1 OR categoria_id = 2;

-- subquery

SELECT * FROM curso WHERE categoria_id IN (
	SELECT id FROM categoria WHERE nome NOT LIKE '% %'
);

SELECT categoria,
       numero_cursos
    FROM (
            SELECT categoria.nome AS categoria,
                COUNT(curso.id) AS numero_cursos
            FROM categoria
            JOIN curso ON curso.categoria_id = categoria.id
        GROUP BY categoria
    ) AS categoria_cursos
  WHERE numero_cursos > 3;

SELECT categoria.nome AS categoria,
       COUNT(curso.id) AS numero_cursos
    FROM categoria
    JOIN curso ON curso.categoria_id = categoria.id
GROUP BY categoria
    HAVING COUNT (curso.id) > 3;

 SELECT curso.nome,
        COUNT(aluno_curso.aluno_id) numero_alunos
    FROM curso
    JOIN aluno_curso ON aluno_curso.curso_id = curso.id
	GROUP BY 1
    HAVING COUNT(aluno_curso.aluno_id) > 2
ORDER BY numero_alunos DESC;

-- creating a view

SELECT * FROM vw_cursos_por_categoria;
DROP VIEW vw_cursos_por_categoria;

CREATE VIEW vw_cursos_por_categoria AS SELECT categoria.nome AS categoria,
       COUNT(curso.id) AS numero_cursos
    FROM categoria
    JOIN curso ON curso.categoria_id = categoria.id
	GROUP BY categoria
    HAVING COUNT (curso.id) > 3;

SELECT * FROM vw_cursos_progamacao;
DROP VIEW vw_cursos_progamacao;
CREATE VIEW vw_cursos_progamacao AS SELECT nome FROM curso WHERE categoria_id = 2;

SELECT categoria.id AS categoria_id, vw_cursos_por_categoria.*
		 FROM vw_cursos_por_categoria 
		 JOIN categoria ON categoria.nome = vw_cursos_por_categoria.categoria;












