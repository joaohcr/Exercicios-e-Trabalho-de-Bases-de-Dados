use master;
USE Presidenciais;

----------- Alterações tabelas 1ª fase ----------

/* Antes:
CREATE TABLE Escritorios(
	numero_escritorio	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    PRIMARY KEY(numero_escritorio),
	FOREIGN KEY(numero_escritorio) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Escritorios
*/

CREATE TABLE Escritorios(--Alterações!!!--
	numero_escritorio	INTEGER		NOT NULL,--PRIMARY KEY
    PRIMARY KEY(numero_escritorio),
);
--DROP TABLE Escritorios

/* Antes:
CREATE TABLE Mandatario(
	numero_eleitor			INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	id_candidatura			INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_candidato		INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_candidatura		DATE    NOT NULL,--PRIMARY KEY e FOREIGN KEY
	PRIMARY KEY(numero_eleitor, id_candidatura, numero_candidato, data_candidatura),
	FOREIGN KEY(numero_eleitor) REFERENCES Pessoas(numero_eleitor),
	FOREIGN KEY(id_candidatura, numero_candidato,data_candidatura) REFERENCES Candidatura(id_cargos, numero_candidato,data_candidatura),
);
--DROP TABLE Mandatario
*/

CREATE TABLE Mandatario(--Alterações!!!--
	numero_eleitor			INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	id_candidatura			INTEGER NOT NULL,--FOREIGN KEY
	numero_candidato		INTEGER NOT NULL,--FOREIGN KEY
	data_candidatura		DATE    NOT NULL,--FOREIGN KEY
	PRIMARY KEY(numero_eleitor),
	FOREIGN KEY(numero_eleitor) REFERENCES Pessoas(numero_eleitor),
	FOREIGN KEY(id_candidatura, numero_candidato,data_candidatura) REFERENCES Candidatura(id_cargos, numero_candidato,data_candidatura),
);
--DROP TABLE Mandatario

/* Antes:
CREATE TABLE Votar(
    numero_eleitor		INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	id_candidatura		INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_candidatura	DATE		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_votar			DATE		NOT NULL,--PRIMARY KEY
	PRIMARY KEY(numero_eleitor, id_candidatura, numero_candidato, data_candidatura, data_votar),
	FOREIGN KEY(numero_eleitor) REFERENCES Local_votar(numero_eleitor),
	FOREIGN KEY(id_candidatura, numero_candidato, data_candidatura) REFERENCES Candidatura(id_cargos, numero_candidato, data_candidatura),
);
--DROP TABLE Votar
*/

CREATE TABLE Votar(--Alterações!!!--
    numero_eleitor		INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	id_candidatura		INTEGER		NOT NULL,--FOREIGN KEY
	numero_candidato	INTEGER		NOT NULL,--FOREIGN KEY
	data_candidatura	DATE		NOT NULL,--FOREIGN KEY
	data_votar			DATETIME	NOT NULL,--PRIMARY KEY
	PRIMARY KEY(numero_eleitor, data_votar),
	FOREIGN KEY(numero_eleitor) REFERENCES Local_votar(numero_eleitor),
	FOREIGN KEY(id_candidatura, numero_candidato, data_candidatura) REFERENCES Candidatura(id_cargos, numero_candidato, data_candidatura),
);
--DROP TABLE Votar

/* Antes:
CREATE TABLE Data_fim_assumir(
	data_inicio		DATE	NOT NULL,--PRIMARY KEY
	data_fim		DATE,
	PRIMARY KEY(data_inicio),
);
--DROP TABLE Data_fim_assumir

CREATE TABLE Assumir(
    id_cargos			INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_inicio			DATE		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	PRIMARY KEY(id_cargos, numero_candidato, data_inicio),
	FOREIGN KEY(id_cargos) REFERENCES Cargos(id_cargos),
	FOREIGN KEY(numero_candidato) REFERENCES Numero_votos(numero_candidato),
	FOREIGN KEY(data_inicio) REFERENCES Data_fim_assumir(data_inicio),
);
--DROP TABLE Assumir
*/

CREATE TABLE Assumir(--Alterações!!!--
    id_cargos			INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_inicio			DATE		NOT NULL,--PRIMARY KEY
	data_fim			DATE,
	PRIMARY KEY(id_cargos, numero_candidato, data_inicio),
	FOREIGN KEY(id_cargos) REFERENCES Cargos(id_cargos),
	FOREIGN KEY(numero_candidato) REFERENCES Numero_votos(numero_candidato),
);
--DROP TABLE Assumir

/* Antes:
CREATE TABLE Data_fim_presidir(
	data_inicio		DATE	NOT NULL,--PRIMARY KEY
	data_fim		DATE,
	PRIMARY KEY(data_inicio),
);
--DROP TABLE Data_fim_presidir

CREATE TABLE Presidir(
    id_mesa_eleitoral	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_presidente	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_inicio			DATE		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	PRIMARY KEY(id_mesa_eleitoral, numero_presidente, data_inicio),
	FOREIGN KEY(id_mesa_eleitoral) REFERENCES Mesa_eleitoral(id_mesa_eleitoral),
	FOREIGN KEY(numero_presidente) REFERENCES Presidentes(numero_presidente),
	FOREIGN KEY(data_inicio) REFERENCES Data_fim_presidir(data_inicio),
);
--DROP TABLE Presidir
*/

CREATE TABLE Presidir(--Alterações!!!--
    id_mesa_eleitoral	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_presidente	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_inicio			DATE		NOT NULL,--PRIMARY KEY
	data_fim			DATE,
	PRIMARY KEY(id_mesa_eleitoral, numero_presidente, data_inicio),
	FOREIGN KEY(id_mesa_eleitoral) REFERENCES Mesa_eleitoral(id_mesa_eleitoral),
	FOREIGN KEY(numero_presidente) REFERENCES Presidentes(numero_presidente),
);
--DROP TABLE Presidir

-------- Inserir registos em cada tabela --------

SELECT * FROM Pessoas;
INSERT INTO Pessoas(numero_eleitor, nome, apelido, nacionalidade, data_nascimento)
VALUES	(1,  'Nome1',  'Apelido1',  'Espanhol',   '1958-03-07'),--Candidatos
		(2,  'Nome2',  'Apelido2',  'Americano',  '1969-10-14'),--Candidatos
		(3,  'Nome3',  'Apelido3',  'Alemão',     '1988-08-22'),--Candidatos
		(4,  'Nome4',  'Apelido4',  'Italiano',   '1975-01-29'),--Candidatos
		(5,  'Nome5',  'Apelido5',  'Brasileiro', '1960-07-02'),--Candidatos
		(6,  'Nome6',  'Apelido6',  'Português',  '1951-06-13'),--Candidatos
		(7,  'Nome7',  'Apelido7',  'Português',  '1973-09-18'),--Presidentes
		(8,  'Nome8',  'Apelido8',  'Português',  '1957-11-03'),--Presidentes
		(9,  'Nome9',  'Apelido9',  'Português',  '1970-05-12'),--Presidentes
		(10, 'Nome10', 'Apelido10', 'Português',  '1957-03-07'),--Vogais
		(11, 'Nome11', 'Apelido11', 'Português',  '1966-10-14'),--Vogais
		(12, 'Nome12', 'Apelido12', 'Português',  '1968-10-14'),--Vogais
		(13, 'Nome13', 'Apelido13', 'Português',  '1985-08-22'),--Vogais
		(14, 'Nome14', 'Apelido14', 'Português',  '1973-01-29'),--Vogais
		(15, 'Nome15', 'Apelido15', 'Português',  '1964-07-02'),--Vogais
		(16, 'Nome16', 'Apelido16', 'Português',  '1959-06-13'),--Mandatário
		(17, 'Nome17', 'Apelido17', 'Português',  '1981-09-18'),--Mandatário
		(18, 'Nome18', 'Apelido18', 'Português',  '1969-11-03'),--Mandatário
		(19, 'Nome19', 'Apelido19', 'Português',  '1959-12-06'),--Eleitor
		(20, 'Nome20', 'Apelido2O', 'Português',  '1981-05-26'),--Eleitor
		(21, 'Nome21', 'Apelido21', 'Português',  '1959-10-08'),--Eleitor
		(22, 'Nome22', 'Apelido22', 'Português',  '1969-02-23'),--Eleitor
		(23, 'Nome23', 'Apelido23', 'Português',  '1979-11-28');--Eleitor
--DELETE FROM Pessoas

SELECT * FROM Candidatos;
INSERT INTO Candidatos(numero_candidato)
VALUES	(1),
		(2),
		(3),
		(4),
		(5),
		(6);
--DELETE FROM Candidatos

SELECT * FROM Escritorios; --Alterações nas Colunas da Tabela!!!--
INSERT INTO Escritorios(numero_escritorio)
VALUES	(1),
		(2),
		(3),
		(4);
--DELETE FROM Escritorios

SELECT * FROM Candidatos_Escritorios;
INSERT INTO Candidatos_Escritorios(numero_candidato, numero_escritorio)
VALUES	(1, 1),
		(2, 2),
		(3, 3),
		(4, 3),
		(5, 4),
		(6, 4);
--DELETE FROM Candidatos_Escritorios

SELECT * FROM Presidentes;
INSERT INTO Presidentes(numero_presidente, idade)
VALUES	(7, 47),
		(8, 63),
		(9, 51);
--DELETE FROM Presidentes

SELECT * FROM Vogais;
INSERT INTO Vogais(numero_vogal)
VALUES	(10),
		(11),
		(12),
		(13),
		(14),
		(15);
--DELETE FROM Vogais

SELECT * FROM Descricao;
INSERT INTO Descricao(titulo, descricao)
VALUES	('Moderador', 'Pessoa que dirige uma mesa-redonda, um debate ou uma discussão em grupo.'),
		('Deputado', 'Representante do povo eleito para o parlamento.'),
		('Tesoureiro', 'Encarregado de efetuar as operações monetárias de um banco, de uma empresa, associação, etc.');
--DELETE FROM Descricao

SELECT * FROM Cargos;
INSERT INTO Cargos(id_cargos, titulo)
VALUES	(1, 'Moderador'),
		(2, 'Deputado'),
		(3, 'Tesoureiro');
--DELETE FROM Cargos

SELECT * FROM Mesa_eleitoral;
INSERT INTO Mesa_eleitoral(id_mesa_eleitoral, titulo, localizacao)
VALUES	(1, 'Mesa eleitoral de Vila Real', 'Vila Real'),
		(2, 'Mesa eleitoral do Porto', 'Porto'),
		(3, 'Mesa eleitoral de Lisboa', 'Lisboa');
--DELETE FROM Mesa_eleitoral

SELECT * FROM Orcamento;
INSERT INTO Orcamento(id_cargos, orcamento)
VALUES	(1, 2000),
		(2, 4000),
		(3, 3000);
--DELETE FROM Orcamento

SELECT * FROM Candidatura;
INSERT INTO Candidatura(id_cargos, numero_candidato, data_candidatura)
VALUES	(1, 1,'2021-01-16'),
		(3, 1,'2021-01-18'),
		(2, 2,'2021-01-23'),
		(3, 2,'2021-01-24'),
		(1, 3,'2021-02-03'),
		(2, 4,'2021-02-11'),
		(3, 4,'2021-02-12'),
		(2, 5,'2021-03-22'),
		(3, 6,'2021-03-14');
--DELETE FROM Candidatura

SELECT * FROM Mandatario; --Alterações nas Colunas da Tabela!!!--
INSERT INTO Mandatario(numero_eleitor, id_candidatura, numero_candidato, data_candidatura)
VALUES	(16, 1, 1,'2021-01-16'),
		(17, 3, 2,'2021-01-24'),
		(18, 3, 6,'2021-03-14');
--DELETE FROM Mandatario

SELECT * FROM Local_votar;
INSERT INTO Local_votar(numero_eleitor, local_votar)
VALUES	(19, 'Vila Real'),
		(22, 'Vila Real'),
		(23, 'Vila Real'),
		(20, 'Porto'),
		(21, 'Lisboa');
--DELETE FROM Local_votar

SELECT * FROM Votar; --Alterações nas Colunas da Tabela!!!--
INSERT INTO Votar(numero_eleitor, id_candidatura, numero_candidato, data_candidatura, data_votar)
--Por causa do 'hoje' é necessário alterar o data_votar para o dia de 
--hoje pois não se pode colocar getdate() por causa que se o colocássemos todas
--as pessoas votariam todas ao mesmo tempo e neste caso não nos é pedido isso.
VALUES	(19, 1, 1, '2021-01-16', '2021-06-11 09:30:10'),
		(22, 2, 2, '2021-01-23', '2021-06-11 10:22:27'),
		(23, 2, 5, '2021-03-22', '2021-06-11 16:46:56'),
		(20, 3, 4, '2021-02-12', '2021-06-11 13:24:30'),
		(21, 3, 6, '2021-03-14', '2021-06-11 16:56:45');
--DELETE FROM Votar

SELECT * FROM Numero_votos;
INSERT INTO Numero_votos(numero_candidato, numero_votos)
VALUES	(1, 32),
		(2, 67),
		(3, 40),
		(4, 27),
		(5, 15),
		(6, 59);
--DELETE FROM Numero_votos

SELECT * FROM Assumir; --Alterações nas Colunas da Tabela!!!--
INSERT INTO Assumir(id_cargos, numero_candidato, data_inicio, data_fim)
VALUES	(1, 1,'2021-04-20', '2023-02-15'),
		(2, 2,'2021-04-04', '2022-04-04');
INSERT INTO Assumir(id_cargos, numero_candidato, data_inicio)
VALUES	(3, 6,'2021-05-10');
--DELETE FROM Assumir

SELECT * FROM Presidir; --Alterações nas Colunas da Tabela!!!--
INSERT INTO Presidir(id_mesa_eleitoral, numero_presidente, data_inicio, data_fim)
VALUES	(1, 7, '2021-04-15', '2021-04-18'),
		(2, 7, '2021-04-20', '2021-04-23'),
		(3, 7, '2021-04-25', '2021-04-28'),
		(1, 8, '2021-05-01', '2021-05-03'),
		(2, 8, '2021-05-05', '2021-06-08'),
		(3, 8, '2021-05-10', '2021-05-13');
INSERT INTO Presidir(id_mesa_eleitoral, numero_presidente, data_inicio)
VALUES	(3, 9, '2021-05-21');
--DELETE FROM Presidir

SELECT * FROM Hora_participar;
INSERT INTO Hora_participar(data_participar, hora_participar)
VALUES	('2021-04-15', '09:30:00'),
		('2021-04-20', '09:30:00'),
		('2021-04-25', '09:30:00'),
		('2021-05-01', '09:00:00'),
		('2021-05-05', '09:00:00'),
		('2021-05-10', '09:00:00'),
		('2021-05-21', '10:00:00');
--DELETE FROM Hora_participar

SELECT * FROM Participar;
INSERT INTO Participar(numero_presidente, numero_vogal_a, numero_vogal_b, id_mesa_eleitoral, data_participar)
VALUES	(7, 10, 11, 1, '2021-04-15'),
		(7, 10, 11, 2, '2021-04-20'),
		(7, 10, 11, 3, '2021-04-25'),
		(8, 12, 13, 1, '2021-05-01'),
		(8, 12, 13, 2, '2021-05-05'),
		(8, 12, 13, 3, '2021-05-10'),
		(9, 14, 15, 3, '2021-05-21');
--DELETE FROM Participar

-------------------------------------------------------
----------------------ALL SELECT-----------------------
SELECT * FROM Pessoas;
SELECT * FROM Candidatos;
SELECT * FROM Escritorios;
SELECT * FROM Candidatos_Escritorios;
SELECT * FROM Presidentes;
SELECT * FROM Vogais;
SELECT * FROM Descricao;
SELECT * FROM Cargos;
SELECT * FROM Mesa_eleitoral;
SELECT * FROM Orcamento;
SELECT * FROM Candidatura;
SELECT * FROM Mandatario;
SELECT * FROM Local_votar;
SELECT * FROM Votar;
SELECT * FROM Numero_votos;
SELECT * FROM Assumir;
SELECT * FROM Presidir;
SELECT * FROM Hora_participar;
SELECT * FROM Participar;
-------------------------------------------------------

---------Resposta ás questões propostas em SQL---------

--2.1. Qual o último cargo assumido? 
--[Cargos (título), DataInicio, Candidato(Nome)]

SELECT titulo AS Cargos, data_inicio AS DataInicio, nome AS Candidato
FROM Cargos, Assumir, Pessoas, Candidatos
WHERE data_inicio = (SELECT MAX(data_inicio) FROM Assumir)
AND Cargos.id_cargos = Assumir.id_cargos
AND Assumir.numero_candidato = Candidatos.numero_candidato
AND Candidatos.numero_candidato = Pessoas.numero_eleitor

--2.2. Quantos vogais tem cada mesa eleitoral? 
--[Mesa (Titulo), N_Vogais]

SELECT titulo AS Mesa, (COUNT(numero_vogal_a) + COUNT(numero_vogal_b)) AS N_Vogais
FROM Mesa_eleitoral, Participar, (
	SELECT  MIN(data_participar) AS min_data_participar, id_mesa_eleitoral
	FROM Participar
	GROUP BY id_mesa_eleitoral)SQ1
WHERE Mesa_eleitoral.id_mesa_eleitoral = Participar.id_mesa_eleitoral
AND Participar.data_participar = SQ1.min_data_participar
GROUP BY titulo

--2.3. Quais as duas primeiras pessoas a votar hoje em Vila Real? 
--[Pessoas(nome)] 
--Por causa do 'hoje' é necessário alterar na tabela para o dia de 
--hoje pois não se pode colocar getdate() por causa que se o colocássemos todas
--as pessoas votariam todas ao mesmo tempo e neste caso não nos é pedido isso.

SELECT TOP 2 data_votar, (nome + ' ' + apelido) AS Nome
FROM Pessoas, Votar, Local_votar
WHERE Pessoas.numero_eleitor = Votar.numero_eleitor
AND Votar.numero_eleitor = Local_votar.numero_eleitor
AND Local_votar.local_votar = 'Vila Real'
AND CAST (data_votar AS date) = CAST (GETDATE() AS date)
ORDER BY data_votar ASC

--2.4. Quais as pessoas que presidiram mais do que 2 mesas eleitorais nos últimos
--90 dias? Ordene-as alfabeticamente. 
--[Nome e Apelido, Titulo, Data]

SELECT nome, apelido, titulo, data_inicio--, data_fim
FROM Pessoas, Presidentes, Presidir, Mesa_eleitoral, (
	--Conta o numero de mesas presididas por cada presidente associando-as ao numero_eleitor
	SELECT numero_eleitor, COUNT(id_mesa_eleitoral) AS count_mesa_eleitoral
	FROM Pessoas, Presidentes, Presidir
	WHERE Pessoas.numero_eleitor = Presidentes.numero_presidente
	AND Presidentes.numero_presidente = Presidir.numero_presidente
	GROUP BY nome, apelido, numero_eleitor)SQ1
WHERE SQ1.count_mesa_eleitoral > 2
AND DATEDIFF(DD, data_inicio, GETDATE()) < 90
AND SQ1.numero_eleitor = Pessoas.numero_eleitor
AND Pessoas.numero_eleitor = Presidentes.numero_presidente
AND Presidentes.numero_presidente = Presidir.numero_presidente
AND Presidir.id_mesa_eleitoral = Mesa_eleitoral.id_mesa_eleitoral
GROUP BY nome, apelido, titulo, data_inicio--, data_fim
ORDER BY nome + apelido, data_inicio ASC

--2.5. Qual é o cargo com mais candidaturas? 
--[TítuloDoCargo, N_Candidaturas]

SELECT TOP 1 COUNT(*) AS N_Candidaturas, titulo AS TítuloDoCargo
FROM Cargos, Candidatura
WHERE Cargos.id_cargos = Candidatura.id_cargos
GROUP BY titulo
ORDER BY N_Candidaturas DESC

--2.6. Qual a nacionalidade e a que cargo se candidata o candidato mais novo?
--[Candidato (nome e apelido), Idade, Nacionalidade, CargoTitulo]

SELECT nome, apelido, (DATEDIFF(YY, data_nascimento, GETDATE())) AS Idade, nacionalidade, titulo AS CargoTitulo
FROM Pessoas, Candidatos, Candidatura, Cargos
WHERE data_nascimento = (SELECT MAX(data_nascimento) FROM Pessoas)
AND Pessoas.numero_eleitor = Candidatos.numero_candidato
AND Candidatos.numero_candidato = Candidatura.numero_candidato
AND Candidatura.id_cargos = Cargos.id_cargos
GROUP BY nome, apelido, data_nascimento, nacionalidade, titulo

--2.7. Qual o total dos orçamentos de todas as candidaturas de cada candidato?
--Ordene-os por ordem crescente. [Candidato (Nome), TotalGasto]

SELECT nome, SUM(orcamento) AS TotalGasto
FROM Pessoas, Orcamento, Candidatos, Candidatura
WHERE Pessoas.numero_eleitor = Candidatos.numero_candidato
AND Candidatos.numero_candidato = Candidatura.numero_candidato
AND Candidatura.id_cargos = Orcamento.id_cargos
GROUP BY nome
ORDER BY TotalGasto DESC