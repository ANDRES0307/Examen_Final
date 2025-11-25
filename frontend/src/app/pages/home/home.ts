import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink], // Importamos esto para que el botón funcione
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class HomeComponent {}