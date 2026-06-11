create database Tienda;

use tienda;

create table Productos
(
	id_producto int primary key auto_increment,
	Nombre varchar(30) not null,
    Descripcion varchar(35),
    Precio decimal(10,2)
);


create table Clientes
(
	id_cliente int primary key auto_increment,
    Nombre varchar(25)  not null,
    Apellido varchar(25),
    correo varchar(55) not null,
    Direccion varchar(35) not null
);


create table Pedidos
(
	id_pedido int primary key auto_increment,
    Estado varchar(20),
    Fecha date,
    id_cliente int,
    foreign key (id_cliente) references Clientes(id_cliente)
);


create table PedidoComps
(
	id_pedidocomp int primary key auto_increment,
    cantidad int,
    id_pedido int,
    id_producto int,
    foreign key (id_pedido) references Pedidos(id_pedido),
    foreign key (id_producto) references Productos(id_producto)
);



INSERT INTO Clientes (Nombre, Apellido, correo, Direccion) 
VALUES 
('Carlos', 'Gómez', 'carlos.gomez@email.com', 'Av. Corrientes 1234'),
('María', 'Rodríguez', 'maria.rod@email.com', 'Calle Florida 550'),
('Juan', 'Martínez', 'juan.mar@email.com', 'Belgrano 890'),
('Ana', 'Fernández', 'ana.fer@email.com', 'San Martín 112'),
('Luis', 'López', 'luis.lopez@email.com', 'Rivadavia 4321');

INSERT INTO Productos (Nombre, Descripcion, Precio) VALUES
('Teclado Mecánico', 'Teclado RGB switch azul', 45000.00),
('Mouse Gamer', 'Mouse óptico 12000 DPI', 25000.00),
('Monitor 24"', 'Monitor Full HD 75Hz', 180000.00),
('Auriculares Inalámbricos', 'Auriculares con cancelacion ruido', 35000.00),
('Pad Mouse XL', 'Superficie de tela 90x40cm', 12000.00);

insert INTO productos(nombre,descripcion,precio)
values
('Parlantes RGB', 'Sonido claro, envolvente con una iluminación LED dinámica', 200000.00);
-- un registro extra que use para probar las consultas

INSERT INTO Pedidos (Estado, Fecha, id_cliente) VALUES
('Entregado', '2026-05-10', 1),
('Pendiente', '2026-06-01', 2),
('Cancelado', '2026-06-02', 3),
('En proceso', '2026-06-08', 4),
('Entregado', '2026-06-09', 1);

INSERT INTO PedidoComps (cantidad, id_pedido, id_producto) VALUES
(1, 1, 3),
(2, 1, 1),
(1, 2, 2),
(1, 3, 4), 
(3, 4, 5), 
(1, 5, 1); 


-- Consulta 1
SELECT P.nombre, P.precio
from productos p
where p.precio >= 50000;

-- Consulta 2

SELECT *
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.Nombre, c.Apellido, c.correo, c.Direccion;


-- Consulta 3

SELECT C.NOMBRE, C.Apellido, P.FECHA
FROM CLIENTES C
INNER JOIN pedidos P ON c.id_cliente = p.id_cliente
where p.estado = 'Entregado';

-- Consulta 4

SELECT P.Estado, C.Correo
from clientes c
inner join pedidos p on c.id_cliente = p.id_cliente;

-- Consulta 5

SELECT c.Nombre, c.Apellido, p.Fecha
FROM Clientes c
INNER JOIN Pedidos p ON c.id_cliente = p.id_cliente
WHERE p.Fecha = (SELECT MAX(Fecha) FROM Pedidos);

-- Consulta 6

SELECT c.Nombre, c.Apellido, p.Fecha, p.Estado
FROM clientes c
inner join pedidos p on c.id_cliente = p.id_cliente
where p.Estado = 'Pendiente';


-- Consulta 7

SELECT Nombre, Precio
FROM Productos
WHERE Precio = (SELECT MAX(Precio) FROM Productos);
