import { ApplicationConfig } from '@angular/core';
import { provideRouter, withComponentInputBinding } from '@angular/router';
import { routes } from './app.routes';
import { provideHttpClient, withFetch } from '@angular/common/http';

export const appConfig: ApplicationConfig = {
  providers: [
    // Activamos el Router y permitimos recibir el ID del producto (withComponentInputBinding)
    provideRouter(routes, withComponentInputBinding()),
    
    // Activamos la conexión a internet (API)
    provideHttpClient(withFetch())
  ]
};