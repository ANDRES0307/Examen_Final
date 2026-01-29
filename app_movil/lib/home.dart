import 'package:firebase_auth/firebase_auth.dart'; // Para obtener el nombre y foto real
import 'package:flutter/material.dart';
import 'profile_custom.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Obtener datos del usuario para la cabecera
    final user = FirebaseAuth.instance.currentUser;
    final String userName = user?.displayName ?? "Juan Andres";
    final String? photoUrl = user?.photoURL;

    // 2. DATOS DE GUITARRAS
    final List<Map<String, dynamic>> guitarras = [
      {
        'nombre': 'Gibson Les Paul',
        'imagen': 'assets/guitar_gibson.png', 
      },
      {
        'nombre': 'Fender Stratocaster',
        'imagen': 'assets/guitarras.jpg',
      },
      {
        'nombre': 'Yamaha Pacifica',
        'imagen': 'assets/logo-gibson.png',
      },
      // Repetimos para llenar la grilla y que se vea bien
      {
        'nombre': 'Ibanez RG',
        'imagen': 'assets/guitar_gibson.png',
      },
       {
        'nombre': 'Fender Telecaster',
        'imagen': 'assets/guitarras.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fondo Negro
      
      // Usamos SafeArea para que no se choque con la barra de notificaciones del celular
      body: SafeArea(
        child: Column(
          children: [
            
            // --- CABECERA PERSONALIZADA ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Icono de Lupa a la izquierda
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white, size: 28),
                      onPressed: () {},
                    ),
                  ),

                  // Perfil al centro (Clickable)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CustomProfileScreen()),
                      );
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                          child: photoUrl == null 
                              ? const Icon(Icons.person, color: Colors.black) 
                              : null,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userName, 
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                            ),
                            const Icon(Icons.arrow_drop_down, color: Colors.white)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // --- TÍTULO ---
            const Text(
              "GUITARRAS ELECTRICAS",
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2
              ),
            ),

            const SizedBox(height: 20),

            // --- GRILLA DE PRODUCTOS (GRID) ---
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 Columnas
                  crossAxisSpacing: 15, // Espacio horizontal entre tarjetas
                  mainAxisSpacing: 15, // Espacio vertical entre tarjetas
                  childAspectRatio: 1.0, // Cuadradas (1.0)
                ),
                itemCount: guitarras.length,
                itemBuilder: (context, index) {
                  final guitar = guitarras[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Imagen
                          Expanded(
                            child: Image.asset(
                              guitar['imagen'],
                              fit: BoxFit.contain,
                              errorBuilder: (c, o, s) => const Icon(Icons.music_note, size: 50, color: Colors.grey),
                            ),
                          ),
                          // Nombre pequeño abajo (opcional, para que sepa qué es)
                          // Si quieres que sea SOLO blanco como la foto, borra este Text
                          /*
                          const SizedBox(height: 5),
                          Text(
                            guitar['nombre'],
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          */
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // --- BARRA INFERIOR ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 30), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 30), label: 'Shop'),
        ],
      ),
    );
  }
}