import 'package:flutter/material.dart';
import 'Cedula.dart';
import 'Pantalla_crear_medico.dart';
import 'Pantalla_Crear_paciente.dart';

class PCrearCuenta extends StatelessWidget {
  const PCrearCuenta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear cuenta')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                'assets/pac.jpg',
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 10), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MultiScreenPage_Paciente()),
                                );
                              },
                              child: Text('Paciente'),
                            ),

                            SizedBox(height: 60), // espacio entre botones

                             Image.asset(
                                'assets/doc.jpg',
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 10), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MultiScreenPage_Medico()),
                                );
                              },
                              child: Text('Médico'),
                            ),
          ],
        ),
      ),
    );
  }
}






