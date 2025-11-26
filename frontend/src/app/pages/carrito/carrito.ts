import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { TiendaService } from '../../services/tienda.service';

@Component({
  selector: 'app-carrito',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './carrito.html',
  styleUrl: './carrito.css'
})
export class CarritoComponent {
  // Hacemos público el servicio para usar sus variables en el HTML
  public tiendaService = inject(TiendaService);

  // Función para eliminar un producto de la lista
  eliminar(id: number) {
    this.tiendaService.removeFromCart(id);
  }
}