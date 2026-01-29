import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomProfileScreen extends StatelessWidget {
  const CustomProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Obtener datos del usuario real de Firebase
    final user = FirebaseAuth.instance.currentUser;
    final String userName = user?.displayName ?? "Juan Andres"; // Nombre por defecto si no tiene
    final String? photoUrl = user?.photoURL;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Fondo Negro estilo "Dark Mode"
      
      // --- BARRA SUPERIOR (APPBAR) ---
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparente para que se vea el fondo negro
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          onPressed: () {}, // Botón de menú (decorativo)
        ),
        actions: [
          // Botón de Salir (Power)
          IconButton(
            icon: const Icon(Icons.power_settings_new, color: Colors.white, size: 30),
            onPressed: () async {
              // Lógica para cerrar sesión
              await FirebaseAuth.instance.signOut();
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 10),
        ],
      ),

      // --- CUERPO DE LA PANTALLA ---
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // 1. FOTO DE PERFIL CON LAPIZ
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[800],
                  // Si tiene foto la muestra, si no pone un icono
                  backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                  child: photoUrl == null 
                      ? const Icon(Icons.person, size: 70, color: Colors.white) 
                      : null,
                ),
                // El pequeño lápiz blanco
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white, // Fondo blanco del lápiz
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, size: 18, color: Colors.black),
                )
              ],
            ),
            
            const SizedBox(height: 15),

            // 2. NOMBRE DE USUARIO
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.edit, color: Colors.white, size: 20),
              ],
            ),

            const SizedBox(height: 20),

            // 3. BARRA DE PROGRESO (GRIS)
            Container(
              height: 12,
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(10),
              ),
              // Aquí podrías poner un hijo Container para simular el progreso
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 200, // Progreso simulado
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // 4. SECCIÓN PUNTOS (AMARILLO)
            const Text(
              "Puntos de fidelidad",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107), // Color Amber exacto
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 35),
                  SizedBox(width: 10),
                  Text(
                    "1,250 Pts",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "escanea tu guitarra para ganar más",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),

            const SizedBox(height: 40),

            // 5. BOTONES DE ACCIÓN
            
            // Botón QR (Gris oscuro)
            SizedBox(
              width: 280,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF252525), // Gris oscuro casi negro
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abriendo cámara... 📷'))
                   );
                },
                child: const Text("escanear QR ( 50 Pts )", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),

            const SizedBox(height: 20),

            // Botón Sign Out (Blanco)
            SizedBox(
              width: 280,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: const Text("sign out", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),

            const SizedBox(height: 20),

            // Botón Delete Account (Rojo)
            SizedBox(
              width: 280,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935), // Rojo
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Acción protegida por seguridad'))
                   );
                },
                child: const Text("Delete account", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // --- BARRA INFERIOR (Bottom Navigation Bar) ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121212),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed, // Para que no se muevan los iconos
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 35), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money, size: 35), label: 'Shop'), // Icono de dólar
        ],
        onTap: (index) {
          if (index == 0) Navigator.pop(context); // Vuelve al Home
        },
      ),
    );
  }
}