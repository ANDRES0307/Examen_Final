import { Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home';
import { GaleriaComponent} from './pages/galeria/galeria';
import { DetalleProductoComponent } from './pages/detalle-producto/detalle-producto';
import { CarritoComponent } from './pages/carrito/carrito';
import { CheckoutComponent } from './pages/checkout/checkout';

export const routes: Routes = [
    { path: '', component: HomeComponent },
    { path: 'galeria', component: GaleriaComponent },
    { path: 'producto/:id', component: DetalleProductoComponent },
    { path: 'carrito', component: CarritoComponent },
    { path: 'checkout', component: CheckoutComponent },
    { path: '**', redirectTo: '' }
];