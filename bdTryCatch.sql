----- Cria��o do banco de dados -----

CREATE DATABASE bdTryCatch
USE bdTryCatch

-- Slide 2 --

----- Cria��o das tabelas -----

CREATE TABLE tbProblemas (
	principalProblema VARCHAR(15) NOT NULL,
	numPessoas INT NOT NULL
);

CREATE TABLE tbOutros (
	principalProblema VARCHAR(20) NOT NULL,
	numPessoas INT NOT NULL
);

----- Inser��o de dados -----

INSERT INTO tbProblemas
VALUES ('Seguran�a', 232),
       ('Emprego', 200),
	   ('Sa�de', 176),
	   ('Educa��o', 88),
	   ('Outros', 104),
	   ('Total', 800)

----- Realiza��o do try catch -----

CREATE PROCEDURE Problemas(@categoria VARCHAR(15), @percentual VARCHAR(03))
AS
BEGIN
	BEGIN TRY
		IF @categoria = 'Seguran�a'
			BEGIN
				SET @percentual = 232 * 100 / 800
				SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Seguran�a'
			END
		ELSE IF @categoria = 'Emprego'
			BEGIN
				SET @percentual = 200 * 100 / 800
				SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Emprego'
			END
		ELSE IF @categoria = 'Sa�de'
			BEGIN
				SET @percentual = 176 * 100 / 800
				SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Sa�de'
			END
		ELSE IF @categoria = 'Educa��o'
			BEGIN
				SET @percentual = 88 * 100 / 800
				SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Educa��o'
			END
		ELSE IF @categoria = 'Total'
			BEGIN
				SET @percentual = 800 * 100 / 800
				SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Total'
			END
		ELSE
			PRINT 1/0
	END TRY
	BEGIN CATCH
		SET @percentual = 104 * 100 / 800
		SELECT numPessoas AS 'N�mero de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Outros'
		INSERT INTO tbOutros VALUES (@categoria, @percentual)
	END CATCH
END

DECLARE @percentual VARCHAR
EXECUTE Problemas 'Teste', @percentual


-- Slide 3 --

----- Cria��o das tabelas -----

CREATE TABLE tbDespesas (
	Mes VARCHAR(10) NOT NULL,
	Categoria VARCHAR(50) NOT NULL,
	Valor DECIMAL(10,2) NOT NULL
);

CREATE TABLE tbErros (
	Numero INT NOT NULL,
	Severidade INT NOT NULL,
	Mensagem VARCHAR(100) NOT NULL
);

----- Inser��o de dados -----

INSERT INTO tbDespesas
VALUES ('Janeiro', 'Transporte', 74),
       ('Janeiro', 'Supermercado', 235),
	   ('Janeiro', 'Despesas dom�sticas', 175),
	   ('Janeiro', 'Entretenimento', 100),
	   ('Fevereiro', 'Transporte', 115),
	   ('Fevereiro', 'Supermercado', 240),
	   ('Fevereiro', 'Despesas dom�sticas', 225),
	   ('Fevereiro', 'Entretenimento', 125),
	   ('Mar�o', 'Transporte', 90),
	   ('Mar�o', 'Supermercado', 260),
	   ('Mar�o', 'Despesas dom�sticas', 200),
	   ('Mar�o', 'Entretenimento', 120)

----- Realiza��o do try catch -----

CREATE PROCEDURE somaGastos(@categoria VARCHAR(50))
AS
BEGIN
	BEGIN TRY
		IF @categoria = 'Transporte'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Transporte' FROM tbDespesas WHERE categoria = 'Transporte'
		ELSE IF @categoria = 'Supermercado'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Supermercado' FROM tbDespesas WHERE categoria = 'Supermercado'
		ELSE IF @categoria = 'Despesas dom�sticas'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Despesas dom�sticas' FROM tbDespesas WHERE categoria = 'Despesas dom�sticas'
		ELSE IF @categoria = 'Entretenimento'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Entretenimento' FROM tbDespesas WHERE categoria = 'Entretenimento'
		ELSE
			PRINT 1/0
	END TRY
	BEGIN CATCH
		INSERT INTO tbErros
		VALUES (ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_MESSAGE())
		SELECT * FROM tbErros
	END CATCH
END

EXECUTE somaGastos Teste