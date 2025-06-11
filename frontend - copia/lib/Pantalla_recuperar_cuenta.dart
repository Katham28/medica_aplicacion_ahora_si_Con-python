import 'package:flutter/material.dart';
import 'api_service.dart';
import 'codigoverificacion.dart';

class PObtenerCodigo extends StatefulWidget {
  const PObtenerCodigo({super.key});

  @override
  State<PObtenerCodigo> createState() => _PObtenerCodigoState();
}

class _PObtenerCodigoState extends State<PObtenerCodigo> {
  final _email = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: 'Correo')),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() => _loading = true);
                await ApiService.enviarCodigo(_email.text.trim());
                if (mounted) {
                  setState(() => _loading = false);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PCodigoVerificacion(_email.text.trim()),
                    ),
                  );
                }
              },
              child: const Text('Enviar código'),
            ),
          ],
        ),
      ),
    );
  }
}
