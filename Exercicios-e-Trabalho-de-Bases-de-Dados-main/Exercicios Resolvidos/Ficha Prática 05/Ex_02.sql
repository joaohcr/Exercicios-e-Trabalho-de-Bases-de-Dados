use master;
CREATE DATABASE Editor
--DROP DATABASE Editor; --Apagar a base de dados
USE Editor;

CREATE TABLE Livro (
    ISBN			CHAR(17)		PRIMARY KEY,--PRIMARY KEY
    titulo			VARCHAR(25)		NOT NULL,
	ed_numero		INTEGER			NOT NULL	DEFAULT 1,
	ed_data			DATETIME		NOT NULL,
	ed_exemplares	INTEGER			NOT NULL,--FLOAT(4,2)
	preco_venda		MONEY			NOT NULL,
	CHECK(ed_numero >=0),
	CHECK(ed_exemplares >0),
	CHECK(preco_venda >=0),
	CHECK(ISBN LIKE '[0-9][0-9][0-9]-[0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9]'),
);
--DROP TABLE Livro 

INSERT INTO Livro(ISBN, titulo,  ed_data, ed_exemplares, preco_venda)
VALUES('000-0-00-000000-0', 'abc', GETDATE(), 100, 10),
('000-0-00-000001-0','Bases de Dados', '2021-04-03',50, 20),('020-0-00-000002-0','Novas Bases de Dados', '2020-05-02',250, 15),('100-0-00-000003-0','Alice no Pais', '2021-1-03',500, 40),('100-0-00-000004-0','Aulas em Casa', '2021-04-03',300, 20);
SELECT * FROM Livro;

CREATE TABLE Livreiro(
	cod_livreiro	INTEGER IDENTITY(1,1),
	nome			VARCHAR(30)	NOT NULL,
	endereco		VARCHAR(50)	NOT NULL,
	PRIMARY KEY(cod_livreiro),
);
--DROP TABLE Livreiro

INSERT INTO Livreiro(nome, endereco)
VALUES
('aaa', 'eaaa'),
('bbb', 'ebbb'),
('ccc', 'eccc'),
('O meu Livreiro', 'Rua dos Livros - Porto'),('Setentrião', 'Rua Direita n1 - Vila Real'),('Papelaria Branco', 'Rua Direita n50 - Vila Real');
SELECT * FROM Livreiro;

CREATE TABLE Autor(
	cod_autor	INTEGER IDENTITY(1,1),
	nome		VARCHAR(30)	NOT NULL,
	apelido		VARCHAR(30)	NOT NULL,
	pseudonimo	VARCHAR(30),
	PRIMARY KEY(cod_autor),
);
--DROP TABLE Autor

INSERT INTO Autor(nome, apelido, pseudonimo)
VALUES ('autor 1', 'apelido 1', 'ap1'),
('João Henrique', 'Constâncio Rodrigues', 'zeca'),
('autor 3', 'apelido 3', 'ap3'),
('Manuel', 'António', 'Man'),('Jorge Jesus', 'Matos', 'JJ'),('Mariana', 'Antunes', 'Manita');
SELECT * FROM Autor;

INSERT INTO Autor(nome, apelido, pseudonimo)
VALUES
('Ana', 'Maria');
SELECT * FROM Autor;

CREATE TABLE Comprar(
	cod_livreiro	INTEGER		NOT NULL, 
	ISBN			CHAR(17)	NOT NULL,
	quantidade		INTEGER		NOT NULL	DEFAULT 1,
	data_compra		DATETIME	NOT NULL	DEFAULT getdate(),
	CHECK(quantidade > 0),
	PRIMARY KEY(cod_livreiro, ISBN, data_compra),
	FOREIGN KEY(cod_livreiro) REFERENCES Livreiro(cod_livreiro),
	FOREIGN KEY(ISBN) REFERENCES Livro(ISBN),
);
--DROP TABLE Comprar

SELECT * FROM Livro;
SELECT * FROM Livreiro;
SELECT * FROM Comprar;

INSERT INTO Comprar(cod_livreiro, ISBN, data_compra, quantidade)
VALUES
(1, '000-0-00-000000-0', GETDATE(), 12),
(2, '000-0-00-000000-0', '2021/04/12', 55),
(4, '000-0-00-000001-0', '2021-02-28', 12),(4, '100-0-00-000003-0', '2021/04/12', 60),(6, '100-0-00-000004-0', '2021-03-01', 25);

CREATE TABLE Escrever(
	cod_autor	INTEGER, 
	ISBN		CHAR(17),
	royalty		FLOAT		DEFAULT 0.1,
	PRIMARY KEY(cod_autor, ISBN),
	FOREIGN KEY(cod_autor) REFERENCES Autor(cod_autor),
	FOREIGN KEY(ISBN) REFERENCES Livro(ISBN),
	CHECK(royalty >= 0 AND royalty <= 1),
);
--DROP TABLE Escrever

INSERT INTO Escrever(cod_autor, ISBN, royalty)
VALUES
(2, '000-0-00-000000-0', 0.2),
(1, '000-0-00-000000-0', 0.4),
(5, '000-0-00-000001-0', 0.1),(7, '100-0-00-000004-0', 0.05),(3, '100-0-00-000003-0', 0.05);


SELECT * FROM Livro;
SELECT * FROM Autor;
SELECT * FROM Livreiro;
SELECT * FROM Comprar;
SELECT * FROM Escrever;