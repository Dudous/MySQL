-- Criação do banco de dados
drop database if exists DetranDB;
CREATE DATABASE DetranDB;
USE DetranDB;

-- Tabela para registrar proprietários
CREATE TABLE Proprietarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    pontos_carteira INT DEFAULT 0
);

-- Tabela para registrar veículos
CREATE TABLE Veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(255) NOT NULL,
    modelo VARCHAR(255) NOT NULL,
    placa VARCHAR(7) UNIQUE NOT NULL,
    ano INT,
    proprietario_id INT,
    FOREIGN KEY (proprietario_id) REFERENCES Proprietarios(id)
);

-- Tabela para registrar infrações de trânsito
CREATE TABLE Infracoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255) NOT NULL,
    gravidade ENUM('Leve', 'Média', 'Grave', 'Gravíssima'),
    data_ocorrencia DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
);

-- Tabela para registrar licenciamentos dos veículos
CREATE TABLE Licenciamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_validade DATE NOT NULL,
    veiculo_id INT,
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(id)
);

-- Tabela para registrar multas aplicadas
CREATE TABLE Multas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valor DECIMAL(10, 2) NOT NULL,
    pontos INT DEFAULT 0,
    data_aplicacao DATE NOT NULL,
    infracao_id INT,
    FOREIGN KEY (infracao_id) REFERENCES Infracoes(id)
);

-- Inserção de dados nas tabelas
-- Proprietarios
INSERT INTO Proprietarios (nome, cpf, endereco, telefone) VALUES
('João Silva', '12345678901', 'Rua A, 123', '(11) 1234-5678'),
('Maria Oliveira', '98765432101', 'Rua B, 456', '(11) 9876-5432'),
('Carlos Souza', '11122233344', 'Rua C, 789', '(11) 1111-2222'),
('Ana Lima', '55566677788', 'Rua D, 1011', '(11) 5555-6666'),
('Pedro Costa', '99988877766', 'Rua E, 1213', '(11) 9999-8888');

-- Veiculos
INSERT INTO Veiculos (marca, modelo, placa, ano, proprietario_id) VALUES
('Fiat', 'Uno', 'ABC1234', 2020, 1),
('Volkswagen', 'Gol', 'DEF5678', 2018, 2),
('Chevrolet', 'Onix', 'GHI9101', 2021, 3),
('Ford', 'Ka', 'JKL1112', 2019, 4),
('Honda', 'Civic', 'MNO1314', 2022, 5),
('Toyota', 'Corolla', 'PQR1516', 2020, 1),
('Hyundai', 'HB20', 'STU1718', 2017, 2),
('Renault', 'Kwid', 'VWX1920', 2018, 3),
('Nissan', 'Versa', 'YZA2122', 2019, 4),
('Jeep', 'Compass', 'BCD2324', 2021, 5);

-- Infracoes
INSERT INTO Infracoes (descricao, gravidade, data_ocorrencia, veiculo_id) VALUES
('Excesso de velocidade', 'Média', '2024-04-20', 1),
('Estacionamento irregular', 'Leve', '2024-04-21', 2),
('Ultrapassagem em local proibido', 'Grave', '2024-04-22', 3),
('Falta de cinto de segurança', 'Leve', '2024-04-23', 4),
('Dirigir sob efeito de álcool', 'Gravíssima', '2024-04-24', 5),
('Uso de celular ao volante', 'Média', '2024-04-25', 6),
('Não respeitar a sinalização', 'Grave', '2024-04-26', 7),
('Estacionamento em vaga de idoso', 'Leve', '2024-04-27', 8),
('Falta de inspeção veicular', 'Grave', '2024-04-28', 9),
('Excesso de lotação', 'Média', '2024-04-29', 10);

-- Licenciamentos
INSERT INTO Licenciamentos (data_validade, veiculo_id) VALUES
('2024-04-30', 1),
('2023-05-01', 2),
('2023-05-02', 3),
('2024-05-03', 4),
('2023-05-04', 5),
('2024-05-05', 6),
('2025-05-06', 7),
('2012-05-07', 8),
('2022-05-08', 9),
('2008-05-09', 10);

-- Multas
INSERT INTO Multas (valor, pontos, data_aplicacao, infracao_id) VALUES
(150.00, 5, '2024-04-20', 1),
(100.00, 3, '2024-04-21', 2),
(500.00, 7, '2024-04-22', 3),
(80.00, 2, '2024-04-23', 4),
(2000.00, 10, '2024-04-24', 5),
(130.00, 4, '2024-04-25', 6),
(500.00, 7, '2024-04-26', 7),
(50.00, 2, '2024-04-27', 8),
(250.00, 6, '2024-04-28', 9),
(120.00, 4, '2024-04-29', 10);

create table Notificacoes (
	id int primary key auto_increment,
    texto text
);


-- Inserir um novo veículo e seu proprietário (com trigger)
DELIMITER $

create procedure pr_novo_veiculo(n_marca varchar(255), n_modelo varchar(255), n_placa char(8), n_ano int, n_nome varchar(150), n_cpf char(14), n_endereco varchar(255), n_telefone char(14))
begin
	insert into Proprietarios(nome, cpf, endereco, telefone) values
    (n_nome, n_cpf, n_endereco, n_telefone);
    
	set @n_id_proprietario = (select id from Proprietarios order by id desc limit 1);
    
    
    insert into Veiculos(marca, modelo, placa, ano, proprietario_id) values 
    (n_marca, n_modelo, n_placa, n_ano, @n_id_proprietario);
end
$
DELIMITER ;

call pr_novo_veiculo('Ferrari', 'F40', 'fdk5423', 1987, 'Enzo', '12354376509', 'rua dos burro', '41-2093899');

select * from veiculos;

-- Deletar um veículo e suas multas associadas (com trigger)



-- Inserir uma nova infração e atualizar multas associadas (com trigger)
-- Atualizar pontos na carteira de um proprietário específico que levou uma multa(com trigger)
-- Deletar um proprietário e seus veículos associados (com trigger)
-- Selecionar veículos com licenciamento expirado
-- Selecionar veículos que possuem multas graves
-- Selecionar veículos acima de 2021 
-- Selecionar multas de veículos abaixo de 2020
-- Selecionar todos os veículos com multas pendentes
-- Inserir um novo proprietário
-- Atualizar informações de um proprietário
-- Deletar um proprietário
-- Selecionar todos os proprietários
-- Inserir uma nova infração
-- Atualizar informações de uma infração
-- Deletar uma infração
-- Selecionar todas as infrações



-- Inserir um novo licenciamento

DELIMITER $
create procedure pr_add_licenciamento(n_data date, id_veiculo int)
begin
	insert into Licenciamentos (data_validade, veiculo_id) values
    (n_data, id_veiculo);
end
$
DELIMITER ;

call pr_add_licenciamento('2024-09-19', 7);

select * from Licenciamentos;

-- Atualizar informações de um licenciamento

DELIMITER $
create procedure pr_att_licenciamento(n_id int, n_data date)
begin
	update Licenciamentos
    set data_validade = n_data
    where id = n_id;
end
$
DELIMITER ;

call pr_att_licenciamento(1, '2025-4-30');

select * from Licenciamentos;