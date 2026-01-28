import 'package:flutter/material.dart';

import 'auth_gate.dart'; // <--- IMPORTANTE

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.clientId});
  final String clientId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // En vez de HomeScreen, ponemos al Portero
      home: const AuthGate(), 
    );
  }
}