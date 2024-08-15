CREATE DATABASE IF NOT EXISTS jidoka;
USE jidoka;

CREATE TABLE IF NOT EXISTS Categoria (
    ID_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Categoria VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cliente (
    ID_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Cliente VARCHAR(100) NOT NULL,
    Empresa_Cliente VARCHAR(100) NOT NULL,
    Ciudad_Cliente VARCHAR(100) NOT NULL,
    Telefono_Cliente VARCHAR(15),
    Fecha_Registro DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Producto (
    ID_Producto INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Producto VARCHAR(100) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    ID_Categoria INT,
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria(ID_Categoria)
);

CREATE TABLE IF NOT EXISTS Factura (
    ID_Factura INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Vendedor VARCHAR(100) NOT NULL,
    Direccion_Empresa VARCHAR(255) NOT NULL,
    Ciudad_Empresa VARCHAR(100) NOT NULL,
    Telefono_Empresa VARCHAR(15),
    Fecha DATE NOT NULL,
    ID_Cliente INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

CREATE TABLE IF NOT EXISTS Detalle_Factura (
    ID_Factura INT,
    ID_Producto INT,
    Cantidad INT NOT NULL,
    Precio_Unitario DECIMAL(10, 2) NOT NULL,
    Valor_Total DECIMAL(10, 2) AS (Cantidad * Precio_Unitario) STORED,
    PRIMARY KEY (ID_Factura, ID_Producto),
    FOREIGN KEY (ID_Factura) REFERENCES Factura(ID_Factura),
    FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto)
);

INSERT INTO Categoria (Nombre_Categoria) VALUES 
('Electronica'),
('Ropa'),
('Alimentos'),
('Muebles'),
('Libros');

INSERT INTO Cliente (Nombre_Cliente, Empresa_Cliente, Ciudad_Cliente, Telefono_Cliente, Fecha_Registro) VALUES 
('Juan', 'Empresa 1', 'Medellin', '123456789', '2024-01-10'),
('Ana', 'Empresa 2', 'Bogota', '987654321', '2024-02-15'),
('Carlos', 'Empresa 3', 'Cali', '111222', '2024-03-20'),
('Lucia', 'Empresa 4', 'Medellin', '4333444', '2024-04-25'),
('Mario', 'Empresa 5', 'Cartagena', '99911122', '2024-05-30');

INSERT INTO Producto (Nombre_Producto, Precio, ID_Categoria) VALUES 
('Televisor', 500.00, 1), 
('Camiseta', 20.00, 2),
('Pan', 1.50, 3),
('Mesa', 150.00, 4),
('Libro de Programacion', 40.00, 5);

INSERT INTO Factura (Nombre_Vendedor, Direccion_Empresa, Ciudad_Empresa, Telefono_Empresa, Fecha, ID_Cliente) VALUES 
('Luis', 'Calle 50 #45-30', 'Medellin', '16161616', '2024-07-01', 1),
('Marta', 'Carrera 7 #32-15', 'Bogota', '12121212', '2024-07-02', 2),
('Pedro', 'Calle 10 #20-30', 'Cali', '444555', '2024-07-03', 3),
('Lorena', 'Carrera 43 #54-90', 'Barranquilla', '161111', '2024-07-04', 4),
('Raul', 'Calle 21 #14-50', 'Cartagena', '1234135', '2024-07-05', 5);

INSERT INTO Detalle_Factura (ID_Factura, ID_Producto, Cantidad, Precio_Unitario) VALUES 
(1, 1, 1, 500.00),
(2, 2, 3, 20.00),
(3, 3, 10, 1.50),
(4, 4, 1, 150.00),
(5, 5, 2, 40.00); 

SELECT * FROM Categoria;

SELECT * FROM Cliente WHERE Ciudad_Cliente = 'Medellin';

SELECT * FROM Producto WHERE ID_Categoria = 1;

SELECT * FROM Factura WHERE MONTH(Fecha) = 7 AND YEAR(Fecha) = 2024;

SELECT * FROM Detalle_Factura WHERE Cantidad > 1;
