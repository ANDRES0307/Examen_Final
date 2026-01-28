import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // DATOS: Lista de guitarras (Igual que en la web)
    final List<Map<String, dynamic>> guitarras = [
      {
        'nombre': 'Gibson Les Paul Standard',
        'precio': '\$2,500',
        'imagen': 'assets/guitar_gibson.png', // Asegúrate de que el nombre coincida con tu archivo
        'descripcion': 'La leyenda del rock. Tono cálido.'
      },
      {
        'nombre': 'Fender Stratocaster',
        'precio': '\$1,800',
        'imagen': 'assets/guitarras.jpg',
        'descripcion': 'Sonido brillante y versátil.'
      },
      {
        'nombre': 'Yamaha Pacifica',
        'precio': '\$400',
        'imagen': 'assets/logo-gibson.png',
        'descripcion': 'Calidad-precio insuperable.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Guitar Shop VIP 🎸'),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: [
          // Botón de Perfil (Club VIP)
          IconButton(
            icon: const Icon(Icons.person, color: Colors.amber),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(title: const Text('Mi Club VIP')),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      // --- SECCIÓN DE PUNTOS (Valor Agregado) ---
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Mis Puntos de Fidelidad',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(color: Colors.black26, blurRadius: 5)
                                ]
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, size: 40, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    '1,250 Pts',
                                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("¡Escanea tu guitarra para ganar más!"),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.qr_code_scanner),
                              label: const Text('Escanear QR (+50 Pts)'),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Abriendo cámara... (Próximamente)'))
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: guitarras.length,
        itemBuilder: (context, index) {
          final guitar = guitarras[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.only(bottom: 25),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                // Imagen de la guitarra
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                    child: Image.asset(
                      guitar['imagen'],
                      fit: BoxFit.contain, // contain para que se vea la guitarra completa
                      errorBuilder: (c, o, s) => const Center(
                        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey)
                      ),
                    ),
                  ),
                ),
                // Información
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            guitar['nombre'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            guitar['precio'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(guitar['descripcion'], style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                             ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('¡Añadido a favoritos! ❤'))
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, 
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          child: const Text('Ver Detalles'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}