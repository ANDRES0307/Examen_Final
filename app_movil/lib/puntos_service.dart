class PuntosService {
  // Singleton: Para que sea el mismo "Banco" en toda la app
  static final PuntosService _instance = PuntosService._internal();
  factory PuntosService() => _instance;
  PuntosService._internal();

  // TUS PUNTOS GLOBALES
  int puntos = 1250; 
}