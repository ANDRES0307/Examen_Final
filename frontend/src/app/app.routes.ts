import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home';
import { GaleriaComponent} from './pages/galeria/galeria';
import { DetalleProducto } from './pages/detalle-producto/detalle-producto';
import { Carrito} from './pages/carrito/carrito';
import { Checkout } from './pages/checkout/checkout';

export const routes: Routes = [
    { path: '', component: HomeComponent },
    { path: 'galeria', component: GaleriaComponent },
    { path: 'producto/:id', component: DetalleProducto },
    { path: 'carrito', component: Carrito },
    { path: 'checkout', component: Checkout },
    { path: '**', redirectTo: '' }
];