import 'package:flutter/material.dart';
import 'carrito_service.dart';

// --- PANTALLA 1: RESUMEN CON DATOS REALES ---
class OrdenScreen extends StatelessWidget {
  const OrdenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final carrito = CarritoService();
    final total = carrito.obtenerTotal();
    final envio = 50.00;
    final totalFinal = total + envio;

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: const Text("Resumen de Orden", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent, 
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: Center(
        child: Container(
          width: 340,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Text("ORDEN #12873", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: 1.2))),
              const Divider(thickness: 2, height: 30),
              
              // SECCIÓN 1: ENVÍO
              _buildSectionTitle("DIRECCIÓN DE ENVÍO"),
              const Text("Juan Andrés", style: TextStyle(fontWeight: FontWeight.bold)),
              const Text("Av. Amazonas y Naciones Unidas", style: TextStyle(color: Colors.grey)),
              const Text("Quito, Ecuador", style: TextStyle(color: Colors.grey)),
              
              const SizedBox(height: 20),

              // SECCIÓN 2: PAGO
              _buildSectionTitle("MÉTODO DE PAGO"),
              const Row(
                children: [
                  Icon(Icons.credit_card, size: 20, color: Colors.grey),
                  SizedBox(width: 10),
                  Text("Visa terminada en 4242", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),

              const SizedBox(height: 20),

              // SECCIÓN 3: RESUMEN DE COSTOS
              _buildSectionTitle("RESUMEN"),
              _buildRow("Subtotal", "\$${total.toStringAsFixed(2)}"),
              _buildRow("Envío Express", "\$${envio.toStringAsFixed(2)}"),
              const Divider(height: 20),
              _buildRow("TOTAL A PAGAR", "\$${totalFinal.toStringAsFixed(2)}", isBold: true),
              
              const SizedBox(height: 30),

              // BOTÓN COMPRAR FINAL
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ExitoScreen()));
                  },
                  child: const Text("CONFIRMAR COMPRA", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 16 : 14)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.w900 : FontWeight.normal, fontSize: isBold ? 18 : 14)),
        ],
      ),
    );
  }
}

// --- PANTALLA 2: ÉXITO (FELICIDADES) ---
class ExitoScreen extends StatelessWidget {
  const ExitoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Center(
        child: Container(
          width: 320,
          height: 500,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text("¡FELICIDADES!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              const Text(
                "Tu pago ha sido procesado exitosamente.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 30),
              
              const Text("Te hemos enviado un correo con el número de seguimiento.", textAlign: TextAlign.center, style: TextStyle(fontSize: 14)),
              
              const Spacer(),

              // BOTÓN VOLVER
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    // LIMPIAR CARRITO Y VOLVER
                    CarritoService().limpiar();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: const Text("VOLVER AL INICIO", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}