use oficina;

insert into cliente (Cliente, Telefone, Endereco) values 
	("João Silva", "123456789", "Rua A, 123, Cidade X"),
    ("Maria Oliveira", "987654321", "Av. B, 456, Cidade Y"),
    ("Carlos Santos", "456123789", "Rua C, 789, Cidade Z");
    

alter table carro modify column Ano int;
    
    
insert into carro (Marca, Modelo, Ano, Placar) values 
	("Ford", "Fiesta", 2018, "ABC-1234"),
    ("Chevrolet", "Onix", 2020, "DEF-5678"),
    ("Volkswagen", "Gol", 2019, "GHI-9101"),
    ("Toyota", "Corolla", 2021, "JKL-1122");
    
    
insert into servico (Tipo, Descricao, Preco) values 
	("Troca de óleo", "Troca de óleo", 150.00),
    ("Troca de pneus", "Troca de pneus", 300.00),
	("Revisão periódica", "Revisão periódica", 200.00),
	("Reparo elétrico", "Reparo elétrico", 180.00);
    
alter table ordem modify column DataSaida datetime null;
    
insert into ordem (idCliente, idCarro, DataEntrada, DataSaida, Status, Observacoes) values 
	(1, 1, "2024-07-15 12:00:00", "2024-07-16 12:00:00", "Concluída", "Troca de óleo e filtro"),
	(2, 3, "2024-07-20 12:00:00", "2024-07-22 12:00:00", "Em andamento", "Troca de pneus"),
	(1, 2, "2024-07-25 12:00:00", NULL, "Em andamento", "Revisão periódica e alinhamento"),
	(3, 4, "2024-07-28 12:00:00", "2024-07-30 12:00:00", "Concluída", "Reparo elétrico no painel");
    
    
