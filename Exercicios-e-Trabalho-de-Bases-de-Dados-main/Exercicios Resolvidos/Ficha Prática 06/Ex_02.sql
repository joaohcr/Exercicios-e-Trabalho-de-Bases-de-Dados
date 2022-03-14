use master;
USE Editor;

--(a) Quais os autores registados?

SELECT * 
FROM Autor;

--(b) Quais os autores que tem pseudónimo?

SELECT * 
FROM Autor
WHERE pseudonimo is NOT NULL

--(c) Quantos livros existem registados?

SELECT count(*) AS N_Livros
FROM Livro;

--(d) Quantos livros escreveu o autor "Manuel António"?

SELECT COUNT(*) as 'NoLivros por Manuel Antonio'  FROM Escrever, Autor WHERE Escrever.Cod_Autor = Autor.Cod_Autor 
AND Nome = 'Manuel' AND Apelido = 'António';

--(e) Quais os livros disponíveis no livreiro "O Meu Livreiro"?

SELECT Livro.*, Livreiro.nome AS Livreiro 
FROM Comprar, Livreiro, Livro  
WHERE Livreiro.nome = 'O Meu Livreiro' 
AND Livreiro.cod_livreiro = Comprar.cod_livreiro 
AND Livro.ISBN = Comprar.ISBN;

--(e') Quais os livros disponíveis no livreiro "O Meu Livreiro"?
--[Titulo, Quantidade, Data]

SELECT Livro.Titulo, quantidade, data_compra
FROM Comprar, Livreiro, Livro  
WHERE Livreiro.nome = 'O Meu Livreiro' 
AND Livreiro.cod_livreiro = Comprar.cod_livreiro 
AND Livro.ISBN = Comprar.ISBN;

--(f) Quais os autores com livros disponíveis no livreiro "O Meu Livreiro"?
--[Nome, Apelido, Titulo]

SELECT Autor.Nome, Autor.Apelido, Livro.TituloFROM Comprar, Livreiro, Livro, Escrever, Autor WHERE Livreiro.nome = 'O Meu Livreiro' AND Livreiro.cod_livreiro = Comprar.cod_livreiro AND Comprar.ISBN = Livro.ISBNAND Livro.ISBN = Escrever.ISBNAND Autor.cod_autor = Escrever.cod_autor;

--(f') Quais os autores com livros disponíveis no livreiro "O Meu Livreiro"?
--[Nome, Apelido]

SELECT DISTINCT Autor.Nome, Autor.ApelidoFROM Comprar, Livreiro, Livro, Escrever, Autor WHERE Livreiro.nome = 'O Meu Livreiro' AND Livreiro.cod_livreiro = Comprar.cod_livreiro AND Comprar.ISBN = Livro.ISBNAND Livro.ISBN = Escrever.ISBNAND Autor.cod_autor = Escrever.cod_autor;

--(g) Quanto recebeu o autor "Manuel José" em royalties por todos os livros escritos?

select Escrever.royalty, Livro.preco_venda, Comprar.quantidade, (Escrever.royalty * Livro.preco_venda * Comprar.quantidade) AS Totalfrom Comprar, Livro, Escrever, Autor where Autor.nome LIKE 'Manuel'AND Autor.apelido LIKE 'António'AND Autor.cod_autor = Escrever.cod_autorAND Livro.ISBN = Escrever.ISBNAND Livro.ISBN = Comprar.ISBN

--(h) Em que livreiros existem livros do autor "Manuel António"?

SELECT DISTINCT Livreiro.NomeFROM Livreiro, Autor, Comprar, Escrever, LivroWHERE Livreiro.Cod_Livreiro = Comprar.Cod_LivreiroAND Comprar.ISBN = Livro.ISBNAND Escrever.ISBN = Livro.ISBNAND Escrever.Cod_Autor = Autor.Cod_AutorAND Autor.Nome = 'Manuel' AND Apelido = 'António';

--(i) Em que livreiros existe o livro com o título "Bases de Dados"?

SELECT DISTINCT Livreiro.nomeFROM Livro, Comprar, LivreiroWHERE Livro.titulo = 'Bases de Dados'AND Livro.ISBN = Comprar.ISBNAND Comprar.cod_livreiro = Livreiro.cod_livreiro


--(j) Apresente uma lista de todos os livros com o(s) respetivo(s) autor(es).

SELECT Livro.ISBN, Titulo, Nome, ApelidoFROM Livro, Autor, EscreverWHERE Livro.ISBN = Escrever.ISBNAND Escrever.Cod_Autor = Autor.Cod_Autor
ORDER BY Titulo, Apelido; --Ordenar pelos titulos seguido pela ordenação dos apelidos

--(k) Qual o livro mais encomendado por todos os livreiros?
--1: Somar cada livro para todos os livreiros

SELECT L.ISBN, L.Titulo, Nome as Livreiro, Total 
FROM Livro L, Livreiro,     
	-- Agrupa os livros por total e livreiro     
	(SELECT Cod_Livreiro, ISBN, SUM(Quantidade) as Total      
	FROM Comprar      
	GROUP BY Cod_Livreiro, ISBN) SQ1, 	 
		-- Seleciona o total maximo por livreiro 	
		(SELECT MAX(Total) as Maximo, Cod_Livreiro 	 
		FROM (SELECT Cod_Livreiro, ISBN, SUM(Quantidade) as Total      
	FROM Comprar      
	GROUP BY Cod_Livreiro, ISBN) SQ1  	 
		GROUP BY Cod_Livreiro) SQ2 
WHERE L.ISBN = SQ1.ISBN 
AND SQ1.Cod_Livreiro = Livreiro.Cod_Livreiro
AND SQ1.Total = SQ2.Maximo;

--(l) Qual o livro mais encomendado por cada um dos livreiros?
