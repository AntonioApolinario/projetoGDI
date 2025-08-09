---- Consultas ----
-- Group by/Having
-- Quantos ninja konoha tem?
SELECT
    NOME_ALDEIA,
    COUNT(*)
FROM
    NINJA
GROUP BY
    NOME_ALDEIA
HAVING
    NOME_ALDEIA = 'Konoha';

--Junção interna
-- Quem são os jounin?
SELECT
    N.PRIMEIRO_NOME
FROM
    JOUNIN J
INNER JOIN
    NINJA N ON N.RG_NINJA = J.RG_NINJA;

--Junção externa
-- Mostrar todos os ninjas + quais deles tem biju
SELECT
    *
FROM
    NINJA N
LEFT JOIN
    BIJU B ON N.RG_NINJA = B.RG_NINJA;

--Semi junção
-- Quais ninjas tem jutsu rank s?
SELECT
    PRIMEIRO_NOME
FROM
    NINJA
WHERE
    RG_NINJA IN (
        SELECT
            RG_NINJA
        FROM
            JUTSU
        WHERE
            RANK = 'S'
    );

--Anti-junção
--Quais os ninjas que não tem biju
SELECT
    N.*
FROM
    NINJA N
LEFT JOIN
    BIJU B ON N.RG_NINJA = B.RG_NINJA
WHERE
    B.RG_NINJA IS NULL;

--Subconsulta do tipo escalar
--Quais missões pagaram mais que a média?
SELECT
    DESCRICAO,
    RECOMPENSA
FROM
    MISSAO
WHERE
    RECOMPENSA > (
        SELECT
            AVG(RECOMPENSA)
        FROM
            MISSAO
    );

--Subconsulta do tipo linha
-- Ninjas que moram e tem o mesmo clã
-- do ninja de rg = '000000006' (Tobirama)
SELECT
    N.PRIMEIRO_NOME,
    N.CODINOME
FROM
    NINJA N
WHERE
    (N.NOME_CLA, N.NOME_ALDEIA) = (
        SELECT
            NOME_CLA,
            NOME_ALDEIA
        FROM
            NINJA
        WHERE
            RG_NINJA = '000000006'
    );

--Subconsulta do tipo tabela
--Qual/quais ninja/ninjas tem mais jutsus?
SELECT
    N.PRIMEIRO_NOME,
    J.QTD_JUTSUS
FROM
    NINJA N
JOIN (
    SELECT
        RG_NINJA,
        COUNT(*) AS QTD_JUTSUS
    FROM
        JUTSU
    GROUP BY
        RG_NINJA
    HAVING
        COUNT(*) = (
            SELECT
                MAX(QTD)
            FROM (
                SELECT
                    COUNT(RG_NINJA) AS QTD
                FROM
                    JUTSU
                GROUP BY
                    RG_NINJA
            ) AS SUB
        )
) J ON N.RG_NINJA = J.RG_NINJA;

--Operação de conjunto
--Quais os nomes de todos os ninjas e todas as bijus?
SELECT
    PRIMEIRO_NOME AS NOME
FROM
    NINJA
UNION
SELECT
    NOME
FROM
    BIJU;