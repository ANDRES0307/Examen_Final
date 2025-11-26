import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  precio: number;
  imagen: string;
  modelo_3d: string;
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
  private apiUrl = 'http://localhost:3000/api';

  // --- VARIABLES DEL CARRITO ---
  cartItems: CartItem[] = [];
  private cartKey = 'my_cart_exam';

  constructor() {
    this.loadCart(); // Cargar carrito al iniciar
  }

  // --- API (BACKEND) ---
  getProductos(): Observable<Producto[]> {
    return this.http.get<Producto[]>(`${this.apiUrl}/productos`);
  }

  getProductoById(id: number): Observable<Producto> {
    return this.http.get<Producto>(`${this.apiUrl}/productos/${id}`);
  }

  crearOrden(orden: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ordenes`, orden);
  }

  // --- LÓGICA DEL CARRITO (LO QUE TE FALTABA) ---
  
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