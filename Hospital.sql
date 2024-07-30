create database db_aula4_Hospital;

use db_aula4_Hospital;


create table Paciente (
	CodRegistro int primary key not null,
    Nome varchar(75) not null,
    Endereco varchar(254) not null,
    DataNasc datetime not null
)default charset utf8mb4;


create table Medico (
	CRM int primary key not null,
    Nome varchar(75) not null,
    Especialidade varchar(75) not null
)default charset utf8mb4;


create table Medicamento (
	IDMedicamento int primary key not null,
    Nome varchar(75) not null,
    Farmaceutica varchar(75) not null,
    Validade datetime not null
)default charset utf8mb4;


create table Exame (
	NumSerie int primary key not null,
    Descricao varchar(254) not null,
    Realizacao datetime not null
)default charset utf8mb4;


create table Consulta (
	IDConsulta int primary key not null,
	CodRegistro int not null,
    foreign key (CodRegistro) references Paciente(CodRegistro),
    CRM int not null,
    foreign key (CRM) references Medico(CRM),
    DataConsulta datetime not null,
    Observacoes varchar(254) not null
)default charset utf8mb4;


create table Prescricao (
	IDPrescricao int primary key not null,
	IDConsulta int not null,
    foreign key (IDConsulta) references Consulta(IDConsulta),
    IDMedicamento int not null,
    foreign key (IDMedicamento) references Medicamento(IDMedicamento),
    Quantidade int not null
)default charset utf8mb4;


create table ConsultaExame (
	IDConsultaExame int primary key not null,
	IDConsulta int not null,
    foreign key (IDConsulta) references Consulta(IDConsulta),
    IDExame int not null,
    foreign key (IDExame) references Exame(IDExame),
    Observacoes varchar(254) not null
)default charset utf8mb4;