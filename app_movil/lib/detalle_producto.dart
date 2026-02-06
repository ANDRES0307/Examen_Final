import 'package:flutter/material.dart';
import 'carrito_service.dart';

class DetalleProductoScreen extends StatelessWidget {
  final Map<String, dynamic> producto;

  const DetalleProductoScreen({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Fondo Negro General
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text("Juan Andres", style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          // 1. TARJETA DE LA IMAGEN (AHORA ES BLANCA PARA OCULTAR EL FONDO JPG)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            bottom: 200, 
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white, // <--- CAMBIO CLAVE: Fondo blanco
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40), // Margen interno para que la guitarra no toque los bordes
                child: Hero(
                  tag: producto['nombre'],
                  child: Image.asset(producto['imagen'], fit: BoxFit.contain),
                ),
              ),
            ),
          ),

          // 2. PRECIO FLOTANTE (Ahora en negro para que se vea sobre el blanco)
          Positioned(
            top: 100,
            right: 40,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                producto['precio'],
                style: TextStyle(color: Colors.grey[400], fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
            ),
          ),

          // 3. TARJETA DE INFORMACIÓN (ABAJO)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 220,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A), // <--- INVERTIDO: Ahora la info es oscura
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey[800]!), // Borde sutil
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          producto['nombre'],
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFFC107)),
                        ),
                        child: Text(producto['precio'].replaceAll('\$', ''), style: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  Text(
                    "El icono del rock en perfecto estado. Acabado Heritage Cherry, tacto inmejorable y sonido potente. Ajustada profesionalmente. Incluye estuche rígido.",
                    style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.4),
                    maxLines: 4, overflow: TextOverflow.ellipsis,
                  ),

                  const Spacer(),

                  // Botón BUY
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        CarritoService().agregar(producto);
                        ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("${producto['nombre']} agregado!"), backgroundColor: Colors.green)
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("AGREGAR AL CARRITO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}