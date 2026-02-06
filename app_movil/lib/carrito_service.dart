class CarritoService {
  static final CarritoService _instance = CarritoService._internal();
  factory CarritoService() => _instance;
  CarritoService._internal();

  final List<Map<String, dynamic>> items = [];

  void agregar(Map<String, dynamic> producto) => items.add(producto);
  
  void remover(Map<String, dynamic> producto) => items.remove(producto);
  
  void limpiar() => items.clear(); // <--- IMPORTANTE

  double obtenerTotal() {
    double total = 0;
    for (var item in items) {
      String precioLimpio = item['precio'].toString().replaceAll(RegExp(r'[^\d.]'), '');
      if (precioLimpio.isNotEmpty) total += double.parse(precioLimpio);
    }
    return total;
  }
}