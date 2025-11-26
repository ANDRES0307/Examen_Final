import { Component, OnInit, inject, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { TiendaService, Producto } from '../../services/tienda.service';

@Component({
  selector: 'app-galeria',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './galeria.html',
  styleUrl: './galeria.css'
})
export class GaleriaComponent implements OnInit {
  
  private tiendaService = inject(TiendaService);
  private cd = inject(ChangeDetectorRef);
  
  productos: Producto[] = [];

  ngOnInit(): void {
    this.tiendaService.getProductos().subscribe({
      next: (data) => {
        this.productos = data;
        this.cd.detectChanges(); 
      },
      error: (err) => console.error('Error al cargar:', err)
    });
  }

  // --- ESTA ES LA FUNCIÓN QUE FALTABA ---
  agregar(item: Producto) {
    this.tiendaService.addToCart(item);
  }
}