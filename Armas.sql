create database db_aula4_Policia;

use db_aula4_Policia;

create table Arma (
	NSerie int primary key not null,
	Tipo varchar(75) not null,
    Municao varchar(50) not null,
    Calibre float not null
)default charset utf8mb4;

create table Soldado (
	RM int primary key not null,
    Nome varchar(75) not null,
    DataNasc datetime not null
)default charset utf8mb4;

create table Limpeza (
	IDLimpeza int primary key not null,
	NSerie int not null,
    foreign key (NSerie) references Arma(NSerie),
    RM int not null,
    foreign key (RM) references Soldado(RM),
    DataLimpeza datetime not null
)default charset utf8mb4;



