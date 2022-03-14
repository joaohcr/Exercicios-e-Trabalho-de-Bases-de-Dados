use master;
USE Biblioteca;

--SELECT Livro.* --Seleciona todos os atributos do livro

--(a) Quais os alunos inscritos na biblioteca?

SELECT numero, nome
FROM Aluno

--(b) Quais os alunos inscritos na biblioteca cujo nome come�a por "Jo�o"?

SELECT numero, nome
FROM Aluno
WHERE nome LIKE 'Jo�o%' --nome parecido com Jo�o + qualquer coisa

--(b2) Quais os alunos inscritos na biblioteca cujo tem "2"?

SELECT numero, nome
FROM Aluno
WHERE nome LIKE '%2%' --nome com qualquer coisa antes ou depois do 2

--(c) Qual o nome dos alunos com uma garantia igual ou superior a 10 Euros?

SELECT numero, nome, garantia
FROM Aluno
WHERE garantia >= 10

--(c2) Qual o nome dos alunos com uma garantia igual ou superior a 15 Euros?

SELECT numero, nome, garantia
FROM Aluno
WHERE garantia >= 15

--(c3) Qual o nome dos alunos com uma garantia entre 5 e 15 Euros?

SELECT numero, nome, garantia
FROM Aluno
WHERE garantia BETWEEN 5 AND 15

--(d) Quais os livros existentes na biblioteca?

SELECT numero, titulo, autor
FROM Livro

--(e) Qual o t�tulo dos livros escritos pelo autor com o nome "Manuel Ant�nio"?

SELECT numero, titulo, autor
FROM Livro
WHERE autor LIKE 'Manuel Ant�nio%'

--(e1) Qual o t�tulo dos livros escritos pelo autor com o nome "Joni"?

SELECT numero, titulo, autor
FROM Livro
WHERE autor = 'Joni' --quando o nome � apenas Joni

--(e1) Qual o t�tulo dos livros escritos pelo autor cujo nome tem "n"?

SELECT numero, titulo, autor
FROM Livro
WHERE autor LIKE '%n%' --quando o nome tem um n

--(f) Qual o estado dos livros que cont�m "Base de Dados" no t�tulo?

SELECT numero, titulo, autor, estado
FROM Livro
WHERE titulo LIKE '%Base de Dados%'

--(g) Qual o valor em caixa da biblioteca fruto das garantias dos alunos?

SELECT SUM(garantia) AS Valor_em_Caixa --Moma todas as garantias e d�lhe um nome a� coluna na tabela
FROM Aluno

--(a2) Quais os alunos inscritos na biblioteca?

SELECT numero, nome AS 'Nome dos Alunos' --A coluna 'nome' passou a chamar-se 'Nome dos Alunos'
FROM Aluno

--(h) Quais os livros requisitados pelo aluno "Jo�o Pedro"?

SELECT titulo 
FROM Emprestimo, Livro, Aluno
WHERE nome = 'Jo�o Pedro'
AND aluno.numero = emprestimo.num_aluno --(emprestimo).num_aluno s� havendo ambiguidade
AND num_livro = livro.numero

--(h2) Quais os livros requisitados pelo aluno terminados em "1"?

SELECT titulo 
FROM Emprestimo E, Livro L, Aluno A --Mudar o nome  das tabelas para ficarem mais dompactas
WHERE nome Like '%1'
AND A.numero = E.num_aluno --(E).num_aluno s� havendo ambiguidade
AND E.num_livro = L.numero
select * from Emprestimo;

--(i) Quantos livros foram requisitados no dia "22-05-2004"?

SELECT COUNT(*) AS Total_Empr�stimos
FROM Emprestimo
WHERE data_req Like '22-05-2004%'

--(i2) Quantos livros foram requisitados no dia "15-04-2021"?

SELECT COUNT(*) AS Total_Empr�stimos
FROM Emprestimo
WHERE data_req Like '2021-04-15%' --Formato da data do sistema 'ano-m�s-dia'

--(i3) Quantos livros foram requisitados no dia "15-04-2021"?

SELECT COUNT(data_ent) AS Total_Empr�stimos--cota os emprestimos que j� foram entregues, dentro do COUNT() podese colocar a coluna que queremos ou qualquer uma COUNT(*)
FROM Emprestimo
WHERE data_req Like '2021-04-15%' --Formato da data do sistema 'ano-m�s-dia'

--(j) Quantos livros est�o requisitados a mais de 5 dias?

SELECT COUNT(*) AS Livros_Fora_Mais_5_Dias
FROM Emprestimo
WHERE DATEDIFF(DAY,data_req,getdate()) > 5 --DATEDIFF diferen�a entre datas DATEDIFF(que tipo queremos comparar as diferen�as(dia,mes ou ano), data inicio, data fim (neste caso dia de hoje)), neste caso maior que 5 dias

--(k) Quantos livros requisitou o aluno com o n�mero "16954"?

SELECT COUNT(*) AS Livros_Requisitados
FROM Emprestimo
WHERE num_aluno = 16954

--(k2) Quantos livros requisitou o aluno com o n�mero "12345"?

SELECT COUNT(*) AS Livros_Requisitados
FROM Emprestimo
WHERE num_aluno = 12345

--(l) Quantos livros foram requisitados?

SELECT COUNT(DISTINCT(num_livro)) AS Livros_Requisitados --DISTINCT(num_livro) ignora os livros repetidos
FROM Emprestimo

--(m) Qual o primeiro livro requisitado?

SELECT TOP 1 Titulo --devolve po primeiro elemento
FROM Livro, Emprestimo
WHERE num_livro = Numero
ORDER BY data_req --ordena do menor para o maior

--(m2) Qual o primeiro livro requisitado?

SELECT Titulo
FROM Livro, Emprestimo
WHERE num_livro = Numero
AND data_req = (SELECT MIN(data_req) FROM Emprestimo) --(SELECT MIN(data_req) FROM Emprestimo) seleciona a menor data_req