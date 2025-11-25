import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { navbar } from './components/navbar/navbar';
// 1. IMPORTAMOS EL FOOTER
import { Footer} from './components/footer/footer';

@Component({
  selector: 'app-root',
  standalone: true,
  // 2. LO AGREGAMOS A LA LISTA DE IMPORTS
  imports: [RouterOutlet, navbar, Footer], 
  templateUrl: './app.html', // (O app.component.html si no lo cambiaste)
  styleUrl: './app.css'      // (O app.component.css)
})
export class App {
  title = 'frontend';
}