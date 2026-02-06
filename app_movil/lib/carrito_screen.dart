import 'package:flutter/material.dart';
import 'carrito_service.dart';
import 'orden_screen.dart'; // Asegúrate de tener este import para el botón "COMPRAR"

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    final carrito = CarritoService();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F), // Fondo Negro
      appBar: AppBar(
        title: const Text("Mi Carrito", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- LISTA DE PRODUCTOS ---
          Expanded(
            child: carrito.items.isEmpty
              ? _buildCarritoVacio()
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: carrito.items.length,
                  itemBuilder: (context, index) {
                    final item = carrito.items[index];
                    return _buildCartItem(item, carrito);
                  },
                ),
          ),
          
          // --- TOTAL Y BOTÓN COMPRAR ---
          if (carrito.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A), // Panel inferior gris oscuro
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total Estimado:", style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Text("\$${carrito.obtenerTotal().toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFC107), // Amarillo
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        // Navegar al resumen de orden
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdenScreen()));
                      },
                      child: const Text("PROCEDER AL PAGO", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  // Diseño de cada item del carrito
  Widget _buildCartItem(Map<String, dynamic> item, CarritoService carrito) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Tarjeta gris oscura
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[900]!),
      ),
      child: Row(
        children: [
          // 1. FOTO EN CAJA BLANCA (Para ocultar el fondo JPG)
          Container(
            width: 90, height: 90,
            decoration: BoxDecoration(
              color: Colors.white, // Fondo blanco limpio
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(item['imagen'], fit: BoxFit.contain),
          ),
          
          const SizedBox(width: 15),

          // 2. INFORMACIÓN DETALLADA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nombre
                Text(item['nombre'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis),
                
                const SizedBox(height: 5),
                
                // Detalles "Fake" (Información extra)
                const Text("Color: Original • Garantía: 2 Años", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Text("Envío: 2-3 días hábiles", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),

                const SizedBox(height: 8),

                // Precio
                Text(item['precio'], style: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ),

          // 3. BOTÓN ELIMINAR
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: () {
              setState(() {
                carrito.remover(item);
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildCarritoVacio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
        const SizedBox(height: 20),
        const Text("Tu carrito está vacío", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text("¡Explora nuestro catálogo y encuentra\ntu instrumento ideal!", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}