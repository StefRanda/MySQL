Markdown
# 📊 Sistema de Extracción SQL y Pipeline de Datos (MySQL + Docker + Excel)

Diseñé una estructura de datos relacional y normalizada en MySQL para gestionar clientes y ventas. Para procesarla, implementé un pipeline de datos automatizado desde la terminal de Linux que extrae la información consolidada mediante queries complejas y la exporta directamente a formatos planos para su posterior auditoría y consumo en Excel.

Este repositorio contiene un práctico integral desarrollado para demostrar habilidades técnicas clave que conectan la ingeniería de infraestructura con el análisis de negocio comercial.

---

## 🏗️ 1. Infraestructura y Motor de Datos (Docker Compose)

La base de datos se administra de manera aislada utilizando **Docker Compose** con el fin de asegurar portabilidad, rapidez de despliegue y persistencia de la información mediante volúmenes comerciales.

### Configuración del Entorno (`docker-compose.yml`)
```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8.0
    container_name: mysql-server
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: educativo
      MYSQL_USER: myuser
      MYSQL_PASSWORD: myuserpassword
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    restart: unless-stopped

volumes:
  mysql_data:
Inicialización de la Infraestructura:
Bash
docker compose up -d
💾 2. Estructura de Datos (Diseño SQL)
Se configuró un entorno exclusivo para almacenar el código fuente del modelo relacional:

Bash
mkdir -p practica-sql/sql
cd practica-sql
A través de un script estructurado, se definieron las lógicas de DDL (creación de tablas, claves primarias, claves foráneas e integridad relacional) y de DML (poblamiento de registros de simulación comercial para clientes, productos y ventas).

Archivo de Definición y Manipulación (sql/script.sql)
SQL
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
Inyección de datos automatizada al contenedor:
Bash
docker exec -i mysql-server mysql -u root -prootpassword educativo < sql/script.sql
🔌 3. El Pipeline de Extracción (SQL a CSV)
Para conectar el motor relacional con las herramientas de análisis gerencial, 
se desarrolló una consulta estructurada utilizando INNER JOIN. El objetivo es 
cruzar las llaves foráneas de la tabla de hechos con sus respectivas dimensiones 
y calcular en tiempo de ejecución el ingreso financiero bruto (precio * cantidad).

Mediante operadores de Linux, el flujo se redirigió directamente a un archivo 
plano de intercambio estructurado (.csv):

Bash
docker exec -i mysql-server mysql -u root -prootpassword educativo -e \
"SELECT v.id_venta, c.nombre AS cliente, c.pais, p.articulo, p.precio, v.cantidad, (p.precio * v.cantidad) AS total_venta, v.fecha \
FROM ventas v \
INNER JOIN clientes c ON v.id_cliente = c.id_cliente \
INNER JOIN productos p ON v.id_producto = p.id_producto;" > reporte_ventas.csv
📊 4. Consumo, Modelado y Análisis en Microsoft Excel
El entregable final de este proceso consiste en la conversión y procesamiento 
de las estructuras consolidadas en Microsoft Excel (.xlsx), transformando los datos
 planos en un reporte ejecutivo e interactivo para la toma de decisiones:

Modelado Financiero: Uso de fórmulas de cálculo automatizado para determinar 
ingresos por transacción e integridad de las métricas comerciales.

Tablas Dinámicas: Segmentación automatizada de la facturación global y 
volúmenes de venta agrupados geográficamente por país de origen del cliente.

Visualización de Datos (Dashboards): Incorporación de gráficos dinámicos 
interactivos para identificar rápidamente los mercados de mayor rendimiento monetario.

El archivo final trabajado Analisis_Ventas_Educativo.xlsx se encuentra 
disponible en la raíz de este repositorio.

🚀 5. Control de Versiones
El código fuente de la infraestructura y el modelo relacional se gestionan 
mediante comandos de control de versiones:

Bash
# Vincular el repositorio local con el servidor remoto de GitHub
git remote add origin [https://github.com/StefRanda/MySQL.git](https://github.com/StefRanda/MySQL.git)

# Subir el código de forma definitiva a la rama principal
git push -u origin main
