use db_highway;

DELIMITER $

CREATE TRIGGER tr_usuario_delete
BEFORE DELETE ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO log_usuario(mensagem) 
    VALUES(CONCAT("Usuário ", OLD.nome, " Deletado"));
    
    INSERT INTO usuario_deletado 
    VALUES(OLD.cod_usuario, OLD.nome, OLD.cpf, OLD.email, OLD.dt_nascimento, OLD.obs, OLD.tipo_acesso, NOW());
END
$


CREATE TRIGGER tr_usuario_insert
AFTER INSERT ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO log_usuario(mensagem) 
    VALUES(CONCAT("Usuário ", new.nome, " Inserido"));
END
$


CREATE TRIGGER tr_usuario_update
AFTER UPDATE ON tb_usuario
FOR EACH ROW
BEGIN
    INSERT INTO log_usuario(mensagem) 
    VALUES(CONCAT("Usuário CPF: ", cpf,
		IF(OLD.nome <> NEW.nome, CONCAT(', Nome: ', OLD.nome, ' alterado para ', NEW.nome), ''), 
        IF(OLD.email <> NEW.email, CONCAT(', Email: ', OLD.email, ' alterado para ', NEW.email), ''), 
        IF(OLD.tipo_acesso <> NEW.tipo_acesso, CONCAT(', Acesso: ', OLD.tipo_acesso, ' alterado para ', NEW.tipo_acesso), ''), 
        IF(OLD.obs <> NEW.obs, CONCAT(', Observações: ', OLD.obs, ' alterado para ', NEW.obs), '')
        ));
END
$


CREATE TRIGGER tr_fone_update
AFTER UPDATE ON tb_telefone
FOR EACH ROW
BEGIN
	INSERT INTO log_usuario(mensagem)
    VALUES(CONCAT("Usuário CPF: ", (SELECT U.cpf FROM tb_usuario U INNER JOIN tb_telefone T ON T.cod_usuario = U.cod_usuario WHERE T.cod_telefone = OLD.cod_telefone), ', Telefone Antigo: ', OLD.telefone, ', Novo Telefone: ', NEW.telefone));
END
$


CREATE PROCEDURE pr_produto_delete(nome_produto VARCHAR(255))
BEGIN
	INSERT INTO log_usuario(mensagem) 
    VALUES(CONCAT(nome_produto, " Deletado"));
END
$


CREATE TRIGGER tr_produto_delete
BEFORE DELETE ON tb_produto
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_carne_delete
BEFORE DELETE ON tb_carne
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_salada_delete
BEFORE DELETE ON tb_salada
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_molho_delete
BEFORE DELETE ON tb_molho
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_pao_delete
BEFORE DELETE ON tb_pao
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_queijo_delete
BEFORE DELETE ON tb_queijo
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE TRIGGER tr_adicional_delete
BEFORE DELETE ON tb_adicional
FOR EACH ROW
BEGIN
    CALL pr_produto_delete(OLD.nome);
END
$


CREATE PROCEDURE pr_produto_update(nome_produto VARCHAR(255), valor_antigo DECIMAL(10,2), valor_novo DECIMAL(10,2))
BEGIN
	INSERT INTO log_produto 
    VALUES (CONCAT(nome_produto, ': Valor alterado de ', valor_antigo, 'para ', valor_novo));
END
$


CREATE TRIGGER tr_produto_update
AFTER UPDATE ON tb_produto
FOR EACH ROW
BEGIN
	CALL pr_produto_update(NEW.nome, OLD.valor, NEW.valor);
END
$

CREATE PROCEDURE pr_produto_insert(nome_produto VARCHAR(255))
BEGIN
	INSERT INTO log_usuario(mensagem) 
    VALUES(CONCAT(nome_produto, " Inserido"));
END
$

delimiter $

CREATE TRIGGER tr_produto_insert
after insert ON tb_produto
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_carne_insert
BEFORE insert ON tb_carne
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_salada_insert
BEFORE insert ON tb_salada
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_molho_insert
BEFORE insert ON tb_molho
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_pao_insert
BEFORE insert ON tb_pao
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_queijo_insert
BEFORE insert ON tb_queijo
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$


CREATE TRIGGER tr_adicional_insert
BEFORE insert ON tb_adicional
FOR EACH ROW
BEGIN
    CALL pr_produto_insert(new.nome);
END
$

CREATE PROCEDURE createAccount(pc_nome varchar(255), pc_cpf char(11), pc_email varchar(255), dt_nascimento date, tipo_acesso int)
begin
	insert into tb_usuario (nome, cpf, email,dt_nascimento, tipo_acesso) values (pc_nome, pc_cpf, pc_email, dt_nascimento, tipo_acesso);
    
    set @userExists = 0;
    set @userExists = (
    select
    count(cpf)
    from usuario_deletado
    where cpf = pc_cpf
    limit 1
    );
    
    if @userExists = 0 then
		commit;
    else
		delete from usuario_deletado where cpf = pc_cpf;
    end if;
end
$

-- endereco

CREATE PROCEDURE createAdress(pc_cep int, pc_numero int, pc_complemento varchar(255))
begin
	start transaction;

		set @adressExists = 0;

		set @adressExists = (
		select
		count(numero)
		from tb_endereco
		where cep = pc_cep and numero = pc_numero
		limit 1
		);

		insert into tb_endereco(cep,  numero, complemento) values (pc_cep, pc_numero, pc_complemento);

		if @adressExists < 1 then
			commit;
		else
			rollback;
		end if;
end;
$

-- CREATE PROCEDURE pc_pedidos(idUser INT) 
-- BEGIN
-- SELECT 
--     u.cod_usuario,
--     u.nome AS usuario_nome,
--     p.cod_pedido,
--     p.valor_total,
--     p.obs AS pedido_obs,
--     e.cep,
--     e.numero,
--     e.complemento,
--     h.cod_hamburguer,
--     ph.quantidade as quantidade_de_hamburguer,
--     pao.nome AS pao_nome,
--     carne.nome AS carne_nome,
--     salada.nome AS salada_nome,
--     molho.nome AS molho_nome,
--     queijo.nome AS queijo_nome,
--     ha.quantidade AS adicional_quantidade,
--     a.nome AS adicional_nome,
--     prod.nome AS produto_nome
-- FROM 
--     tb_usuario u
-- INNER JOIN 
--     tb_pedido p ON u.cod_usuario = p.cod_usuario
-- LEFT JOIN 
--     tb_endereco e ON p.cod_endereco = e.cod_endereco
-- LEFT JOIN 
--     tb_pedido_hamburguer ph ON p.cod_pedido = ph.cod_pedido
-- LEFT JOIN 
--     tb_hamburguer h ON ph.cod_hamburguer = h.cod_hamburguer
-- LEFT JOIN 
--     tb_pao pao ON h.cod_pao = pao.cod_pao
-- LEFT JOIN 
--     tb_carne carne ON h.cod_carne = carne.cod_carne
-- LEFT JOIN 
--     tb_salada salada ON h.cod_salada = salada.cod_salada
-- LEFT JOIN 
--     tb_molho molho ON h.cod_molho = molho.cod_molho
-- LEFT JOIN 
--     tb_queijo queijo ON h.cod_queijo = queijo.cod_queijo
-- LEFT JOIN 
--     tb_hamburguer_adicional ha ON h.cod_hamburguer = ha.cod_hamburguer
-- LEFT JOIN 
--     tb_adicional a ON ha.cod_adicional = a.cod_adicional
-- LEFT JOIN 
--     tb_pedido_produto pp ON p.cod_pedido = pp.cod_pedido
-- LEFT JOIN 
--     tb_produto prod ON pp.cod_produto = prod.cod_produto
-- WHERE 
--     u.cod_usuario = idUser;
-- END;
-- $
-- delimiter ;

-- mostra o produto pelo índice de um pedido existente
DELIMITER //
create procedure pc_pedido_produto(cod int)
begin
SELECT p.nome AS produto, pp.quantidade, pp.cod_pedido
FROM tb_produto p
INNER JOIN tb_pedido_produto pp 
ON p.cod_produto = pp.cod_produto
WHERE pp.cod_pedido = cod;
end;
// DELIMITER ;

delimiter //

-- mostra o hamburguer pelo índice de um pedido existente
CREATE PROCEDURE pc_pedido_hamburguer(cod int)
begin
SELECT pa.nome AS pao, c.nome AS carne, s.nome AS salada, m.nome AS molho, q.nome AS queijo, ph.quantidade, ph.cod_pedido
FROM tb_hamburguer h
JOIN tb_pao pa ON h.cod_pao = pa.cod_pao
JOIN tb_carne c ON h.cod_carne = c.cod_carne
JOIN tb_salada s ON h.cod_salada = s.cod_salada
JOIN tb_molho m ON h.cod_molho = m.cod_molho
JOIN tb_queijo q ON h.cod_queijo = q.cod_queijo
JOIN tb_pedido_hamburguer ph ON h.cod_hamburguer = ph.cod_hamburguer
WHERE ph.cod_pedido = cod; 
end;
// delimiter ;

-- cria hamburguer
delimiter //
create procedure createHamburguer(cod_pao int, cod_carne int, cod_salada int, cod_molho int, cod_queijo int, obs varchar(255))
begin
	insert into tb_hamburguer (cod_pao, cod_carne, cod_salada, cod_molho, cod_queijo, obs) values (cod_pao, cod_carne, cod_salada, cod_molho, cod_queijo, obs);
end;
// delimiter ;

-- cria pedido
delimiter //
create procedure pedido(usuario int, endereco int, total decimal, ob varchar(255))
begin
	insert into tb_pedido (cod_endereco, cod_usuario, valor_total, obs) values (endereco, usuario, total, ob);
end;
// delimiter ;

-- cria relaação pedido hamburguer
delimiter //
create procedure pedidoHamburguer(cod_pedido int, cod_hamburguer int, quantidade int)
begin
	insert into tb_pedido_hamburguer (cod_pedido, cod_hamburguer, quantidade) values (cod_pedido, cod_hamburguer, quantidade);
end;
// delimiter ;







