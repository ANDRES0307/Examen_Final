import { createPool } from 'mysql2/promise';

// Eliminamos dotenv para evitar problemas de lectura
// import dotenv from 'dotenv';
// dotenv.config();

export const pool = createPool({
    host: 'localhost',
    user: 'root',
    password: '', // En XAMPP suele ser vacío
    database: 'tienda_examen'
});