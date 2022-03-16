----- Criação do banco de dados -----

CREATE DATABASE bdTryCatch
USE bdTryCatch

-- Slide 2 --

----- Criação das tabelas -----

CREATE TABLE tbProblemas (
	principalProblema VARCHAR(15) NOT NULL,
	numPessoas INT NOT NULL
);

CREATE TABLE tbOutros (
	principalProblema VARCHAR(20) NOT NULL,
	numPessoas INT NOT NULL
);

----- Inserção de dados -----

INSERT INTO tbProblemas
VALUES ('Segurança', 232),
       ('Emprego', 200),
	   ('Saúde', 176),
	   ('Educação', 88),
	   ('Outros', 104),
	   ('Total', 800)

----- Realização do try catch -----

CREATE PROCEDURE Problemas(@categoria VARCHAR(15), @percentual VARCHAR(03))
AS
BEGIN
	BEGIN TRY
		IF @categoria = 'Segurança'
			BEGIN
				SET @percentual = 232 * 100 / 800
				SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Segurança'
			END
		ELSE IF @categoria = 'Emprego'
			BEGIN
				SET @percentual = 200 * 100 / 800
				SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Emprego'
			END
		ELSE IF @categoria = 'Saúde'
			BEGIN
				SET @percentual = 176 * 100 / 800
				SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Saúde'
			END
		ELSE IF @categoria = 'Educação'
			BEGIN
				SET @percentual = 88 * 100 / 800
				SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Educação'
			END
		ELSE IF @categoria = 'Total'
			BEGIN
				SET @percentual = 800 * 100 / 800
				SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Total'
			END
		ELSE
			PRINT 1/0
	END TRY
	BEGIN CATCH
		SET @percentual = 104 * 100 / 800
		SELECT numPessoas AS 'Número de Pessoas', @percentual + '%' AS 'Percentual do Total' FROM tbProblemas WHERE principalProblema = 'Outros'
		INSERT INTO tbOutros VALUES (@categoria, @percentual)
	END CATCH
END

DECLARE @percentual VARCHAR
EXECUTE Problemas 'Teste', @percentual


-- Slide 3 --

----- Criação das tabelas -----

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

----- Inserção de dados -----

INSERT INTO tbDespesas
VALUES ('Janeiro', 'Transporte', 74),
       ('Janeiro', 'Supermercado', 235),
	   ('Janeiro', 'Despesas domésticas', 175),
	   ('Janeiro', 'Entretenimento', 100),
	   ('Fevereiro', 'Transporte', 115),
	   ('Fevereiro', 'Supermercado', 240),
	   ('Fevereiro', 'Despesas domésticas', 225),
	   ('Fevereiro', 'Entretenimento', 125),
	   ('Março', 'Transporte', 90),
	   ('Março', 'Supermercado', 260),
	   ('Março', 'Despesas domésticas', 200),
	   ('Março', 'Entretenimento', 120)

----- Realização do try catch -----

CREATE PROCEDURE somaGastos(@categoria VARCHAR(50))
AS
BEGIN
	BEGIN TRY
		IF @categoria = 'Transporte'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Transporte' FROM tbDespesas WHERE categoria = 'Transporte'
		ELSE IF @categoria = 'Supermercado'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Supermercado' FROM tbDespesas WHERE categoria = 'Supermercado'
		ELSE IF @categoria = 'Despesas domésticas'
			SELECT 'R$ ' + CAST(SUM(valor) AS VARCHAR) AS 'Soma dos Gastos com Despesas domésticas' FROM tbDespesas WHERE categoria = 'Despesas domésticas'
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