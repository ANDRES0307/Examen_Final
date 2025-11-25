CREATE DATABASE tienda_examen;
USE tienda_examen;

-- 1. Tabla Productos (Incluye columna para el modelo 3D)
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    imagen VARCHAR(255),
    modelo_3d VARCHAR(255) 
);

-- 2. Tabla Ordenes (Para el Checkout)
CREATE TABLE ordenes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_nombre VARCHAR(100) NOT NULL,
    cliente_correo VARCHAR(100) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL
);

-- 3. Tabla Detalle de Orden (Qué productos compró)
CREATE TABLE detalle_orden (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES ordenes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- DATOS DE EJEMPLO
INSERT INTO productos (nombre, descripcion, precio, imagen, modelo_3d) VALUES 
('Guitarra Eléctrica', 'Fender Stratocaster clásica.', 250.00, 'https://cdn-icons-png.flaticon.com/512/4433/4433066.png', 'guitarra'),
('Laptop Gamer', 'Potencia extrema para jugar.', 1200.00, 'https://cdn-icons-png.flaticon.com/512/428/428001.png', 'laptop'),
('Auriculares', 'Sonido envolvente 7.1.', 80.00, 'https://cdn-icons-png.flaticon.com/512/4433/4433161.png', 'auriculares');