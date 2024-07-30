create database db_aula4_Ginastica;

use db_aula4_Ginastica;


create table Cliente (
	IDAluno int primary key not null,
    Nome varchar(75) not null,
    Endereco varchar(254) not null,
    DataNasc datetime not null,
    Instituicao varchar(75) null,
    Telefone char(14) not null,
    Sexo enum("M", "F", "PND") not null
)default charset utf8mb4;

create table Sala (
	IDSala int primary key not null,
    Descricao varchar(75) not null,
    Capacidade int not null
)default charset utf8mb4;


create table Modalidade(
	IDModalidade int primary key not null,
    Descricao varchar(150) not null
)default charset utf8mb4;


create table Professor (
	IDProfessor int primary key not null,
    Nome varchar(75) not null,
    Sobrenome varchar(150) not null,
    Telefone char(14) not null
)default charset utf8mb4;


create table Aula (
	IDAula int primary key not null,
    Dificuldade enum("Facil", "Medio", "Dificil") not null,
    IDModalidade int,
    foreign key (IDModalidade) references Modalidade(IDModalidade),
    IDProfessor int,
    foreign key (IDProfessor) references Professor(IDProfessor),
    IDSala int,
    foreign key (Sala) references Sala(IDSala)
)default charset utf8mb4;


create table ClienteAula (
	IDClienteAula int primary key not null,
    IDCliente int,
    foreign key (IDCliente) references Cliente(IDCliente),
    IDAula int,
    foreign key (IDAula) references Aula(IDAula),
    Participou bit    
)default charset utf8mb4;