import 'package:flutter/material.dart';
import 'Pantalla_Menu_Principal.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicación médica',
      home: MenuPrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}

