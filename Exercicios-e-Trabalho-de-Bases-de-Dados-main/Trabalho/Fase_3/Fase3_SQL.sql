use master;
USE Presidenciais;

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

--1.Crie um procedimento que, dados o ID de uma Mesa Eleitoral e o Mês, apresente
--uma tabela com os pares de vogais que participaram em cada Mesa Eleitoral. O
--procedimento deve devolver o número total de pares distintos que participaram nas
--mesas eleitorais.

CREATE PROCEDURE Presencas_Vogais(@Mesa_ID INT, @Mes INT)
AS
BEGIN
SELECT titulo AS Mesa, Pessoas.nome, SQ1.nome
FROM Participar, Vogais, Pessoas, Mesa_eleitoral, (
	SELECT MIN(data_participar) AS min_data_participar, nome, id_mesa_eleitoral
	FROM Participar, Vogais, Pessoas
	WHERE Pessoas.numero_eleitor = Vogais.numero_vogal
	AND Vogais.numero_vogal = Participar.numero_vogal_b
	GROUP BY nome, id_mesa_eleitoral)SQ1
WHERE Pessoas.numero_eleitor = Vogais.numero_vogal
AND Vogais.numero_vogal = Participar.numero_vogal_a
AND Participar.id_mesa_eleitoral = Mesa_eleitoral.id_mesa_eleitoral
AND Participar.data_participar = SQ1.min_data_participar
GROUP BY titulo, Pessoas.nome, SQ1.nome
ORDER BY titulo

SELECT COUNT(DISTINCT(numero_vogal_a + numero_vogal_b)) AS N_Total_Pares
FROM Participar
--WHERE id_mesa_eleitoral = @Mesa_ID
--AND DATEPART(MONTH, data_participar) = @Mes
END
--DROP PROCEDURE Presencas_Vogais

--Exemplo:
EXECUTE Presencas_Vogais 3, 5

select * from Participar

-------------------------------------------------------

--2.Assumindo que todas as pessoas com mais de 18 anos podem votar, crie um
--procedimento que dado o número de eleitor do candidato, o cargo e a data da
--candidatura, para uma votação em curso, verifique a percentagem de pessoas que
--já participaram na votação.

CREATE PROCEDURE Percentagem_Votos(@NCandidato INT, @Cargo VARCHAR(10), @DataCandidatura DATE)
AS
BEGIN
SELECT ((COUNT(Votar.numero_eleitor)*100)/(SELECT COUNT(*) FROM Pessoas)) AS Percentagem
FROM Pessoas, Votar, Candidatura, Cargos, Candidatos
WHERE Pessoas.numero_eleitor = Votar.numero_eleitor
AND Candidatos.numero_candidato = @NCandidato
AND Cargos.titulo LIKE @Cargo
AND Candidatura.data_candidatura = @DataCandidatura
AND DATEDIFF(YY, Pessoas.data_nascimento, GETDATE()) >= 18
AND data_votar <= GETDATE()
END
--DROP PROCEDURE Percentagem_Votos

--Exemplo:
SELECT * FROM Votar;
EXECUTE Percentagem_Votos 2, 'Tesoureiro', '2021-01-24'

-------------------------------------------------------

--3.Assumindo que uma Pessoa não pode assumir dois cargos em simultâneo, crie um
--trigger que ao inserir um registo de um cargo para um candidato na tabela assumir
--automaticamente insira a mesma data como data de fim no cargo que o candidato
--anteriormente ocupava.

CREATE TRIGGER NewTrigger
ON Assumir
AFTER INSERT
AS
BEGIN
	DECLARE @num_Candidato INTEGER,
			@data_Inicio   DATE

	SELECT @num_Candidato = numero_candidato, @data_Inicio = data_inicio
	FROM inserted

	IF((SELECT COUNT(@num_Candidato) FROM Assumir) > 1)
	BEGIN
		UPDATE Assumir
		SET data_fim = @data_Inicio
		WHERE numero_candidato = @num_Candidato
		AND data_fim IS NULL
		AND data_Inicio = @data_Inicio
	END
END
--DROP TRIGGER NewTrigger

--Exemplo:
SELECT * FROM Assumir;
INSERT INTO Assumir(id_cargos, numero_candidato, data_inicio)
VALUES	(1, 6,'2021-06-11');
SELECT * FROM Assumir;