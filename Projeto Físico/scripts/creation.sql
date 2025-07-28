-------------------
-- CRIAÇÃO DO BD --
-------------------

CREATE TABLE ALDEIA(NOME VARCHAR(20) PRIMARY KEY);

CREATE TABLE NINJA(
  RG_NINJA VARCHAR(9), 
  NOME_CLA VARCHAR(20), 
  PRIMEIRO_NOME VARCHAR (20),
  CODINOME VARCHAR(20),
  NOME_ALDEIA VARCHAR(20),
  RIVAL_RG VARCHAR(20),
  PRIMARY KEY (RG_NINJA),
  FOREIGN KEY (RIVAL_RG) REFERENCES NINJA(RG_NINJA),
  FOREIGN KEY (NOME_ALDEIA) REFERENCES ALDEIA(NOME)
);

CREATE TYPE RANK AS ENUM ('D', 'C', 'B', 'A', 'S', 'SS');
CREATE TYPE ELEMENTO AS ENUM (
  'KATON',   -- Fogo
  'SUITON',  -- Água
  'DOTON',   -- Terra
  'FUUTON',  -- Vento
  'RAITON',  -- Raio
  'MOKUTON', -- Madeira
  'YOTON',   -- Lava
  'HYOTON',  -- Gelo
  'RANTON',  -- Tempestade
  'JITON',   -- Magnetismo
  'SHOTON',  -- Cristal
  'FUTTON',  -- Vapor
  'ENTON',   -- Chama negra
  'BAKUTON'  -- Explosão
);

CREATE TABLE JUTSU(
  RG_NINJA VARCHAR(9), 
  NOME VARCHAR (40), 
  ELEMENTO ELEMENTO,
  RANK RANK,
  PRIMARY KEY(RG_NINJA, NOME),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

--Heranças
CREATE TABLE HOKAGE(
  RG_NINJA VARCHAR(9),
  DATA_INICIO DATE,
  DATA_FIM DATE,
  PRIMARY KEY (RG_NINJA),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

CREATE TABLE JOUNIN(
  RG_NINJA VARCHAR(9),
  PRIMARY KEY (RG_NINJA),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

CREATE TABLE CHUNNIN(
  RG_NINJA VARCHAR(9),
  PRIMARY KEY (RG_NINJA),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

CREATE TABLE GENNIN(
  RG_NINJA VARCHAR(9),
  PRIMARY KEY (RG_NINJA),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

-- Tabela 1:1
CREATE TABLE BIJU(
  NOME VARCHAR(20),
  APELIDO VARCHAR(20),
  RG_NINJA VARCHAR(9) UNIQUE,
  PRIMARY KEY (NOME),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA)
);

CREATE TABLE EQUIPE(NUMERO INTEGER PRIMARY KEY);

-- Tabelas de entidade fraca
CREATE TABLE MISSAO(
  EQUIPE INTEGER,
  DATA_FINALIZACAO DATE,
  RANK RANK,
  RECOMPENSA NUMERIC(10,2),
  DESCRICAO VARCHAR(300),
  PRIMARY KEY (EQUIPE, DATA_FINALIZACAO),
  FOREIGN KEY (EQUIPE) REFERENCES EQUIPE(NUMERO)
);

CREATE TABLE NINJA_COMPOE_EQUIPE(
  RG_NINJA VARCHAR(9),
  EQUIPE INTEGER,
  PRIMARY KEY (RG_NINJA, EQUIPE),
  FOREIGN KEY (RG_NINJA) REFERENCES NINJA(RG_NINJA),
  FOREIGN KEY (EQUIPE) REFERENCES EQUIPE(NUMERO)
);

-- Tabela entidade associativa
CREATE TABLE EXAME_CHUNNIN(
  EXAMINADOR_RG VARCHAR(9),
  EXAMINADO_RG VARCHAR(9),
  PRIMARY KEY (EXAMINADOR_RG, EXAMINADO_RG),
  FOREIGN KEY (EXAMINADOR_RG) REFERENCES JOUNIN(RG_NINJA),
  FOREIGN KEY (EXAMINADO_RG) REFERENCES GENNIN(RG_NINJA)
);

CREATE TABLE CHUNNIN_ASSISTE(
  CHUNNIN_RG VARCHAR(9),
  EXAMINADOR_RG VARCHAR(9),
  EXAMINADO_RG VARCHAR(9),
  PRIMARY KEY (CHUNNIN_RG, EXAMINADOR_RG, EXAMINADO_RG),
  FOREIGN KEY (CHUNNIN_RG) REFERENCES CHUNNIN(RG_NINJA),
  FOREIGN KEY (EXAMINADOR_RG, EXAMINADO_RG) REFERENCES EXAME_CHUNNIN(EXAMINADOR_RG, EXAMINADO_RG)
);

-- Tabela relação n-ária
CREATE TABLE JOUNIN_AVALIA_GENNIN(
  EXAMINADO_RG VARCHAR(9),
  EXAMINADOR_RG VARCHAR(9),
  EQUIPE INTEGER,
  DATA_FINALIZACAO_MISSAO DATE,
  PRIMARY KEY (EXAMINADO_RG, EXAMINADOR_RG, EQUIPE, DATA_FINALIZACAO_MISSAO),
  FOREIGN KEY (EXAMINADO_RG) REFERENCES GENNIN(RG_NINJA),
  FOREIGN KEY (EXAMINADOR_RG) REFERENCES JOUNIN(RG_NINJA),
  FOREIGN KEY (EQUIPE, DATA_FINALIZACAO_MISSAO) REFERENCES MISSAO(EQUIPE, DATA_FINALIZACAO)
);

INSERT INTO ALDEIA (NOME) VALUES
('Konoha'),
('Sunagakure'),
('Kumogakure'),
('Kirigakure'),
('Iwagakure');

INSERT INTO NINJA (RG_NINJA, NOME_CLA, PRIMEIRO_NOME, CODINOME, NOME_ALDEIA, RIVAL_RG) VALUES
  ('000000001', 'Uzumaki', 'Naruto', 'Ninja Laranja', 'Konoha', '000000002'),('000000002', 'Uchiha', 'Sasuke', 'Avenger', 'Konoha', '000000001'),('000000003', 'Haruno', 'Sakura', 'Punho de Aço', 'Konoha', NULL),('000000004', 'Hatake', 'Kakashi', 'Ninja Copiador', 'Konoha', NULL),
  ('000000005', 'Sarutobi', 'Hiruzen', 'Sandaime', 'Konoha', NULL),
  ('000000006', 'Senju', 'Tobirama', 'Nidaime', 'Konoha', NULL),
  ('000000007', 'Senju', 'Hashirama', 'Shodai', 'Konoha', NULL),
  ('000000008', 'Namikaze', 'Minato', 'Relâmpago Amarelo', 'Konoha', NULL),
  ('000000009', 'Gaara', 'Sabaku', 'Gaara do Deserto', 'Sunagakure', NULL),
  ('000000010', 'Killer', 'Bee', 'Jinchuuriki 8 Caudas', 'Kumogakure', NULL),
  ('000000011', 'Nara', 'Shikamaru', 'Mestre das Sombras', 'Konoha', NULL),
  ('000000012', 'Akimichi', 'Choji', 'Punho de Mil Quilos', 'Konoha', NULL),
  ('000000013', 'Inuzuka', 'Kiba', 'Fera de Konoha', 'Konoha', NULL),
  ('000000014', 'Aburame', 'Shino', 'Mestre dos Insetos', 'Konoha', NULL),
  ('000000015', 'Hyuuga', 'Neji', 'Prodígio do Byakugan', 'Konoha', NULL),
  ('000000016', 'Umino', 'Iruka', 'Instrutor', 'Konoha', NULL);

INSERT INTO GENNIN (RG_NINJA) VALUES
 ('000000001'), 
 ('000000002'), 
 ('000000003');

INSERT INTO JOUNIN (RG_NINJA) VALUES ('000000004');

INSERT INTO HOKAGE (RG_NINJA, DATA_INICIO, DATA_FIM) VALUES
  ('000000005', '1970-01-01', '2002-10-10'),
  ('000000008', '2002-10-10', '2003-10-10');


INSERT INTO EQUIPE (NUMERO) VALUES (7);

INSERT INTO NINJA_COMPOE_EQUIPE (RG_NINJA, EQUIPE) VALUES
('000000001', 7),
('000000002', 7),
('000000003', 7),
('000000004', 7);

INSERT INTO MISSAO (EQUIPE, DATA_FINALIZACAO, RANK, RECOMPENSA, DESCRICAO) VALUES
  (7, '2003-03-01', 'C', 500.00, 'Proteção ao construtor de pontes Tazuna'),
  (7, '2003-04-15', 'B', 2000.00, 'Captura de bandidos no País das Ondas');

INSERT INTO JUTSU (RG_NINJA, NOME, ELEMENTO, RANK) VALUES
  ('000000001', 'Rasengan', 'FUUTON', 'A'),
  ('000000001', 'Kage Bunshin', 'FUUTON', 'B'),
  ('000000002', 'Chidori', 'RAITON', 'A'),
  ('000000002', 'Amaterasu', 'ENTON', 'S'),
  ('000000003', 'Chakra Enhanced Strength', 'DOTON', 'B'),
  ('000000004', 'Raikiri', 'RAITON', 'S'),
  ('000000004', 'Kamui', 'RAITON', 'SS'),
  ('000000007', 'Mokuton Hijutsu', 'MOKUTON', 'SS'),
  ('000000009', 'Sabaku Kyuu', 'DOTON', 'A'),
  ('000000010', 'Tailed Beast Bomb', 'RAITON', 'SS');

INSERT INTO BIJU (NOME, APELIDO, RG_NINJA) VALUES
  ('Kurama', 'Kyuubi', '000000001'),
  ('Shukaku', 'Ichibi', '000000009'),
  ('Gyuki', 'Hachibi', '000000010'),
  ('Matatabi', 'Nibi', NULL),
  ('Isobu', 'Sanbi', NULL),
  ('Son Gokū', 'Yonbi', NULL),
  ('Kokuo', 'Gobi', NULL),
  ('Saiken', 'Rokubi', NULL),
  ('Chomei', 'Nanabi', NULL),
  ('Juubi', 'Dez Caudas', NULL);

INSERT INTO EXAME_CHUNNIN (EXAMINADOR_RG, EXAMINADO_RG) VALUES
('000000004', '000000001'),
('000000004', '000000002');

INSERT INTO CHUNNIN (RG_NINJA) VALUES ('000000016');

INSERT INTO CHUNNIN_ASSISTE (CHUNNIN_RG, EXAMINADOR_RG, EXAMINADO_RG) VALUES
  ('000000016', '000000004', '000000001'),
  ('000000016', '000000004', '000000002');

INSERT INTO JOUNIN_AVALIA_GENNIN (EXAMINADO_RG, EXAMINADOR_RG, EQUIPE, DATA_FINALIZACAO_MISSAO) VALUES
  ('000000001', '000000004', 7, '2003-03-01'),
  ('000000002', '000000004', 7, '2003-03-01');





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

--Procedure
CREATE OR REPLACE PROCEDURE listar_jutsus_ninja(p_rg VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE r RECORD;
BEGIN
    RAISE NOTICE 'Jutsus do ninja %:', p_rg;

    FOR r IN
        SELECT nome, elemento, rank
        FROM JUTSU
        WHERE rg_ninja = p_rg
    LOOP
        RAISE NOTICE ' - Nome: %, Elemento: %, Rank: %', r.nome, r.elemento, r.rank;
    END LOOP;
END;
$$;

--Function
CREATE OR REPLACE FUNCTION contar_missoes_ninja(p_rg VARCHAR)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE qtd INT;
BEGIN
    SELECT COUNT(*) INTO qtd
    FROM NINJA_COMPOE_EQUIPE ce
    JOIN MISSAO m ON ce.equipe = m.equipe
    WHERE ce.rg_ninja = p_rg;

    RETURN qtd;
END;
$$;

--Trigger
CREATE TABLE LOG_NINJA (
    id SERIAL PRIMARY KEY,
    rg_ninja VARCHAR(9),
    data_insercao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE FUNCTION log_novo_ninja()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO LOG_NINJA(rg_ninja) VALUES (NEW.rg_ninja);
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_log_ninja
AFTER INSERT ON NINJA
FOR EACH ROW
EXECUTE FUNCTION log_novo_ninja();