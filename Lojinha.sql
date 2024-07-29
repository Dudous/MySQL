create database db_aula4;

use db_aula4;

create table Produto (
	IDProduto int primary key not null,
    Nome varchar(75) not null,
    Tipo varchar(50) not null,
    Preco float not null,
    Quantidade int not null
)default charset utf8mb4;


create table Compra (
	IDCompra int primary key not null,
    DataCompra datetime not null,
    