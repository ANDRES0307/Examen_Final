import { Component, OnInit, ElementRef, ViewChild, inject, Input, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { TiendaService, Producto } from '../../services/tienda.service';
import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';
// 1. IMPORTAR CONTROLES
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';

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
  private cd = inject(ChangeDetectorRef);
  
  producto: Producto | null = null;

  @ViewChild('canvas3d', { static: false }) canvasRef!: ElementRef;
  
  private scene!: THREE.Scene;
  private camera!: THREE.PerspectiveCamera;
  private renderer!: THREE.WebGLRenderer;
  private modeloGuitarra: THREE.Group | null = null;
  
  // 2. VARIABLE PARA LOS CONTROLES
  private controls!: OrbitControls;

  ngOnInit(): void {
    if (this.id) {
      this.tiendaService.getProductoById(+this.id).subscribe({
        next: (data) => {
          this.producto = data;
          this.cd.detectChanges();
          this.initThreeJS();
        },
        error: (err) => console.error(err)
      });
    }
  }

  initThreeJS() {
    if (!this.canvasRef) return;

    const width = 400;
    const height = 300;

    this.scene = new THREE.Scene();
    this.scene.background = new THREE.Color(0x121212);

    this.camera = new THREE.PerspectiveCamera(45, width / height, 0.1, 1000);
    this.camera.position.z = 10; 

    this.renderer = new THREE.WebGLRenderer({ canvas: this.canvasRef.nativeElement, alpha: true, antialias: true });
    this.renderer.setSize(width, height);
    this.renderer.shadowMap.enabled = true;

    // --- 3. CONFIGURAR ORBIT CONTROLS ---
    this.controls = new OrbitControls(this.camera, this.renderer.domElement);
    this.controls.enableDamping = true; // Hace que el movimiento sea suave (inercia)
    this.controls.dampingFactor = 0.05;
    this.controls.enableZoom = true;    // Permite hacer zoom con la rueda del mouse
    this.controls.autoRotate = false;   // Lo apagamos para que tú tengas el control total

    // Luces
    const ambientLight = new THREE.AmbientLight(0xffffff, 1);
    this.scene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight(0xffd700, 3);
    directionalLight.position.set(5, 5, 5);
    this.scene.add(directionalLight);

    // Cargar Modelo
    const loader = new GLTFLoader();

    loader.load(
      '/guitar_gibson_les_paul_standard.glb',
      (gltf) => {
        this.modeloGuitarra = gltf.scene;
        this.modeloGuitarra.scale.set(0.5, 0.5, 0.5); 
        this.modeloGuitarra.position.y = -1.5; 
        this.modeloGuitarra.rotation.x = 0;
        this.scene.add(this.modeloGuitarra);
      },
      undefined,
      (error) => console.error(error)
    );

    this.animate();
  }

  animate() {
    requestAnimationFrame(() => this.animate());
    
    // Actualizar controles para el efecto de suavidad
    if (this.controls) {
      this.controls.update();
    }
    
    this.renderer.render(this.scene, this.camera);
  }

  agregar() {
    if (this.producto) {
      this.tiendaService.addToCart(this.producto);
    }
  }
}