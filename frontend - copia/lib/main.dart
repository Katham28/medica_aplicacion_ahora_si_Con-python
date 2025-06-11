import 'package:flutter/material.dart';
import 'Pantalla_Menu_Principal.dart';
import 'Pantalla_recuperar_cuenta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación médica',
      debugShowCheckedModeBanner: false,
      home: MenuPrincipal(),
      routes: {
        '/recuperar': (_) => const PObtenerCodigo(),
      },
    );
  }
}
