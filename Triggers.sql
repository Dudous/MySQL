CREATE DATABASE db_loja_eletronicos;

USE db_loja_eletronicos;

-- Tabela `produtos`
CREATE TABLE produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Tabela `clientes`
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20) DEFAULT NULL,
    valor_total_compras DECIMAL(10, 2) DEFAULT 0.00
);

-- Tabela `vendas`
CREATE TABLE venda (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    data_venda DATE NOT NULL,
    quantidade INT NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela `promocoes`
CREATE TABLE promocao (
    id_promocao INT PRIMARY KEY AUTO_INCREMENT,
    nome_promocao VARCHAR(100) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL
);

-- Tabela `notificacoes`
CREATE TABLE notificacao (
    id_notificacao INT PRIMARY KEY AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    data_notificacao DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- 1
DELIMITER //

create trigger tr_valor_total 
after insert on venda
for each row
begin
	update cliente
    set valor_total_compras = valor_total_compras + new.valor_total
    where cliente.id_cliente = new.id_cliente;
end
//

-- 2

create trigger tr_promocao
before insert on venda
for each row
begin
	update new 
    set valor_total = valor_total - valor_total *
	(select desconto 
    from promocao
    where new.data_venda between
	promocao.data_inicio and promocao.data_fim)/100;
end
//
/*
-- 3
CREATE FUNCTION f_media_produto(prod INT)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE media DECIMAL(10,2);

    SELECT SUM(valor_total) / NULLIF(SUM(quantidade), 0) INTO media
    FROM venda
    WHERE id_produto = prod;

    RETURN media;
END;
*/
//

-- 4
create trigger tr_alteracao_produto
after update on produto
for each row
begin
	if old.quantidade_estoque <> new.quantidade_estoque then
	insert into notificacao(mensagem) values
    (concat("Produto: ", new.nome_produto, ", estoque alterado de", old.quantidade_estoque,"para", new.quantidade_estoque));
    end if;
end
//

-- 5
create trigger tr_cadastro_cliente
after insert on cliente
for each row
begin
	insert into notificacao(mensagem) values
    (concat("Novo Usuário Cadastrado: ", new.nome));
end
//

-- 6
create trigger tr_vendas_promocao
after insert on venda
for each row
begin
	declare valor_produto int;
    declare nome varchar(100);
    
    select preco into valor_produto from produto where new.id_produto = produto.id_produto;
    select nome_produto into nome from produto where new.id_produto = produto.id_produto;
    
	if (new.valor_total/new.quantidade) <> valor_produto then
	insert into notificacao(mensagem) values
    (concat("Produto Vendido com desconto: ", nome));
end if;
end
//

-- 7
create trigger tr_produto_falta
after insert on venda
for each row
begin
    declare nome varchar(100);
    declare estoque int;
    
    select nome_produto into nome from produto where new.id_produto = produto.id_produto;
    select quantidade_estoque into estoque from produto where new.id_produto = produto.id_produto;
    
	if estoque <= 0 then
	insert into notificacao(mensagem) values
    (concat("Produto com falta de estoque: ", nome));
end if;
end
//

-- 8
alter table produto add valor_total_vendas float(15,2)//

create trigger tr_total_vendas_produto
after insert on venda
for each row
begin
	update produto
    set valor_total_vendas = valor_total_vendas + new.valor_total
    where produto.id_produto = new.id_produto;
end
//


-- 9
create trigger tr_alteracao_valor_produto
after update on produto
for each row
begin
	if old.preco <> new.preco then
	insert into notificacao(mensagem) values
    (concat("Produto: ", new.nome_produto, ", com valor alterado de", old.preco,"para", new.preco));
    end if;
end
//

DELIMITER ;
/*
1.Registrar uma nova venda e atualizar o valor total de compras por cliente.
2. Trigger para aplicar desconto de promoção em vendas
3.Atualizar o preço médio de um produto após uma nova venda.
4.Rastrear alterações no estoque de produtos e registrar uma notificação dentro de um log.
5.Registrar novos clientes e gerar uma mensagem de usuário cadastrado dentro de um log.
6.Monitorar vendas de produtos em promoção e registrar uma notificação.
7.Registrar produtos em falta no estoque e gerar uma notificação.
8.Atualizar o valor total de vendas de um produto após uma nova venda.
9.Rastrear alterações no valor de produtos e registrar uma notificação.
*/