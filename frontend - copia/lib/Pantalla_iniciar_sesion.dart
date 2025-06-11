import 'package:flutter/material.dart';
import 'Pantalla_recuperar_cuenta.dart';
class PIniciarSesion extends StatelessWidget {
  const PIniciarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar sesión')),
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

                              // Campo de texto para el usuario
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300), // Ancho máximo
                                      child: TextField(
                                             decoration: InputDecoration(
                                                 labelText: 'Correo electrónico',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                             ),
                                      ),
                              ),

                              SizedBox(height: 20), // espacio entre el campo y el siguiente

                              // Campo de texto para la contraseña
                              ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: 300),
                                      child: TextField(
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                  labelText: 'Contraseña',
                                                  border: OutlineInputBorder(),
                                                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                            ),
                                      ),
                              ),


                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>PObtenerCodigo()),
                                );
                              },
                              child: Text('Olvidé mi contraseña'),
                            ),

                            SizedBox(height: 20), // espacio entre botones

                            ElevatedButton(
                              onPressed: () {
                                //Navigator.push(
                                //  context,
                                  //MaterialPageRoute(builder: (context) => PCrearCuenta()),
                                //);
                              },
                              child: Text('     Iniciar sesión    '),
                            ),
          ],
        ),
      ),
    );
  }
}

