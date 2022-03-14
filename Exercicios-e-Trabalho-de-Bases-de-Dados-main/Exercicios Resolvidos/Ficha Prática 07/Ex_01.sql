--Crie um stored procedure para efetuar cada uma das seguintes tarefas.
--(Nota: se possível reutilize os stored procedures criados.)

--(a) Dado o código de um livro e o valor do seu estado (requisitado – ‘1’; não
--requisitado – ‘0’) atualize o valor do estado desse livro.

use master
use Biblioteca

INSERT INTO Livro
VALUES (1005, 'Branca de Neve', 'Disney', 'Editora Disney', '1999-05-07', 0)

UPDATE Livro
SET estado = 1
WHERE numero = 1005

SELECT * FROM Livro

CREATE PROCEDURE setEstado(@codLivro INTEGER, @estado BIT)
AS
BEGIN
UPDATE Livro
SET estado = @estado
WHERE numero = @codLivro
END

EXECUTE setEstado 1001, 1
SELECT * FROM Livro

--(b) Dado o código de um livro verifique se este se encontra requisitado ou não.

CREATE PROCEDURE VerifyEstado (@Numero INTEGER)ASBEGIN	SELECT Estado	FROM Livro	WHERE Numero = @NumeroENDEXECUTE VerifyEstado 1005

CREATE PROCEDURE getEstado (@Numero INTEGER)ASBEGIN	DECLARE @estado INTEGER	SELECT @estado = Estado	FROM Livro	WHERE Numero = @Numero	RETURN @estadoENDDECLARE @_estado INTEGEREXECUTE @_estado = getEstado 1005PRINT @_estado--(c*) Dado o número de um aluno verifique QUANTOS LIVROS AINDA 
--é possível requisitar um livro, sabendo que tal só se verifica 
--caso o aluno tenha requisitado menos de garantia/5 livros.

CREATE PROCEDURE N_ReqsDisp (@NumeroAluno INTEGER)ASBEGIN	DECLARE @NReqs INTEGER	SELECT @NReqs = COUNT(E.num_livro)	FROM Aluno A, Emprestimo E	WHERE A.Numero = @NumeroAluno	AND A.Numero = E.num_aluno	AND E.Data_Ent IS NULL		SELECT @NReqs = (FLOOR(A.Garantia/5) - @NReqs)	FROM Aluno A	WHERE A.Numero = @NumeroAluno	RETURN @NReqsEND
--DROP PROCEDURE N_ReqsDisp

DECLARE @_nReqs INTEGEREXECUTE @_nReqs = N_ReqsDisp 12345PRINT @_nReqs

UPDATE Aluno set garantia = 14 where numero = 12345

SELECT * FROM Aluno
SELECT * FROM Emprestimo
SELECT * FROM Livro

INSERT INTO Emprestimo(num_aluno, num_livro, data_req)
VALUES (12345, 1005, GETDATE())
--(d) Tendo em consideração os pressupostos das alíneas (a), (b) e (c), insira uma
--requisição.

CREATE PROCEDURE Requisitar(@NumAl INTEGER, @NumLiv INTEGER)ASBEGIN	DECLARE @Estado INTEGER	EXECUTE @Estado = getEstado @NumLiv	IF (@Estado = 1)	BEGIN		PRINT ('Livro já requisitado')		RETURN -1	END	DECLARE @NReqs INTEGER	EXECUTE @NReqs = N_ReqsDisp @NumAl	IF (@NReqs <= 0)	BEGIN		PRINT ('Aluno não pode requisitar mais livros')		RETURN -1	END	INSERT INTO Emprestimo (num_aluno, num_livro)	VALUES (@NumAl, @NumLiv)	EXECUTE SetEstado @NumLiv, 1	RETURN 1END

DECLARE @_saida INTEGEREXECUTE @_saida = Requisitar 12345, 1004PRINT @_saida

SELECT * FROM Aluno
SELECT * FROM Emprestimo
SELECT * FROM Livro

Delete FROM Emprestimoupdate livro set estado = 0update Emprestimo set data_ent = getdate()where num_aluno = ####AND num_livro = ####update livro set estado = 0where Numero = ####--(e) Dados o número do aluno, o código do livro e a data de requisição, entregue
--devolva o livro.

CREATE PROCEDURE Entregar (@num_aluno INTEGER, @num_livro INTEGER, @data_req DATETIME)ASBEGIN	UPDATE Emprestimo	SET Data_Ent = GETDATE()	WHERE num_aluno = @num_aluno	AND num_livro = @num_livro	AND data_req = @data_req	IF @@ROWCOUNT = 1 --CONTA LINHAS AFETADAS	BEGIN		EXECUTE SetEstado @num_livro, 0		RETURN 1		END	ELSE		RETURN 0END

/*
IF EXISTS(
	SELECT Emprestimo.num_aluno
	FROM Emprestimo
	WHERE num_aluno = @num_aluno	AND num_livro = @num_livro	AND data_req = @data_req
	)
	BEGIN		UPDATE Emprestimo		SET Data_Ent = GETDATE()		WHERE num_aluno = @num_aluno		AND num_livro = @num_livro		AND data_req = @data_req		EXECUTE SetEstado @num_livro, 0		RETURN 1	END*/--(f) Dado o código de um livro verifique se este se encontra realmente requisitado.CREATE PROCEDURE IsRequisitado (@num_livro int)ASbegin	declare @data_ent DATE	select top 1 @data_ent = data_ent from Emprestimo	where num_livro = @num_livro	order by data_req	if @data_ent is not NULL OR @@ROWCOUNT = 0		return 0;  --O LIVRO ESTÁ NA BIBLIOTECA (NÃO ESTÁ REQUISITADO)	ELSE		return 1; --O LIVRO ESTÁ FORA (REQUISITADO)end
--(g) Dado o código de um livro, caso haja inconsistência no sistema relativamente
--ao valor do seu estado, corrija esse estado.

CREATE PROCEDURE ChangeEstadoTOcorrect (@num_livro int)ASbegin	declare @isReq int	exec @isReq = IsRequisitado @num_livro;	if exists (select numero from Livro	where numero = @num_livro)	begin			exec UpdateLivroEstado @num_livro, @isReq	endend
----------------------------------------
CREATE PROCEDURE FixEstado (@NumLiv INTEGER)ASBEGIN	DECLARE @Req INTEGER	EXECUTE @Req = VerifyReq @NumLiv	DECLARE @Estado INTEGER	EXECUTE @Estado = VerifyEstado @NumLiv	print @estado	IF (@Estado != @Req)		EXECUTE SetEstado @NumLiv, @ReqEND
-------------------------------------------
--(h) Tendo em consideração os pressupostos das alíneas (f) e (g), verifique a
--consistência do sistema.

CREATE PROCEDURE corrigeTodosOsEstadosAS   DECLARE cursor_estado CURSOR      FOR SELECT numero FROM Livro   DECLARE @cod_livro INTEGER   OPEN cursor_estado   FETCH NEXT FROM cursor_estado INTO @cod_livro   IF (@@FETCH_STATUS = -1)      BEGIN         PRINT 'Nao existem livros registados'         CLOSE cursor_estado         DEALLOCATE cursor_estado         RETURN      END   WHILE (@@FETCH_STATUS = 0)      BEGIN         EXECUTE corrigeEstado @cod_livro         FETCH NEXT FROM cursor_estado INTO @cod_livro      END   CLOSE cursor_estado   DEALLOCATE cursor_estado

   EXECUTE corrigeTodosOsEstados

--(i) Quando o sistema entra em funcionamento valide a sua consistência e caso tal
--não se verifique, atualize o sistema.

-- Finalmente deve-se registar o nosso Stored Procedure no arranque do SQL Server,-- mais propriamnete atraves do Stored Procedure do sistema 'sp_procoption'.EXEC sp_procoption @ProcName = 'corrigeTodosOsEstados', 
@OptionName = 'startup', 
@OptionValue = 'on'

--Reinicializar a base de dados (SQL)