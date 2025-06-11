import 'dart:typed_data'; // Para Int32List
import 'package:intl/intl.dart'; // Para formateo de fechas// Para formateo de fechas

class Cedula {
  // Variables privadas
  String _institucion;
  String _numero;
  String _profesion;
  String _tipo;
  int _yearExpedicion; 

  // Constructor con parámetros requeridos
  Cedula({
    required String institucion,
    required String numero,
    required String profesion,
    required String tipo,
    required int yearExpedicion,
  })  : _institucion = institucion,
        _numero = numero,
        _profesion = profesion,
        _tipo = tipo,
        _yearExpedicion = yearExpedicion;

  // Getters y setters para institucion
  String get institucion => _institucion;
  set institucion(String value) {
    _institucion = value;
  }

  // Getters y setters para numero
  String get numero => _numero;
  set numero(String value) {
    _numero = value;
  }

  // Getters y setters para profesion
  String get profesion => _profesion;
  set profesion(String value) {
    _profesion = value;
  }

  // Getters y setters para tipo
  String get tipo => _tipo;
  set tipo(String value) {
    _tipo = value;
  }

  // Getters y setters para yearExpedicion
  int get yearExpedicion => _yearExpedicion;
  set yearExpedicion(int value) {
    _yearExpedicion = value;
  }

  // Método toString para representación en cadena
  @override
  String toString() {
    return 'Cédula: $_numero ($_tipo)\n'
           'Profesión: $_profesion\n'
           'Institución: $_institucion\n'
           'Expedición: $_yearExpedicion\n';
  }

}



