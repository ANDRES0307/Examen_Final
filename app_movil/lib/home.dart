import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_custom.dart';
import 'detalle_producto.dart';
import 'carrito_screen.dart';
import 'rewards_screen.dart'; // <--- IMPORTAMOS LA TIENDA
import 'puntos_service.dart'; // <--- IMPORTAMOS EL BANCO DE PUNTOS

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String categoriaSeleccionada = 'Guitarras';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final String userName = user?.displayName ?? "Juan Andres";
    final String? photoUrl = user?.photoURL;

    final Map<String, List<Map<String, dynamic>>> catalogos = {
      'Guitarras': [
        {'nombre': 'Gibson Les Paul 50s', 'precio': '\$2,799', 'imagen': 'assets/g_lespaul.jpg'},
        {'nombre': 'Gibson SG Standard', 'precio': '\$1,999', 'imagen': 'assets/g_sg.jpg'},
        {'nombre': 'Gibson ES-335', 'precio': '\$3,499', 'imagen': 'assets/g_es335.jpg'},
      ],
      'Bajos': [
        {'nombre': 'SG Standard Bass', 'precio': '\$1,699', 'imagen': 'assets/b_sg.jpg'},
        {'nombre': 'Thunderbird 60s', 'precio': '\$2,199', 'imagen': 'assets/b_thunder.jpg'},
        {'nombre': 'LP Junior DC Bass', 'precio': '\$1,099', 'imagen': 'assets/b_junior.jpg'},
      ],
      'Baterías': [
        {'nombre': 'Ludwig Breakbeats', 'precio': '\$599', 'imagen': 'assets/d_breakbeats.jpg'},
        {'nombre': 'Ludwig Classic Maple', 'precio': '\$3,200', 'imagen': 'assets/d_classic.jpg'},
        {'nombre': 'Ludwig Vistalite', 'precio': '\$4,500', 'imagen': 'assets/d_vistalite.jpg'},
      ],
      'Aire': [
        {'nombre': 'Bach Stradivarius', 'precio': '\$3,100', 'imagen': 'assets/a_trompeta.jpg'},
        {'nombre': 'Conn 8D French Horn', 'precio': '\$4,800', 'imagen': 'assets/a_corno.jpg'},
        {'nombre': 'Selmer Paris Ser II', 'precio': '\$6,200', 'imagen': 'assets/a_saxo.jpg'},
      ],
    };

    final List<Map<String, dynamic>> botonesCategorias = [
      {'icon': Icons.music_note, 'label': 'Guitarras'},
      {'icon': Icons.audiotrack, 'label': 'Bajos'},
      {'icon': Icons.grid_view, 'label': 'Baterías'},
      {'icon': Icons.air, 'label': 'Aire'},
    ];

    final List<Map<String, dynamic>> productosActuales = catalogos[categoriaSeleccionada] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CABECERA
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(icon: const Icon(Icons.search, color: Colors.white, size: 28), onPressed: () {}),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CustomProfileScreen())),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                          child: photoUrl == null ? const Icon(Icons.person, color: Colors.black) : null,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                            const Icon(Icons.arrow_drop_down, color: Colors.white, size: 20)
                          ],
                        )
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.notifications, color: Colors.white, size: 28),
                      Positioned(right: 2, top: 2, child: Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(color: Color(0xFFFFC107), shape: BoxShape.circle))),
                    ],
                  )
                ],
              ),

              const SizedBox(height: 25),

              // BANNER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("The Original SG For A New Generation", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                          const SizedBox(height: 5),
                          const Text("SG Standard '61\n2019", style: TextStyle(color: Color(0xFFFFC107), fontSize: 24, fontWeight: FontWeight.bold, height: 1.1)),
                          const SizedBox(height: 10),
                          Text("En 1961 el modelo Les Paul Standard recibió un cambio radical...", style: TextStyle(color: Colors.grey[600], fontSize: 10)),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Image.asset('assets/g_sg.jpg', height: 120, fit: BoxFit.contain, errorBuilder: (c, o, s) => const Icon(Icons.music_note, size: 80, color: Colors.grey)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // CATEGORÍAS
              const Text("Categorias", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: botonesCategorias.map((cat) {
                  final bool isSelected = categoriaSeleccionada == cat['label'];
                  return GestureDetector(
                    onTap: () => setState(() => categoriaSeleccionada = cat['label']),
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 70, height: 70,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFFC107) : const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: isSelected ? [BoxShadow(color: Colors.amber.withOpacity(0.4), blurRadius: 10)] : [],
                          ),
                          child: Icon(cat['icon'], color: isSelected ? Colors.black : Colors.white, size: 30),
                        ),
                        const SizedBox(height: 8),
                        Text(cat['label'], style: TextStyle(color: isSelected ? const Color(0xFFFFC107) : Colors.grey, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              // GRILLA DE PRODUCTOS
              Text("Top 3 - $categoriaSeleccionada", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 0.80,
                ),
                itemCount: productosActuales.length,
                itemBuilder: (context, index) {
                  final prod = productosActuales[index];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetalleProductoScreen(producto: prod))),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Hero(
                                tag: prod['nombre'],
                                child: Image.asset(prod['imagen'], fit: BoxFit.contain, errorBuilder: (c, o, s) => const Icon(Icons.image_not_supported, size: 50, color: Colors.grey)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(prod['nombre'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(prod['precio'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.green)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // --- BARRA INFERIOR ---
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0F0F0F),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            // IR AL CARRITO
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CarritoScreen()));
          } else if (index == 2) {
            // IR A LA TIENDA DE PUNTOS (Usando el Servicio Global)
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => RewardsScreen(puntosActuales: PuntosService().puntos)
            )).then((value) {
               // Al volver, refrescamos la pantalla por si gastó puntos
               setState(() {});
            });
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 30), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 30), label: 'Cart'),
          // BOTÓN DE SHOP (SÍMBOLO DE DÓLAR)
          BottomNavigationBarItem(icon: Icon(Icons.monetization_on, size: 30), label: 'Shop'), 
        ],
      ),
    );
  }
}