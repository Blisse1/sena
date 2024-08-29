CREATE DATABASE IF NOT EXISTS sena;
USE sena;

CREATE TABLE clientes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    empresa VARCHAR(100),
    telefono VARCHAR(15),
    direccion VARCHAR(255)
);

CREATE TABLE categorias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE productos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    categoria_id INT,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    stock INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    total DECIMAL(10, 2) NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE detalle_facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES facturas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

INSERT INTO clientes (nombre, apellido, empresa, telefono, direccion) VALUES
('Juan', 'Pérez', 'Tech Solutions', '555-1234', 'Av. Libertador 1234'),
('Ana', 'Martínez', 'Marketing SA', '555-5678', 'Calle 9 de Julio 876'),
('Luis', 'Gómez', 'Construcciones Gómez', '555-8765', 'Calle Corrientes 2345');

INSERT INTO categorias (nombre) VALUES
('Electrónica'),
('Herramientas'),
('Mobiliario');

INSERT INTO productos (nombre, categoria_id, precio_unitario, stock) VALUES
('Laptop', 1, 1200.00, 50),
('Taladro', 2, 150.00, 30),
('Escritorio', 3, 225.00, 20),
('Ratón', 1, 25.00, 100),
('Teclado', 1, 45.00, 80);

INSERT INTO facturas (cliente_id, total, fecha) VALUES
(1, 1250.00, '2024-08-22'),
(2, 300.00, '2024-08-22'),
(3, 450.00, '2024-08-22');

INSERT INTO detalle_facturas (factura_id, producto_id, cantidad) VALUES
(1, 1, 1),
(1, 4, 2),
(1, 5, 1), 
(2, 2, 2),  
(3, 3, 2);   
