import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, of } from 'rxjs'; // <--- IMPORTANTE: Agregamos 'of'

export interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  precio: number;
  imagen: string;
  modelo_3d?: string; // El ? hace que sea opcional
}

// Interfaz para el item del carrito
export interface CartItem extends Producto {
  cantidad: number;
}

@Injectable({
  providedIn: 'root'
})
export class TiendaService {
  private http = inject(HttpClient);
  // private apiUrl = 'http://localhost:3000/api'; // YA NO LO NECESITAMOS

  // --- VARIABLES DEL CARRITO ---
  cartItems: CartItem[] = [];
  private cartKey = 'my_cart_exam';

  // --- DATOS FICTICIOS (HARDCODED) ---
  // Estos son los datos que se mostrarán siempre, sin base de datos.
  private productosFicticios: Producto[] = [
    {
      id: 1,
      nombre: 'Gibson Les Paul Standard',
      descripcion: 'La leyenda del rock. Incluye vista 3D exclusiva.',
      precio: 2500,
      imagen: 'assets/guitar_gibson.png', // Asegúrate de que esta imagen exista en assets (o public)
      modelo_3d: 'guitar_gibson_les_paul_standard.glb' // <--- TU ARCHIVO 3D DE LA CARPETA PUBLIC
    },
    {
      id: 2,
      nombre: 'Fender Stratocaster',
      precio: 1800,
      descripcion: 'Sonido brillante y versátil. Perfecta para blues y rock.',
      imagen: 'assets/guitarras.jpg' // Usé el nombre que vi en tu captura
    },
    {
      id: 3,
      nombre: 'Yamaha Pacifica',
      precio: 400,
      descripcion: 'La mejor opción calidad-precio para empezar.',
      imagen: 'assets/logo-gibson.png' // Usé el logo como imagen temporal
    }
  ];

  constructor() {
    this.loadCart(); 
  }

  // --- API FALSA (SIMULACIÓN) ---
  
  getProductos(): Observable<Producto[]> {
    // En lugar de this.http.get, devolvemos la lista falsa
    return of(this.productosFicticios);
  }

  getProductoById(id: number): Observable<Producto> {
    // Buscamos en la lista falsa
    const producto = this.productosFicticios.find(p => p.id == id);
    // Si no encuentra, devuelve el primero para que no falle
    return of(producto || this.productosFicticios[0]);
  }

  crearOrden(orden: any): Observable<any> {
    console.log('ORDEN GUARDADA (Simulada):', orden);
    // Simulamos que el servidor responde "OK"
    return of({ success: true, message: 'Orden creada con éxito' });
  }

  // --- LÓGICA DEL CARRITO (IGUAL QUE ANTES) ---
  
  addToCart(product: Producto) {
    const existing = this.cartItems.find(i => i.id === product.id);
    if (existing) {
      existing.cantidad++;
    } else {
      this.cartItems.push({ ...product, cantidad: 1 });
    }
    this.saveCart();
    alert('Producto agregado al carrito 🛒');
  }

  removeFromCart(id: number) {
    this.cartItems = this.cartItems.filter(i => i.id !== id);
    this.saveCart();
  }

  getTotal(): number {
    return this.cartItems.reduce((sum, item) => sum + (item.precio * item.cantidad), 0);
  }

  clearCart() {
    this.cartItems = [];
    this.saveCart();
  }

  // --- GUARDAR EN NAVEGADOR ---
  private saveCart() {
    if(typeof localStorage !== 'undefined') {
      localStorage.setItem(this.cartKey, JSON.stringify(this.cartItems));
    }
  }

  private loadCart() {
    if(typeof localStorage !== 'undefined') {
      const saved = localStorage.getItem(this.cartKey);
      if (saved) this.cartItems = JSON.parse(saved);
    }
  }
}