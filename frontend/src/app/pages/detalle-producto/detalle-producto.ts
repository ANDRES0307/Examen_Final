import { Component, OnInit, ElementRef, ViewChild, inject, Input, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { TiendaService, Producto } from '../../services/tienda.service';
import * as THREE from 'three';

@Component({
  selector: 'app-detalle-producto',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './detalle-producto.html',
  styleUrl: './detalle-producto.css'
})
export class DetalleProductoComponent implements OnInit {
  
  @Input() id!: string; 

  private tiendaService = inject(TiendaService);
  private cd = inject(ChangeDetectorRef); // 1. Inyectamos el detector
  
  producto: Producto | null = null;

  // 2. Cambiamos static a false porque el canvas está dentro de un *ngIf
  @ViewChild('canvas3d', { static: false }) canvasRef!: ElementRef;
  
  private scene!: THREE.Scene;
  private camera!: THREE.PerspectiveCamera;
  private renderer!: THREE.WebGLRenderer;
  private mesh!: THREE.Mesh;

  ngOnInit(): void {
    if (this.id) {
      this.tiendaService.getProductoById(+this.id).subscribe({
        next: (data) => {
          this.producto = data;
          
          // 3. ¡TRUCO MÁGICO! 
          // Obligamos a Angular a pintar el HTML antes de buscar el canvas
          this.cd.detectChanges(); 
          
          this.initThreeJS();
        },
        error: (err) => console.error(err)
      });
    }
  }

  initThreeJS() {
    // Seguridad extra: Si el canvas no existe, no hacemos nada
    if (!this.canvasRef) return;

    const width = 400;
    const height = 300;

    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0x212529);

    this.camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000);
    this.camera.position.z = 2;

    this.renderer = new THREE.WebGLRenderer({ canvas: this.canvasRef.nativeElement, alpha: true });
    this.renderer.setSize(width, height);

    const geometry = new THREE.BoxGeometry();
    const material = new THREE.MeshBasicMaterial({ color: 0xffc107, wireframe: true });
    this.mesh = new THREE.Mesh(geometry, material);
    this.scene.add(this.mesh);

    this.animate();
  }

  animate() {
    requestAnimationFrame(() => this.animate());
    
    if (this.mesh) {
      this.mesh.rotation.x += 0.01;
      this.mesh.rotation.y += 0.01;
    }
    
    this.renderer.render(this.scene, this.camera);
  }

  agregar() {
    if (this.producto) {
      this.tiendaService.addToCart(this.producto);
    }
  }
}