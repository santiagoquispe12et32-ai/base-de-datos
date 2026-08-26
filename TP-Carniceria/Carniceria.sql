create database Carniceria;

use carniceria;

CREATE TABLE Carniceros (
    id_carnicero int primary key auto_increment,
    nombre varchar(20),
    apellido varchar(25),
    dni varchar(15) not null
);

CREATE TABLE Clientes (
    id_cliente int primary key auto_increment,
    nombre varchar(20),
    apellido varchar(25),
    telefono varchar(20) not null
);

CREATE TABLE Pedidos (
    id_pedido int primary key auto_increment,
    id_cliente int ,
    id_carnicero int,
    precio_total decimal(10,2),
    medio_pago varchar(20),
    
    foreign key (id_cliente) references Clientes(id_cliente),
    foreign key (id_carnicero) references Carniceros(id_carnicero)
);

CREATE TABLE Cortes (
	id_corte int primary key auto_increment,
    corte_carne varchar(25),
    precio_xkg decimal(10,2)
);

CREATE TABLE PedidosCortes (
	id_pedido_corte int primary key auto_increment,
    id_corte int,
    id_pedido int,
    cantidad_kg decimal (5,3),
    
    
    foreign key (id_corte) references Cortes(id_corte),
    foreign key (id_pedido) references Pedidos(id_pedido)
);

INSERT INTO Carniceros (nombre, apellido, dni) VALUES
('Juan', 'Perez', '30111222'),
('Pedro', 'Gomez', '32444555'),
('Luis', 'Lopez', '35666777');

INSERT INTO Clientes (nombre, apellido, telefono) VALUES
('Carlos', 'Martinez', '1122334455'),
('Ana', 'Rodriguez', '1166778899'),
('Miguel', 'Fernandez', '1144556677');

INSERT INTO Cortes (corte_carne, precio_xkg) VALUES
('Asado', 8500.00),
('Vacío', 9000.00),
('Matambre', 9500.00);


INSERT INTO Pedidos (id_cliente, id_carnicero, precio_total, medio_pago) VALUES
(1, 1, 17000.00, 'Efectivo'),
(2, 2, 18000.00, 'Debito'),
(3, 3, 9500.00, 'Transferencia');


INSERT INTO PedidosCortes (id_corte, id_pedido, cantidad_kg) VALUES
(1, 1, 2.000),
(2, 2, 2.000),
(3, 3, 1.000);


SELECT c.corte_carne, SUM(pc.cantidad_kg) AS kilos_vendidos
FROM Cortes c
INNER JOIN PedidosCortes pc ON c.id_corte = pc.id_corte
GROUP BY c.id_corte, c.corte_carne
ORDER BY kilos_vendidos DESC;


SELECT c.nombre, c.apellido, COUNT(p.id_pedido) AS cantidad_compras
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.apellido
ORDER BY cantidad_compras DESC;

SELECT ca.nombre, ca.apellido, COUNT(p.id_cliente) AS clientes_atendidos
FROM Carniceros ca
INNER JOIN Pedidos p ON ca.id_carnicero = p.id_carnicero
GROUP BY ca.id_carnicero, ca.nombre, ca.apellido
ORDER BY clientes_atendidos DESC;

SELECT p.id_pedido, cl.nombre, cl.apellido, c.corte_carne, pc.cantidad_kg, ca.nombre, ca.apellido, p.precio_total
FROM Pedidos p
INNER JOIN Clientes cl ON p.id_cliente = cl.id_cliente
INNER JOIN Carniceros ca ON p.id_carnicero = ca.id_carnicero
INNER JOIN PedidosCortes pc ON p.id_pedido = pc.id_pedido
INNER JOIN Cortes c ON pc.id_corte = c.id_corte
ORDER BY p.precio_total DESC;


SELECT c.corte_carne, COUNT(pc.id_pedido_corte) AS cantidad_ventas
FROM Cortes c
INNER JOIN PedidosCortes pc ON c.id_corte = pc.id_corte
GROUP BY c.id_corte, c.corte_carne;