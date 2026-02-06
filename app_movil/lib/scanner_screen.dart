import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController controller = MobileScannerController();
  bool _codigoDetectado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Escanea el QR"),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch),
            onPressed: () => controller.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: controller,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          
          if (barcodes.isNotEmpty && !_codigoDetectado) {
            setState(() {
              _codigoDetectado = true;
            });
            
            // OBTENEMOS EL TEXTO DEL CÓDIGO
            final String code = barcodes.first.rawValue ?? "---";
            debugPrint('Código escaneado: $code');
            
            // --- CAMBIO CLAVE: Devolvemos el TEXTO (code), no un booleano ---
            Navigator.pop(context, code); 
          }
        },
      ),
    );
  }
}