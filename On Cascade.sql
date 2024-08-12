drop database db_legiaoUrbana;

create database db_legiaoUrbana;

use db_legiaoUrbana;

create table tb_pai (
	id_pai smallint(6) primary key,
    nome_pai varchar(50)
);
    
create table tb_filho (
	id_filho smallint(6) primary key,
    nome_filho varchar(50),
    id_pai smallint(6),
    foreign key(id_pai) references tb_pai(id_pai)
    on delete restrict
    on update cascade
);

insert into tb_pai values 
	(1, "Darth Vader"),
	(2, "Goku"),
	(3, "Vegeta"),
    (4, "Seu Cebola"),
    (5, "Zurg"),
    (6, "Neymar");


insert into tb_filho values 
	(1, "Luke Skywalker", 1),
	(2, "Gohan", 2),
	(3, "Trunks", 3),
	(4, "Cebolinha", 4),
	(5, "Buzz Ligthyear", 5),
	(6, "Neymar Jr", 6);


delete from tb_pai where id_pai = 1;

delete from tb_filho where id_filho = 4;

select * from tb_filho;

select * from tb_pai;