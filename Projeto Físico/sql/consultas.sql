---- Consultas ----
-- Group by/Having
-- Quantos ninja konoha tem?
SELECT nome_aldeia, COUNT(*) 
FROM NINJA 
GROUP BY nome_aldeia 
HAVING nome_aldeia = 'Konoha';

--Junção interna
-- Quem são os jounin?
SELECT * FROM JOUNIN J JOIN NINJA N ON N.rg_ninja = J.rg_ninja;

--Junção externa
-- Mostrar todos os ninjas + quais deles tem biju
SELECT * FROM NINJA n LEFT JOIN BIJU b ON n.rg_ninja = b.rg_ninja;

--Semi junção
-- Quais ninjas tem jutsu rank s?
SELECT primeiro_nome
FROM NINJA
WHERE rg_ninja IN (
  SELECT rg_ninja FROM JUTSU WHERE rank = 'S'
);

--Anti-junção
--Quais os ninjas que não tem biju
SELECT * FROM NINJA N 
LEFT JOIN BIJU B ON N.RG_NINJA = B.RG_NINJA 
WHERE B.RG_NINJA IS NULL; 

--Subconsulta do tipo escalar
-- Qual ninja que tem mais jutsus
SELECT n.primeiro_nome, n.nome_cla,
       (SELECT COUNT(*) 
        FROM JUTSU j 
        WHERE j.rg_ninja = n.rg_ninja) AS qtd_jutsus
FROM NINJA n
ORDER BY qtd_jutsus DESC
LIMIT 1;

--Subconsulta do tipo linha
--Qual ninja tem mais missões?
SELECT *
FROM (
    SELECT n.primeiro_nome, n.nome_aldeia
    FROM NINJA n
    JOIN NINJA_COMPOE_EQUIPE ce ON n.rg_ninja = ce.rg_ninja
    JOIN MISSAO m ON ce.equipe = m.equipe
    GROUP BY n.primeiro_nome, n.nome_aldeia
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS top_ninja;

--Subconsulta do tipo tabela
--Quais ninjas tem 2 jutsu?
SELECT *
FROM (
    SELECT n.primeiro_nome, n.nome_cla, COUNT(j.nome) AS qtd_jutsus
    FROM NINJA n
    LEFT JOIN JUTSU j ON n.rg_ninja = j.rg_ninja
    GROUP BY n.primeiro_nome, n.nome_cla
) AS tabela_jutsus
WHERE qtd_jutsus = 2;

--Operação de conjunto
--Quais os nomes de todos os ninjas e todas as bijus?
SELECT primeiro_nome AS nome
FROM NINJA
UNION
SELECT nome
FROM BIJU;