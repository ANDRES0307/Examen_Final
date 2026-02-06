import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'scanner_screen.dart';
import 'rewards_screen.dart';
import 'puntos_service.dart'; // <--- CONECTAMOS AL BANCO

class CustomProfileScreen extends StatefulWidget {
  const CustomProfileScreen({super.key});

  @override
  State<CustomProfileScreen> createState() => _CustomProfileScreenState();
}

class _CustomProfileScreenState extends State<CustomProfileScreen> {
  // YA NO USAMOS VARIABLE LOCAL. LEEMOS DEL SERVICIO.
  
  void _abrirEscanerReal() async {
    final resultado = await Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerScreen()));

    if (resultado is String && resultado == "GIBSON-VIP") {
      setState(() {
        PuntosService().puntos += 50; // Sumamos al Banco Global
      });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("✅ +50 Puntos añadidos"), backgroundColor: Colors.green));
    } else if (resultado is String) {
       if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("❌ Código inválido"), backgroundColor: Colors.red));
    }
  }

  void _irATiendaCanje() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => RewardsScreen(puntosActuales: PuntosService().puntos)));
    // Al volver, refrescamos para ver el nuevo saldo
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // ... resto del diseño igual ...
    // (Solo mostraré la parte que cambia para no llenar todo, pero asegúrate de usar PuntosService().puntos)
    
    // DONDE MUESTRAS LOS PUNTOS:
    // Text("${PuntosService().puntos} Pts", ...)

    // Aquí te dejo el archivo completo para evitar errores:
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              // FOTO
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(radius: 50, backgroundColor: Colors.white, child: CircleAvatar(radius: 48, backgroundColor: Colors.grey[900], backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null, child: user?.photoURL == null ? const Icon(Icons.person, size: 50, color: Colors.white) : null)),
                  const CircleAvatar(radius: 15, backgroundColor: Color(0xFF121212), child: Icon(Icons.edit, color: Colors.white, size: 14))
                ],
              ),
              const SizedBox(height: 15),
              // NOMBRE
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text(user?.displayName ?? "Juan Andres", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)), const SizedBox(width: 8), const Icon(Icons.edit, color: Colors.white, size: 18)]),
              const SizedBox(height: 20),
              Container(height: 20, width: 300, decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 30),
              
              // TARJETA DE PUNTOS (CONECTADA AL SERVICIO)
              const Text("Puntos de fidelidad", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Container(
                width: 220, padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: const Color(0xFFFFC107), borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.amber.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: Colors.white, size: 28),
                    const SizedBox(width: 10),
                    // AQUÍ ESTÁ LA CLAVE:
                    Text("${PuntosService().puntos} Pts", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              const Text("Gana puntos o canjea recompensas", style: TextStyle(color: Colors.white, fontSize: 14)),
              const SizedBox(height: 20),
              
              SizedBox(width: 260, height: 50, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2C2C2C), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), onPressed: _abrirEscanerReal, child: const Text("escanear QR ( +50 Pts )", style: TextStyle(color: Colors.white, fontSize: 16)))),
              const SizedBox(height: 15),
              
              // BOTÓN TIENDA
              SizedBox(width: 260, height: 50, child: OutlinedButton.icon(style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFFFC107), width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFFFFC107)), label: const Text("CANJEAR RECOMPENSAS", style: TextStyle(color: Color(0xFFFFC107), fontWeight: FontWeight.bold, fontSize: 15)), onPressed: _irATiendaCanje)),
              
              const SizedBox(height: 50),
              SizedBox(width: 200, height: 40, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), onPressed: () async { await FirebaseAuth.instance.signOut(); if (context.mounted) Navigator.of(context).pop(); }, child: const Text("sign out", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)))),
              const SizedBox(height: 15),
              SizedBox(width: 200, height: 40, child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF3B30), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))), onPressed: () {}, child: const Text("Delete account", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF121212), selectedItemColor: Colors.white, unselectedItemColor: Colors.grey,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''), BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 30), label: ''), BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 30), label: '')],
      ),
    );
  }
}