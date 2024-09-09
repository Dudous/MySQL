DROP DATABASE IF EXISTS db_highway;
CREATE DATABASE IF NOT EXISTS db_highway
DEFAULT CHARACTER SET utf8mb4;

USE db_highway;

CREATE TABLE tb_acesso (
	cod_acesso INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    tipo_acesso VARCHAR(255) NOT NULL
);

CREATE TABLE tb_usuario (
	cod_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    cpf CHAR(11) NOT NULL,
    email VARCHAR(255) NOT NULL,
    dt_nascimento DATE NOT NULL,
    obs VARCHAR(255) NULL,
    status BIT NOT NULL,
    tipo_acesso INT NOT NULL default 1,
    FOREIGN KEY(tipo_acesso) REFERENCES tb_acesso(cod_acesso)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
);

CREATE TABLE tb_telefone (
	cod_telefone INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cod_usuario INT NOT NULL,
    telefone CHAR(15) NOT NULL,
    FOREIGN KEY(cod_usuario) REFERENCES tb_usuario(cod_usuario)
    ON UPDATE CASCADE
    ON DELETE CASCADE -- TRIGGER mudar ststus e exluir
);

CREATE TABLE tb_carne (
	cod_carne INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_salada (
	cod_salada INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_molho (
	cod_molho INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_pao (
	cod_pao INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_queijo (
	cod_queijo INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_adicional (
	cod_adicional INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_produto (
	cod_produto INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL
);

CREATE TABLE tb_hamburguer (
	cod_hamburguer INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    cod_pao INT NOT NULL,
    cod_carne INT NULL,
    cod_salada INT NULL,
    cod_molho INT NULL,
    cod_queijo INT NULL,
    obs VARCHAR(255) NULL,
    FOREIGN KEY(cod_pao) REFERENCES tb_pao(cod_pao)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    FOREIGN KEY(cod_carne) REFERENCES tb_carne(cod_carne)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    FOREIGN KEY(cod_salada) REFERENCES tb_salada(cod_salada)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
    FOREIGN KEY(cod_molho) REFERENCES tb_molho(cod_molho)
	ON UPDATE CASCADE
    ON DELETE RESTRICT,
    FOREIGN KEY(cod_queijo) REFERENCES tb_queijo(cod_queijo)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
);

CREATE TABLE tb_hamburguer_adicional (
	cod_hamburguer_adicional INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_hamburguer INT NOT NULL,
    cod_adicional INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY(cod_hamburguer) REFERENCES tb_hamburguer(cod_hamburguer)
    ON UPDATE NO ACTION
    ON DELETE NO ACTION,
    FOREIGN KEY(cod_adicional) REFERENCES tb_adicional(cod_adicional)
	ON UPDATE NO ACTION
    ON DELETE NO ACTION
);

CREATE TABLE tb_endereco (
	cod_endereco INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cep CHAR(8) NOT NULL,
    numero INT NOT NULL,
    complemento VARCHAR(255) NULL
);

CREATE TABLE tb_pedido (
	cod_pedido INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_endereco INT NULL,
    cod_usuario INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    obs VARCHAR(255),
    status enum('Recebido', 'Aceito', 'Negado', 'Preparando', 'Saindo para entrega', 'Cancelado', 'Concluído'),
    FOREIGN KEY(cod_endereco) REFERENCES tb_endereco(cod_endereco)
	ON UPDATE RESTRICT
    ON DELETE RESTRICT,
    FOREIGN KEY(cod_usuario) REFERENCES tb_usuario(cod_usuario)
	ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE tb_pedido_hamburguer (
	cod_pedido_hamburguer INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_pedido INT NOT NULL,
    cod_hamburguer INT NOT NULL,
    quantidade INT NOT NULL,
    FOREIGN KEY(cod_pedido) REFERENCES tb_pedido(cod_pedido)
	ON UPDATE RESTRICT
    ON DELETE CASCADE,
    FOREIGN KEY(cod_hamburguer) REFERENCES tb_hamburguer(cod_hamburguer)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);
  
CREATE TABLE tb_pedido_produto (
	cod_pedido_produto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cod_pedido INT NOT NULL,
    cod_produto INT NOT NULL,
    quantidade INT NOT NULL,
	FOREIGN KEY(cod_pedido) REFERENCES tb_pedido(cod_pedido)
    ON UPDATE RESTRICT
    ON DELETE CASCADE,
    FOREIGN KEY(cod_produto) REFERENCES tb_produto(cod_produto)
    ON UPDATE RESTRICT
    ON DELETE CASCADE
);

CREATE TABLE log_produto (
	cod_log_produto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255) NOT NULL,
    dt_alteracao DATETIME NOT NULL DEFAULT NOW()
);

CREATE TABLE log_usuario (
	cod_log_usuario INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mensagem VARCHAR(255) NOT NULL,
    dt_alteracao DATETIME NOT NULL DEFAULT NOW()
);

-- CREATE TABLE usuario_deletado (
-- 	cod_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
--     nome VARCHAR(255) NOT NULL,
--     cpf CHAR(11) NOT NULL,
--     email VARCHAR(255) NOT NULL,
--     dt_nascimento DATE NOT NULL,
--     obs VARCHAR(255) NULL,
--     tipo_acesso INT NOT NULL,
--     dt_delecao DATETIME NOT NULL DEFAULT NOW()
-- );


