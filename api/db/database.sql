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
