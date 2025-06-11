import 'package:flutter/material.dart';
import 'api_service.dart';
import 'PantallaResetPassword.dart';

class PCodigoVerificacion extends StatefulWidget {
  final String email;
  const PCodigoVerificacion(this.email, {super.key});

  @override
  State<PCodigoVerificacion> createState() => _PCodigoVerificacionState();
}

class _PCodigoVerificacionState extends State<PCodigoVerificacion> {
  final _code = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Código de verificación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _code, decoration: const InputDecoration(labelText: 'Código')),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                setState(() => _loading = true);
                try {
                  final token = await ApiService.verificarCodigo(widget.email, _code.text.trim());
                  if (mounted) {
                    setState(() => _loading = false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PantallaResetPassword(token)),
                    );
                  }
                } catch (e) {
                  setState(() => _loading = false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                }
              },
              child: const Text('Verificar'),
            ),
          ],
        ),
      ),
    );
  }
}
