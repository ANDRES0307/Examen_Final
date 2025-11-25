import express from 'express';
import cors from 'cors';
import { pool } from './db.js';

const app = express();
app.use(cors());
app.use(express.json());

// 1. Obtener Productos
app.get('/api/productos', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM productos');
        res.json(rows);
    } catch (e) { res.status(500).json({ error: e.message }); }
});

// 2. Obtener 1 Producto (Para el detalle)
app.get('/api/productos/:id', async (req, res) => {
    try {
        const [rows] = await pool.query('SELECT * FROM productos WHERE id = ?', [req.params.id]);
        rows.length ? res.json(rows[0]) : res.status(404).json({ msg: 'No encontrado' });
    } catch (e) { res.status(500).json({ error: e.message }); }
});

// 3. REGISTRAR COMPRA (Requisito clave del examen)
app.post('/api/ordenes', async (req, res) => {
    const { nombre, correo, total, detalles } = req.body; 

    try {
        // A. Guardar orden
        const [result] = await pool.query(
            'INSERT INTO ordenes (cliente_nombre, cliente_correo, total) VALUES (?, ?, ?)',
            [nombre, correo, total]
        );
        const ordenId = result.insertId;

        // B. Guardar detalles (Loop)
        for (let item of detalles) {
            await pool.query(
                'INSERT INTO detalle_orden (orden_id, producto_id, cantidad, precio_unitario) VALUES (?, ?, ?, ?)',
                [ordenId, item.producto_id, item.cantidad, item.precio_unitario]
            );
        }
        res.json({ message: 'Exito', id: ordenId });
    } catch (e) {
        console.error(e);
        res.status(500).json({ error: 'Error al comprar' });
    }
});

app.listen(3000, () => console.log('Servidor corriendo en puerto 3000'));