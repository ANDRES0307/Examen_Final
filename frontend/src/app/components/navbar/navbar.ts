import { Component } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive],
  // CORRECCIÓN: Apuntamos a los nombres cortos que tienes en tu carpeta
  templateUrl: './navbar.html',
  styleUrl: './navbar.css',
})
export class navbar {}