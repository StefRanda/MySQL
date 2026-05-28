-- ==========================================
-- 1. SECCIÓN DDL (Data Definition Language)
-- ==========================================
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    categoria VARCHAR(20) DEFAULT 'Regular'
);

CREATE TABLE IF NOT EXISTS productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    articulo VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

CREATE TABLE IF NOT EXISTS ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT NOT NULL,
    fecha DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- ==========================================
-- 2. SECCIÓN DML (Data Manipulation Language)
-- ==========================================
INSERT INTO clientes (nombre, pais, categoria) VALUES
('Juan Pérez', 'Argentina', 'VIP'),
('Ana López', 'Chile', 'Regular'),
('Carlos Gómez', 'Argentina', 'Regular'),
('María Castillo', 'Uruguay', 'VIP'),
('Luis Fernández', 'Chile', 'Regular');

INSERT INTO productos (articulo, precio) VALUES
('Notebook Pro', 1200.00),
('Monitor 24 Pulgadas', 250.00),
('Teclado Mecánico', 80.00),
('Mouse Inalámbrico', 40.00);

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha) VALUES
(1, 1, 1, '2026-05-10'),
(2, 3, 2, '2026-05-11'),
(3, 2, 1, '2026-05-12'),
(4, 1, 1, '2026-05-14'),
(1, 4, 3, '2026-05-15'),
(5, 2, 2, '2026-05-16');
