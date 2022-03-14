use master;
/*
	Linhas comentadas
*/
CREATE DATABASE Biblioteca;
--use master;
--DROP DATABASE Biblioteca; --Apagar a base de dados
USE Biblioteca;

CREATE TABLE Aluno(
	numero   INTEGER     NOT NULL,  --PRIMARY KEY
	nome     VARCHAR(30) NOT NULL,
	garantia MONEY       NOT NULL DEFAULT 0,
	end_mor  VARCHAR(50) NOT NULL,
	end_CP   VARCHAR(8)  NOT NULL,
	end_loc  VARCHAR(20) NOT NULL,
	PRIMARY KEY(numero),
	CHECK(garantia >=0)
);
--DROP TABLE Aluno

CREATE TABLE Livro(
	numero      INTEGER     NOT NULL,  --PRIMARY KEY
	titulo      VARCHAR(20) NOT NULL,
	autor       VARCHAR(40) NOT NULL,
	editor	    VARCHAR(20) NOT NULL,
	data_compra DATE        NOT NULL,
	estado      BIT         NOT NULL  DEFAULT 0,
	PRIMARY KEY(numero)
);
--DROP TABLE Livro

CREATE TABLE Emprestimo(
	num_aluno INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	num_livro INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_req  DATE    NOT NULL DEFAULT GETDATE(),--PRIMARY KEY, GETDATE() --> Data atual
	data_ent  DATE, --Opcional não é necessário colocar NULL
	PRIMARY KEY(num_aluno, num_livro, data_req),
	FOREIGN KEY(num_aluno) REFERENCES Aluno(numero),
	FOREIGN KEY(num_livro) REFERENCES Livro(numero),
	CHECK(data_ent > data_req)
);
--DROP TABLE Emprestimo

select * from Aluno;
INSERT INTO Aluno(numero, nome, garantia, end_mor, end_CP, end_loc)
VALUES(12345, 'Nome do Aluno 1', 10, 'Morada 1', '5000-001', 'Vila Real 1')

INSERT INTO Aluno(numero, nome, garantia, end_mor, end_CP, end_loc)
VALUES
(12352, 'Nome do Aluno 2', 10, 'Morada 2', '5000-002', 'Vila Real 2'),
(12353, 'Nome do Aluno 3', 10, 'Morada 3', '5000-003', 'Vila Real 2'),
(12354, 'Nome do Aluno 4', 10, 'Morada 4', '5000-004', 'Vila Real 4'),
(12355, 'Nome do Aluno 5', 10, 'Morada 5', '5000-005', 'Vila Real 5')

--DELETE FROM Aluno --> elimina todas as linhas do aluno

/*
DELETE FROM Aluno
WHERE numero = 12355 -->Elimina apenas o identificado
*/

/*
DELETE FROM Aluno
WHERE numero = 12355 --> Elimina apenas a(s) linha(s) identificada(s) com esse elemento
*/

/*
UPDATE Aluno
SET garantia = 20 --> Altera a garantia em todos os alunos
-----------------
WHERE end_loc = 'Vila Real 2' --> Altera a garantia apaenas no tipo que tenha end_loc = 'Vila Real 2'
select * from Aluno;
*/

select * from Livro;
INSERT INTO Livro(numero, titulo, autor, editor, data_compra, estado)
VALUES
(1001, 'Base de Dados 1', 'João', 'Editora Maior 1', '2021/04/15', 0),
(1002, 'Base de Dados 2', 'Toni', 'Editora Maior 2', '2021/04/14', 0),
(1003, 'Base de Dados 3', 'Joni', 'Editora Maior 3', '2021/04/13', 0),
(1004, 'Base de Dados 4', 'Jota', 'Editora Maior 4', '2021/04/12', 0)
-- DELETE FROM Livro

select * from Emprestimo;
INSERT INTO Emprestimo(num_aluno, num_livro, data_req)
VALUES
(12345, 1001, '2021/04/15'),
(12353, 1002, '2021/04/15')
-- DELETE FROM Emprestimo

select * from Aluno;
select * from Livro;
select * from Emprestimo;