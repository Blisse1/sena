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
    estado BOOL,
    nombre VARCHAR(100) NOT NULL,
    categoria_id INT,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    stock INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE facturas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    FECHA DATE NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE detalle_facturas(
    id INT PRIMARY KEY AUTO_INCREMENT,
    factura_id INT,
    producto_id INT,
    cantidad INT NOT NULL,
    FOREIGN KEY (factura_id) REFERENCES facturas(id)
    ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id)
    ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO clientes (nombre, apellido, empresa, telefono, direccion) VALUES
('juan', 'pérez', 'tech solutions', '555-1234', 'av. libertador 1234'),
('ana', 'martínez', 'marketing sa', '555-5678', 'calle 9 de julio 876'),
('luis', 'gómez', 'construcciones gómez', '555-8765', 'calle corrientes 2345');

INSERT INTO categorias (nombre) VALUES
('electrónica'),
('herramientas'),
('mobiliario');

INSERT INTO productos (nombre, categoria_id, precio_unitario, stock) VALUES
('laptop', 1, 1200.00, 50),
('taladro', 2, 150.00, 30),
('escritorio', 3, 225.00, 20),
('ratón', 1, 25.00, 100),
('teclado', 1, 45.00, 80);

INSERT INTO facturas (cliente_id, fecha) VALUES
(1, '2024-08-22'),
(2, '2024-08-22'),
(3, '2024-08-22');

INSERT INTO detalle_facturas (factura_id, producto_id, cantidad) VALUES
(1, 1, 1),
(1, 4, 2),
(1, 5, 1), 
(2, 2, 2),  
(3, 3, 2);
   
CREATE VIEW vista_facturas_totales AS
SELECT 
    f.id AS factura_id,
    f.cliente_id,
    f.fecha,
    SUM(p.precio_unitario * df.cantidad) AS total_calculado
FROM 
    facturas f
JOIN 
    detalle_facturas df ON f.id = df.factura_id
JOIN 
    productos p ON df.producto_id = p.id
GROUP BY 
    f.id, f.cliente_id, f.fecha;

SELECT * FROM vista_facturas_totales WHERE factura_id = 1;
