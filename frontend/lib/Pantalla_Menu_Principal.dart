import 'package:flutter/material.dart';
import 'Pantalla_iniciar_sesion.dart';
import 'Pantalla_crear_cuentas.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menú Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                'assets/cor.png',
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 20), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PIniciarSesion()),
                                );
                              },
                              child: Text('Iniciar sesión'),
                            ),

                            SizedBox(height: 20), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PCrearCuenta()),
                                );
                              },
                              child: Text('Crear cuenta'),
                            ),
          ],
        ),
      ),
    );
  }
}
