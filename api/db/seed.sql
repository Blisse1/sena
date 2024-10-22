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
