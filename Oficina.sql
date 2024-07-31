CREATE DATABASE db_oficina;

USE db_oficina;

CREATE TABLE Cliente (
	IDCLiente INT PRIMARY KEY AUTO_INCREMENT, 
    Contato varchar(20)
);

CREATE TABLE PessoaJuridica (
	IDPJ INT PRIMARY KEY AUTO_INCREMENT, 
    Razao_Social VARCHAR(75), 
    CNPJ CHAR(15),
    FOREIGN KEY (IDPJ) REFERENCES Cliente(IDCLiente) 
);

CREATE TABLE PessoaFisica (
	IDPF INT PRIMARY KEY AUTO_INCREMENT, 
    Nome VARCHAR(75), 
    CPF CHAR(11),
    FOREIGN KEY (IDPF) REFERENCES Cliente(IDCLiente) 
);

CREATE TABLE Carro (
	IDCarro INT PRIMARY KEY AUTO_INCREMENT, 
    Marca VARCHAR(15), 
    Modelo VARCHAR(15), 
    Ano INT
);

CREATE TABLE Servico (
	IDServico INT PRIMARY KEY AUTO_INCREMENT, 
    Descricao VARCHAR(30)
);

CREATE TABLE ItensDeServico (
	IDItem INT PRIMARY KEY AUTO_INCREMENT, 
    Descricao VARCHAR(75), 
    IDServico INT
);

CREATE TABLE OrdemDeServico (
	IDOrdem INT PRIMARY KEY AUTO_INCREMENT,
    IDCliente INT,
    FOREIGN KEY (IDCliente) REFERENCES Cliente(IDCLiente) 
);

CREATE TABLE OrdemCarro (
	IDOrdemCarro INT PRIMARY KEY AUTO_INCREMENT, 
    IDOrdem INT, 
    IDCarro INT, 
    FOREIGN KEY (IDOrdem) REFERENCES OrdemDeServico(IDOrdem), 
    FOREIGN KEY (IDCarro) REFERENCES Carro(IDCarro)
);

CREATE TABLE OrdemItem (
	IDOrdemItem INT PRIMARY KEY AUTO_INCREMENT, 
    IDOrdem INT, 
    IDItem INT,
    Quantidade FLOAT,
    FOREIGN KEY (IDOrdem) REFERENCES OrdemDeServico(IDOrdem), 
    FOREIGN KEY (IDItem) REFERENCES ItensDeServico(IDItem)
);

CREATE TABLE OrdemServico (
	IDOrdemServico INT PRIMARY KEY AUTO_INCREMENT, 
    IDOrdem INT,
    IDServico INT,
    FOREIGN KEY (IDOrdem) REFERENCES OrdemDeServico(IDOrdem), 
	FOREIGN KEY (IDServico) REFERENCES Serviço(IDServico)
);

