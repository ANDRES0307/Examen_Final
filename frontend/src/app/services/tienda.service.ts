import { Injectable, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

// 1. ¡OJO AQUÍ! Debe decir "export interface"
export interface Producto {
  id: number;
  nombre: string;
  descripcion: string;
  precio: number;
  imagen: string;
  modelo_3d: string;
}

@Injectable({
  providedIn: 'root'
})
// 2. ¡OJO AQUÍ! Debe decir "export class"
export class TiendaService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:3000/api';

  getProductos(): Observable<Producto[]> {
    return this.http.get<Producto[]>(`${this.apiUrl}/productos`);
  }

  getProductoById(id: number): Observable<Producto> {
    return this.http.get<Producto>(`${this.apiUrl}/productos/${id}`);
  }

  crearOrden(orden: any): Observable<any> {
    return this.http.post(`${this.apiUrl}/ordenes`, orden);
  }
}