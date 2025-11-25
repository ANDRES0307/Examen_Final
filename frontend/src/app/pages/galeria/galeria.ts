import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common'; 
import { RouterLink } from '@angular/router'; 
// CORRECCIÓN 1: Apuntamos al archivo .service y usamos el nombre correcto TiendaService
import { TiendaService, Producto } from '../../services/tienda.service'; 

@Component({
  selector: 'app-galeria',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './galeria.html',
  styleUrl: './galeria.css'
})
export class GaleriaComponent implements OnInit {
  // Inyectamos el servicio
  private tiendaService = inject(TiendaService); // Usamos TiendaService
  productos: Producto[] = [];

  ngOnInit(): void {
    // CORRECCIÓN 2: Usamos la variable correcta 'this.tiendaService'
    this.tiendaService.getProductos().subscribe({
      next: (data) => {
        this.productos = data;
        console.log('Productos cargados:', data);
      },
      error: (err) => console.error('Error al cargar:', err)
    });
  }
}