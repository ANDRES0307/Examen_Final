import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms'; // Necesario para los inputs del formulario
import { Router } from '@angular/router';     // Para redirigir al inicio al terminar
import { TiendaService } from '../../services/tienda.service';

@Component({
  selector: 'app-checkout',
  standalone: true,
  imports: [CommonModule, FormsModule], 
  templateUrl: './checkout.html',
  styleUrl: './checkout.css'
})
export class CheckoutComponent {
  
  public tiendaService = inject(TiendaService);
  private router = inject(Router);

  // Modelo para los datos del formulario
  datos = {
    nombre: '',
    correo: ''
  };

  pagar() {
    // 1. Validar que el carrito no esté vacío
    if (this.tiendaService.cartItems.length === 0) {
      alert('Tu carrito está vacío');
      return;
    }

    // 2. Validar formulario básico
    if (!this.datos.nombre || !this.datos.correo) {
      alert('Por favor completa tus datos');
      return;
    }

    // 3. Preparar el objeto para el Backend
    const orden = {
      nombre: this.datos.nombre,
      correo: this.datos.correo,
      total: this.tiendaService.getTotal(),
      // Transformamos el carrito al formato que pide la base de datos
      detalles: this.tiendaService.cartItems.map(item => ({
        producto_id: item.id,
        cantidad: item.cantidad,
        precio_unitario: item.precio
      }))
    };

    // 4. Enviar a MySQL
    this.tiendaService.crearOrden(orden).subscribe({
      next: (res) => {
        alert('¡Compra Exitosa! Tu pedido ha sido registrado.');
        this.tiendaService.clearCart(); // Limpiamos el carrito
        this.router.navigate(['/']);    // Volvemos al inicio
      },
      error: (err) => {
        console.error(err);
        alert('Error al procesar la compra.');
      }
    });
  }
}