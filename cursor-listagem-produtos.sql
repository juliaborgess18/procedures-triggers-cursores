CREATE TABLE Produto
(
	cod_prod INT PRIMARY KEY,
	descricao VARCHAR(50) UNIQUE, 
	qtde_disponivel INT NOT NULL DEFAULT 0 
);

INSERT INTO Produto VALUES(1,'Feijão',10);
INSERT INTO Produto VALUES(2,'Arroz',5);
INSERT INTO Produto VALUES(3,'Macarrão',15);
INSERT INTO Produto VALUES(4,'Farinha',25);
INSERT INTO Produto VALUES(5,'Fubá',7);
INSERT INTO Produto VALUES(6,'Achocolatado',10);
INSERT INTO Produto VALUES(7,'Sal',15);
INSERT INTO Produto VALUES(8,'Açúcar',10);
INSERT INTO Produto VALUES(9,'Óleo',30);

CREATE OR REPLACE FUNCTION listagem_produtos(prod_cursor refcursor) RETURNS refcursor
AS
$$
BEGIN 
	OPEN prod_cursor FOR SELECT * FROM Produto;
	RETURN prod_cursor;
END;
$$ LANGUAGE plpgsql;

SELECT listagem_produtos('cursor_prod');
FETCH FIRST IN cursor_prod; -- primeira tupla. 'Feijão'.
FETCH 4 IN cursor_prod; -- 4 primeiras tuplas
FETCH ABSOLUTE 4 IN cursor_prod;
FETCH RELATIVE 3 in cursor_prod; -- soma 4+3 linhas

