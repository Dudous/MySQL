-- nome, cpf, email,dt_nascimento, tipo_acesso
call createAccount("maria", "12345678900", "maria@email.com", '2016-02-12', 2);
select * from tb_usuario;
call pc_pedido_produto(1);
select * from tb_pao;
select * from tb_queijo;
select * from tb_adicional;
select * from tb_produto;
select * from tb_molho;
select * from tb_salada ;
select * from tb_carne;
select * from tb_hamburguer;
-- cod_pao, cod_carne, cod_salada, cod_molho, cod_queijo, obs
call createHamburguer(1,1,1,1,1, "sem molho");
select * from tb_hamburguer;
select * from tb_endereco;
call pedido(12,1, 30.0, 'sem cebola');
-- usuario int, endereco int, total decimal, ob varchar(255
select * from tb_pedido;
call pc_pedido_hamburguer(13);
-- procedure que mostra tds os hamburgueres
-- fazer pedido
-- cancelar pedido
-- admin mudar o status