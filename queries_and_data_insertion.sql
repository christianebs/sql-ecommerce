-- inserção de dados e queries

use ecommerce;

show tables;

-- idClient, Fname, Minit, Lname, CPF, Address
insert into Clients (Fname, Minit, Lname, CPF, Address)
		values ('Maria', 'M', 'Silva', '123456789', 'Avenida Vieira Souto, 1 - Ipanema - Rio de Janeiro'),
				('João', 'O', 'Ferraz', '223456789', 'Avenida Atlântica, 2 - Copacabana - Rio de Janeiro'),
				('Elisa', 'E', 'Oliveira', '323456789', 'Avenida Epitácio Pessoa, 3 - Lagoa - Rio de Janeiro'),
                ('Valentina', 'F', 'Nunes', '423456789', 'Rua Visconde de Pirajá, 4 - Ipanema - Rio de Janeiro'),
                ('Enzo', 'P', 'Lobato', '523456789', 'Rua da Glória, 5 - Glória - Rio de Janeiro'),
                ('Maitê', 'C', 'Santos', '623456789', 'Avenida Rio Branco, 6 - Centro - Rio de Janeiro');
                
-- idProduct, Pname, classification_kids boolean, category('Eletrônico', 'Vestuário', 'Brinquedos', 'Alimentos', 'Móveis'), avaliation, size
insert into product (Pname, classification_kids, category, avaliation, size)
		values ('Fone de Ouvido',false,'Eletrônico','4',null),
				('Barbie',true,'Brinquedos','3',null),
                ('Body Carters',true,'Vestuário','5',null),
                ('Microfone Vedo - Youtuber',False,'Eletrônico','4',null),
                ('Sofá Retrátil',false,'Móveis','3','3x57x80'),
                ('Farinha de Arroz',false,'Alimentos','2',null),
                ('Fire Stick Amazon',false,'Eletrônico','3',null);

select * from clients;
select * from product;

-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
delete from orders where idOrderClient in (1, 2, 3, 4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (1, default, 'compra via aplicativo', null, 1),
				(2, default, 'compra via aplicativo', 50, 0),
                (3, 'Confirmado', null, null, 1),
                (4, null, 'compra via web site', 150, 0);

-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) 
		values (1, 5, 2, null),
				(2, 5, 1, null),
                (3, 6, 1, null);
                
-- storageLocation, quantity
insert into productStorage ()
		values ('Rio de Janeiro', 1000),
				('Rio de Janeiro', 500),
                ('São Paulo', 10),
                ('São Paulo', 100),
                ('São Paulo', 10),
                ('Brasília', 60);
                
-- idLproduct, idLstorage, location
insert into storageLocation(idLproduct, idLstorage, location)
		values (1, 2, 'RJ'),
				(2, 6, 'GO');

-- idSupplier, SocialName, CNPJ, contact
insert into supplier(idSupplier, SocialName, CNPJ, contact)
		values ('Almeida e filhos','123456789123456','23456789'),
				('Eletrônicos dos Amigos','223456789123456','33456789'),
				('Eletrônicos ELLO','323456789123456','43456789');

select * from supplier;
-- idPsSuplier, idPsProduct, quantity
insert into productSupplier(idPsSuplier, idPsProduct, quantity)
		values (1, 1, 500),
				(1, 2, 400),
                (2, 4, 633),
                (3, 3, 5),
                (2, 5, 10);
                
-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller(SocialName, AbstName, CNPJ, CPF, location, contact)
		values ('Tech Eletronics', null, 123456789456, null, 'Rio de Janeiro', 2199456789),
				('Gira Roupas', null, null, 1234566788, 'Rio de Janeiro', 2193456789),
                ('Kids World', null, 223456789456, null, 'São Paulo', 11912345678);

select * from seller;

-- idPsSuplier, idPsProduct, quantity
insert into productSupplier(idPsSuplier, idPsProduct, quantity)
		values (1, 6, 80),
				(2, 7, 10);
                
select * from productSeller;

select count(*) from clients;
select * from clients c, orders o where c.idClient = idOrderClient;

select Fname, Lname, idOrder, orderStatus from clients c, orders o where c.idClient = idOrderClient;
select concat(Fname,' ',Lname) as Client, idOrder as Request, orderStatus as Status from clients c, orders o where c.idClient = idOrderClient;

insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (2, default, 'compra via aplicativo', null, 1);

select count(*) from clients c, orders o 
		where c.idClient = idOrderClient;

select * from orders;

-- recueração de pedido com produto associado
select * from clients c
		inner join orders o ON c.idClient = o.idOrderClient
        inner join productOrder p on o.idPOorder = o.idOrder
        group by idClient;

-- Recuperar quantos pedidos foram realizados pelos clientes?     
select c.idClient, Fname, count(*) as Number_of_orders from clients c
		inner join orders o ON c.idClient = o.idOrderClient
        group by idClient;