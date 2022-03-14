use master;
CREATE DATABASE Presidenciais;
--use master;
--DROP DATABASE Presidenciais; --Apagar a base de dados
USE Presidenciais;

CREATE TABLE Pessoas (
    numero_eleitor		INTEGER		NOT NULL,--PRIMARY KEY
    nome				VARCHAR(30)	NOT NULL,
    apelido				VARCHAR(30)	NOT NULL,
	nacionalidade		VARCHAR(30)	NOT NULL,
    data_nascimento		DATE		NOT NULL,
    PRIMARY KEY(numero_eleitor),
);
--DROP TABLE Pessoas 

CREATE TABLE Candidatos(
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    PRIMARY KEY(numero_candidato),
	FOREIGN KEY(numero_candidato) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Candidatos

CREATE TABLE Escritorios(
	numero_escritorio	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    PRIMARY KEY(numero_escritorio),
	FOREIGN KEY(numero_escritorio) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Escritorios

CREATE TABLE Candidatos_Escritorios(
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_escritorio	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    PRIMARY KEY(numero_candidato, numero_escritorio),
	FOREIGN KEY(numero_candidato) REFERENCES Candidatos(numero_candidato),
	FOREIGN KEY(numero_escritorio) REFERENCES Escritorios(numero_escritorio),
);
--DROP TABLE Candidatos_Escritorios

CREATE TABLE Presidentes(
	numero_presidente	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    idade				INTEGER		NOT NULL,
    PRIMARY KEY(numero_presidente),
	FOREIGN KEY(numero_presidente) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Presidentes

CREATE TABLE Vogais(
	numero_vogal	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
    PRIMARY KEY(numero_vogal),
	FOREIGN KEY(numero_vogal) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Vogais

CREATE TABLE Descricao(
	titulo		VARCHAR(30)	NOT NULL,--PRIMARY KEY
	descricao	VARCHAR(100),  
	PRIMARY KEY(titulo),
);
--DROP TABLE Descricao

CREATE TABLE Cargos(
	id_cargos	INTEGER		NOT NULL,--PRIMARY KEY
	titulo		VARCHAR(30)	NOT NULL,--FOREIGN KEY
	PRIMARY KEY(id_cargos),
	FOREIGN KEY(titulo) REFERENCES Descricao(titulo)
);
--DROP TABLE Cargos

CREATE TABLE Mesa_eleitoral(
	id_mesa_eleitoral	INTEGER		NOT NULL,--PRIMARY KEY
	titulo				VARCHAR(30)	NOT NULL, 
	localizacao			VARCHAR(30)	NOT NULL, 
	PRIMARY KEY(id_mesa_eleitoral),	
);
--DROP TABLE Mesa_eleitoral

CREATE TABLE Orcamento(
	id_cargos	INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	orcamento	MONEY	NOT NULL,
	PRIMARY KEY(id_cargos),
	FOREIGN KEY(id_cargos) REFERENCES Cargos(id_cargos),
);
--DROP TABLE Orcamento

CREATE TABLE Candidatura(
	id_cargos			INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_candidato	INTEGER NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_candidatura	DATE    NOT NULL,--PRIMARY KEY
	PRIMARY KEY(id_cargos, numero_candidato, data_candidatura),
	FOREIGN KEY(id_cargos) REFERENCES Orcamento(id_cargos),
	FOREIGN KEY(numero_candidato) REFERENCES Candidatos(numero_candidato),
);
--DROP TABLE Candidatura

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

CREATE TABLE Local_votar(
	numero_eleitor	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	local_votar		VARCHAR(50)	NOT NULL,
	PRIMARY KEY(numero_eleitor),
	FOREIGN KEY(numero_eleitor) REFERENCES Pessoas(numero_eleitor),
);
--DROP TABLE Local_votar

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

CREATE TABLE Numero_votos(
	numero_candidato	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_votos		INTEGER		NOT NULL,
	PRIMARY KEY(numero_candidato),
	FOREIGN KEY(numero_candidato) REFERENCES Candidatos(numero_candidato),
);
--DROP TABLE Numero_votos

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

CREATE TABLE Hora_participar(
	data_participar		DATE	NOT NULL,--PRIMARY KEY
	hora_participar		TIME	NOT NULL,
	PRIMARY KEY(data_participar),
);
--DROP TABLE Hora_participar

CREATE TABLE Participar(
	numero_presidente	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_vogal_a		INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	numero_vogal_b		INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	id_mesa_eleitoral	INTEGER		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	data_participar		DATE		NOT NULL,--PRIMARY KEY e FOREIGN KEY
	PRIMARY KEY(numero_presidente, numero_vogal_a, numero_vogal_b, id_mesa_eleitoral),
	FOREIGN KEY(numero_vogal_a) REFERENCES Vogais(numero_vogal),
	FOREIGN KEY(numero_vogal_b) REFERENCES Vogais(numero_vogal),
	FOREIGN KEY(id_mesa_eleitoral) REFERENCES Mesa_eleitoral(id_mesa_eleitoral),
	FOREIGN KEY(data_participar) REFERENCES Hora_participar(data_participar),
);
--DROP TABLE Participar