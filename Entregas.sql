create database db_aula4_Entregas;

use db_aula4_Entregas;


create table Caminhao (
	IDCaminhao int primary key not null,
    Capacidade int not null
)default charset utf8mb4;

create table Armazem (
	IDArmazem int primary key not null,
    Endereco varchar(150) not null
)default charset utf8mb4;


create table Loja(
	IDLoja int primary key not null,
    Nome varchar(150) not null,
    Endereco varchar(150) not null
)default charset utf8mb4;


create table Viagem (
	IDviagem int primary key not null,
    Peso float,
    IDArmazem int,
    foreign key (IDArmazem) references Armazem(IDArmazem),
    IDCaminhao int,
    foreign key (IDCaminhao) references Caminhao(IDCaminhao)
)default charset utf8mb4;


create table Encomenda (
	IDEncomenda int primary key not null,
    DataEncomenda datetime not null,
    Peso float not null,
    Destino varchar(150) not null,
    IDViagem int,
    foreign key (IDViagem) references Viagem(IDViagem),
    IDLoja int,
    foreign key (IDLoja) references Loja(IDLoja)
)default charset utf8mb4;