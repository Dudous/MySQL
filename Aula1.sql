create database db_senai;

use db_senai;

create table Aluno (
	IDAluno int primary key auto_increment not null,
    NomeAluno varchar(75) not null,
    SobrenomeAluno varchar(50) not null
)default charset utf8mb4;

create table Professor (
	IDProfessor int primary key auto_increment not null,
    NomeProfessor varchar(75) not null,
    SobrenomeProfessor varchar(60) not null
)default charset utf8mb4;

create table Turma (
	IDTurma int primary key auto_increment not null,
    IDAluno int,
    foreign key (IDAluno) references Aluno(IDAluno),
    IDProfessor int,
    foreign key (IDProfessor) references Professor(IDProfessor)
)default charset utf8mb4;

drop table Aluno;

drop table Professor;

