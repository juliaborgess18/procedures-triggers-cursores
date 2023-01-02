
DROP TABLE IF EXISTS venda;
DROP TABLE IF EXISTS produto;

-- Criar tabela de Produto 
CREATE TABLE produto( 
	id_produto SERIAL,
	quantidade_produto INTEGER,
	desc_produto VARCHAR(30), 
	
	CONSTRAINT pk_produto
		PRIMARY KEY(id_produto)
);

-- Criar tabela de registro de Venda
CREATE TABLE venda( 
	id_venda SERIAL, 
	cod_prod INTEGER,
	quantidade_venda INTEGER,
	
	CONSTRAINT pk_venda
		PRIMARY KEY(id_venda),
	
	CONSTRAINT fk_venda_produto 
		FOREIGN KEY (cod_prod)
		REFERENCES produto(id_produto)
);

CREATE OR REPLACE FUNCTION atualiza_estoque() 
RETURNS TRIGGER AS $$ 
BEGIN 
	IF(TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN 
		UPDATE 
			produto p 
		SET 
			quantidade_produto = 
				p.quantidade_produto - v.quantidade_venda 
		FROM 
			venda v 
		WHERE 
			v.cod_prod = p.id_produto;
		RETURN NEW; 
	END IF; 
	RETURN NULL;
END; 
$$ LANGUAGE 'plpgsql'; 

CREATE OR REPLACE TRIGGER tr_atualiza_estoque 
AFTER INSERT OR UPDATE ON venda 
FOR EACH ROW EXECUTE PROCEDURE 
atualiza_estoque();

INSERT INTO produto(desc_produto, quantidade_produto)
VALUES ('Caneta Rosa', 120); -- acrescento 120 itens 

INSERT INTO venda(cod_prod, quantidade_venda)
VALUES (1, 10); -- vendi 10

SELECT * FROM venda;
SELECT * FROM produto; 

