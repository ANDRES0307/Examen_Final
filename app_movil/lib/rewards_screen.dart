import 'package:flutter/material.dart';

class RewardsScreen extends StatefulWidget {
  final int puntosActuales;

  const RewardsScreen({super.key, required this.puntosActuales});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  late int misPuntos;

  @override
  void initState() {
    super.initState();
    misPuntos = widget.puntosActuales;
  }

  // --- CATÁLOGO DE RECOMPENSAS ---
  final List<Map<String, dynamic>> recompensas = [
    {'nombre': 'Pack de Uñas Gibson', 'costo': 200, 'icon': Icons.music_note},
    {'nombre': 'Cuerdas Premium', 'costo': 500, 'icon': Icons.graphic_eq},
    {'nombre': 'Correa de Cuero', 'costo': 1000, 'icon': Icons.line_weight},
    {'nombre': 'Cable Profesional', 'costo': 800, 'icon': Icons.cable},
    {'nombre': 'Kit de Limpieza', 'costo': 450, 'icon': Icons.cleaning_services},
    {'nombre': 'Gorra Oficial', 'costo': 1200, 'icon': Icons.shopping_bag},
  ];

  void _canjearProducto(Map<String, dynamic> item) {
    if (misPuntos >= item['costo']) {
      // SI ALCANZAN LOS PUNTOS
      setState(() {
        misPuntos -= (item['costo'] as int);
      });

      // Diálogo de éxito
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Icon(Icons.check_circle, color: Colors.green, size: 50),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("¡Canje Exitoso!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Text("Has canjeado: ${item['nombre']}", style: TextStyle(color: Colors.grey), textAlign: TextAlign.center),
              Text("Te quedan $misPuntos pts", style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("GENIAL", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      );
    } else {
      // NO ALCANZAN
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Te faltan ${item['costo'] - misPuntos} puntos para este item"),
          backgroundColor: Colors.red,
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Interceptamos el botón "Atrás" para devolver los puntos actualizados al perfil
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.pop(context, misPuntos); // <--- AQUÍ DEVOLVEMOS LOS PUNTOS
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          title: const Text("Canjear Puntos", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // --- CABECERA DE PUNTOS ---
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFFC107), Color(0xFFFF8F00)]),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.3), blurRadius: 15)],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("DISPONIBLE", style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      Text("Rewards", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22)),
                    ],
                  ),
                  Text("$misPuntos", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 35)),
                ],
              ),
            ),

            // --- GRILLA DE PRODUCTOS ---
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.8,
                ),
                itemCount: recompensas.length,
                itemBuilder: (context, index) {
                  final item = recompensas[index];
                  final bool alcanza = misPuntos >= item['costo'];

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: alcanza ? Colors.grey[800]! : Colors.red.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icono
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFF121212),
                          child: Icon(item['icon'], color: Colors.white, size: 30),
                        ),
                        const SizedBox(height: 15),
                        // Nombre
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(item['nombre'], textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 5),
                        // Costo
                        Text("${item['costo']} Pts", style: const TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold)),
                        
                        const SizedBox(height: 15),
                        
                        // Botón Canjear
                        SizedBox(
                          height: 35,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: alcanza ? Colors.white : Colors.grey[900],
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () => _canjearProducto(item),
                            child: Text(alcanza ? "CANJEAR" : "FALTA", style: TextStyle(color: alcanza ? Colors.black : Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}