USE db_highway;

-- Insere dois tipos de acesso
INSERT INTO tb_acesso (tipo_acesso) VALUES ('admin'), ('cliente');

-- Insere 10 registros na tabela tb_usuario
INSERT INTO tb_usuario (nome, cpf, email, dt_nascimento, tipo_acesso) VALUES
('Nicolle Souza', '12345678901', 'nicolle1@email.com', '2000-01-01', 1),
('Carlos Lima', '12345678902', 'carlos2@email.com', '1998-02-14', 2),
('Ana Paula', '12345678903', 'ana3@email.com', '1995-03-20', 2),
('Roberto Silva', '12345678904', 'roberto4@email.com', '1989-04-25', 1),
('Juliana Alves', '12345678905', 'juliana5@email.com', '1990-05-30', 2),
('Fernando Torres', '12345678906', 'fernanomendo6@email.com', '1985-06-15', 1),
('Mariana Costa', '12345678907', 'mariana7@email.com', '1993-07-10', 2),
('Renato Gomes', '12345678908', 'renato8@email.com', '1982-08-22', 2),
('Patrícia Silva', '12345678909', 'patricia9@email.com', '2001-09-17', 1),
('Lucas Martins', '12345678910', 'lucas10@email.com', '1999-10-05', 2);

-- Insere 10 registros na tabela tb_telefone
INSERT INTO tb_telefone (cod_usuario, telefone) VALUES
(1, '(11) 98765-4321'),
(2, '(11) 91234-5678'),
(3, '(11) 92345-6789'),
(4, '(11) 93456-7890'),
(5, '(11) 94567-8901'),
(6, '(11) 95678-9012'),
(7, '(11) 96789-0123'),
(8, '(11) 97890-1234'),
(9, '(11) 98901-2345'),
(10, '(11) 99012-3456');

-- Insere 10 registros na tabela tb_carne
INSERT INTO tb_carne (nome, valor) VALUES
('Picanha', 7.00),
('Fraldinha', 3.00),
('Maminha', 5.50),
('Alcatra', 4.00),
('Costela', 5.50),
('Filet Mignon', 7.00),
('Contrafilé', 2.50),
('Cupim', 3.50),
('Cordeiro', 8.00),
('Frango', 2.50);

-- Insere 10 registros na tabela tb_salada
INSERT INTO tb_salada (nome, valor) VALUES
('Alface', 2.00),
('Rúcula', 3.00),
('Tomate', 2.50),
('Cenoura', 2.00),
('Repolho', 2.00),
('Beterraba', 3.00),
('Pepino', 2.50),
('Cebola', 1.50),
('Picles', 2.50),
('Milho', 2.00);

-- Insere 10 registros na tabela tb_molho
INSERT INTO tb_molho (nome, valor) VALUES
('Barbecue', 1.50),
('Maionese', 1.00),
('Ketchup', 1.00),
('Mostarda', 1.00),
('Chimichurri', 1.50),
('Rosé', 1.50),
('Pesto', 2.00),
('Cheddar', 2.50),
('Alho', 1.50),
('Gorgonzola', 3.00);

-- Insere 10 registros na tabela tb_pao
INSERT INTO tb_pao (nome, valor) VALUES
('Brioche', 3.50),
('Australiano', 4.00),
('Integral', 3.00),
('Francês', 2.50),
('Italiano', 4.50),
('Sourdough', 5.00),
('Multigrãos', 4.00),
('Bagel', 3.50),
('Centeio', 3.00),
('Pretzel', 4.00);

-- Insere 10 registros na tabela tb_queijo
INSERT INTO tb_queijo (nome, valor) VALUES
('Cheddar', 2.50),
('Mussarela', 2.00),
('Gorgonzola', 3.00),
('Prato', 2.00),
('Brie', 3.50),
('Parmesão', 2.50),
('Gruyère', 4.00),
('Provolone', 3.00),
('Emmental', 3.50),
('Minas', 2.00);

-- Insere 10 registros na tabela tb_adicional
INSERT INTO tb_adicional (nome, valor) VALUES
('Bacon', 2.50),
('Ovo', 1.50),
('Cebola Caramelizada', 2.00),
('Jalapeño', 1.50),
('Abacaxi', 2.00),
('Guacamole', 3.00),
('Batatinha', 1.50),
('Tomate Seco', 2.50),
('Champignon', 2.50),
('Pepperoni', 3.00);

-- Insere 10 registros na tabela tb_produto
INSERT INTO tb_produto (nome, valor) VALUES
('Coca 250ml', 5.00),
('Água', 3.00),
('Cerveja', 4.00),
('Suco', 6.00),
('Milkshake', 10.00),
('Café', 4.00),
('Chá Gelado', 5.00),
('Vinho', 15.00),
('Energético', 12.00),
('Whisky', 20.00);

-- Insere 10 registros na tabela tb_endereco
INSERT INTO tb_endereco (cep, numero, complemento) VALUES
('12345678', 100, 'Apto 101'),
('23456789', 200, 'Apto 202'),
('34567890', 300, 'Casa'),
('45678901', 400, 'Apto 401'),
('56789012', 500, 'Apto 502'),
('67890123', 600, 'Casa'),
('78901234', 700, 'Apto 701'),
('89012345', 800, 'Apto 802'),
('90123456', 900, 'Casa'),
('01234567', 1000, 'Apto 1001');

create procedure createPedido(cep, numero, complemento)
begin
end;

-- Insere 10 registros na tabela tb_hamburguer
INSERT INTO tb_hamburguer (cod_pao, cod_carne, cod_salada, cod_molho, cod_queijo, obs) VALUES
(1, 1, 1, 1, 1, 'Sem cebola'),
(2, 2, 2, 2, 2, 'Extra bacon'),
(3, 3, 3, 3, 3, 'Sem tomate'),
(4, 4, 4, 4, 4, 'Bem passado'),
(5, 5, 5, 5, 5, 'Pão sem gergelim'),
(6, 6, 6, 6, 6, 'Molho à parte'),
(7, 7, 7, 7, 7, 'Queijo extra'),
(8, 8, 8, 8, 8, 'Molho sem picles'),
(9, 9, 9, 9, 9, 'Carne mal passada'),
(10, 10, 10, 10, 10, 'Sem salada');

-- Insere 10 registros na tabela tb_hamburguer_adicional
INSERT INTO tb_hamburguer_adicional (cod_hamburguer, cod_adicional, quantidade) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 1),
(4, 4, 3),
(5, 5, 1),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 9, 2),
(10, 10, 3);

-- Insere 10 registros na tabela tb_pedido
INSERT INTO tb_pedido (cod_endereco, cod_usuario, valor_total, obs) VALUES
(1, 1, 35.00, 'Entrega rápida'),
(2, 2, 40.00, 'Troco para 50'),
(3, 3, 45.00, 'Sem picles'),
(4, 4, 50.00, 'Troco para 100'),
(5, 5, 55.00, 'Entregar no portão'),
(6, 6, 60.00, 'Não tocar a campainha'),
(7, 7, 65.00, 'Entregar em mãos'),
(8, 8, 70.00, 'Deixar na portaria'),
(9, 9, 75.00, 'Entregar até as 18h'),
(10, 10, 80.00, 'Aguarde no carro');
INSERT INTO tb_pedido (cod_endereco, cod_usuario, valor_total, obs) VALUES (10, 1, 80.00, 'Aguarde no carro');

-- Insere 10 registros na tabela tb_pedido_hamburguer
INSERT INTO tb_pedido_hamburguer (cod_pedido, cod_hamburguer, quantidade) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1),
(5, 5, 2),
(6, 6, 1),
(7, 7, 2),
(8, 8, 1),
(9, 9, 3),
(10, 10, 1);
INSERT INTO tb_pedido_hamburguer (cod_pedido, cod_hamburguer, quantidade) VALUES (1, 2, 1);
INSERT INTO tb_pedido_hamburguer (cod_pedido, cod_hamburguer, quantidade) VALUES (11, 3, 1);

-- Insere 10 registros na tabela tb_pedido_produto
INSERT INTO tb_pedido_produto (cod_pedido, cod_produto, quantidade) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 1),
(4, 4, 3),
(5, 5, 1),
(6, 6, 2),
(7, 7, 1),
(8, 8, 1),
(9, 9, 2),
(10, 10, 3);



