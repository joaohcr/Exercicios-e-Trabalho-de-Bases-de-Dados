create database Teste2
use Teste2

create table Pessoas (
	numero integer primary key,
	nome varchar(50) not null,
	contacto varchar(50) not null,
	titulo varchar(20),
	cota money not null
)

-- 1.1. Insira-se a si mesmo como um novo membro na base de dados.

insert into Pessoas (numero, nome, contacto, titulo, cota)
values 
(70633, 'Diogo Medeiros', 'al70633@utad.eu', 'engenheiro', 10),
(70579, 'Jo�o Rodrigues', 'al70579@utad.eu', 'engenheiro', 15);

insert into Membro (numero, lugar)
values (70633, 20);

-- 1.2. Quais as Pessoas existentes no sistema com o titulo �Engenheiro�? Ordene-as alfabeticamente pelo nome [numero, nome]

select numero, nome
from Pessoas
where titulo like 'Engenheiro'
order by nome;

-- 1.3. Quantas reuni�es j� foram realizadas? [Numero_Reuni�es]

select count(*) NoReunioes
from Reuniao
where data_ <= getdate();

-- 1.4. Que pessoas da Direcao est�o na reuni�o que est� a decorrer? [Nome, Cargo]

select nome, cargo
from Pessoas P, Direcao D, Dir_Participa
where data_saida is null
and num_direcao = D.numero
and D.numero = P.numero;
-- 1.5. Qual o �ltimo membro a entrar para a reuni�o que est� decorrer? [Numero, Nome, Data]

select P.numero, nome, data_entrada
from Mem_Participa, Membro M, Pessoas P
where data_entrada = (select MAX(data_entrada)
						from Mem_Participa, Reuniao
						where num_reuniao = numero
						and data_ = getdate())
and num_membro = M.numero
and M.numero = P.numero

-- 1.6. Crie um procedimento que dado o numero de uma pessoa e o titulo de uma reuni�o verifique se a pessoa ocupa um cargo diretivo na reuni�o. 
-- Deve devolver 1 caso ocupe e 0 caso contr�rio.

create procedure IsDir (@numero integer, @titulo varchar(50))
as
begin
	select *
	from Pessoas P, Direcao D, Dir_Participa, Reuniao R
	where titulo like @titulo
	and R.numero = num_reuniao
	and num_direcao = D.numero
	and D.numero = P.numero
	and P.numero = @numero

	if(@@ROWCOUNT > 0)
		return 1
	return 0
end
-- 1.7. Crie um procedimento que verifique se uma reuni�o tem qu�rum, assumindo que � dado o t�tulo da reuni�o. 
-- Nestas reuni�es o qu�rum obt�m-se se j� estiverem presentes 3 elementos da dire��o e 25 membros da assembleia.
-- Deve devolver 1 caso haja qu�rum e 0 caso contr�rio.

create procedure HasQuorum (@titulo varchar(50))
as
begin
	declare @NumDir integer,
			@NumMem integer
	select @NumDir = COUNT(distinct(num_direcao))
	from Dir_Participa, Reuniao
	where titulo like @titulo
	and num_reuniao = numero

	select @NumMem = COUNT(distinct(num_membro))
	from Mem_Participa, Reuniao
	where titulo like @titulo
	and num_reuniao = numero

	if (@NumDir >= 3 and @NumMem >= 25)
		return 1
	return 0
end

/*Crie um trigger que ap�s a insers�o de uma pessoa na base de dados,caso o valor da cota seja inferior a 20�, substitua o t�tulo por 'Forreta'*/

create trigger NovoTrigger
on Pessoas
after Insert
as
begin
	declare @numero integer,
			@cota money

	select @numero = numero, @cota = cota
	from inserted

	if (@cota < 20)
	begin
		update Pessoas
		set titulo = 'Forreta'
		where numero = @numero
	end
end