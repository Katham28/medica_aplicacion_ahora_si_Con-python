import 'package:flutter/material.dart';
import 'api_service.dart';

class PantallaResetPassword extends StatefulWidget {
  final String token;
  const PantallaResetPassword(this.token, {super.key});

  @override
  State<PantallaResetPassword> createState() => _PantallaResetPasswordState();
}

class _PantallaResetPasswordState extends State<PantallaResetPassword> {
  final _p1 = TextEditingController();
  final _p2 = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(obscureText: true, controller: _p1, decoration: const InputDecoration(labelText: 'Contraseña')),
            TextField(obscureText: true, controller: _p2, decoration: const InputDecoration(labelText: 'Confirmar')),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: () async {
                if (_p1.text != _p2.text) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No coinciden')));
                  return;
                }
                setState(() => _loading = true);
                try {
                  await ApiService.resetearPassword(widget.token, _p1.text);
                  if (mounted) {
                    Navigator.popUntil(context, (r) => r.isFirst);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contraseña actualizada')));
                  }
                } catch (e) {
                  setState(() => _loading = false);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
                }
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
