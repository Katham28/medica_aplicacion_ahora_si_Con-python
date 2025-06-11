import 'Cedula.dart';
import 'Paciente.dart';
class Medico {
  // Propiedades
  String _nombres;
  String _apellidos;
  String _correo;
  int _edad;
  DateTime _fechaNacimiento;
  String _contrasena;
  int _telefono;
  int _num_cedula=0;
  final List <Cedula> _listaCedulas = [];
  final List<Paciente> _listaPacientes = [];

  // Constructor principal
  Medico({
    required String nombres,
    required String apellidos,
    required String correo,
    required DateTime fechaNacimiento,
    required String contrasena,
    required int telefono,
    List<Cedula>? cedulas,
    List<Paciente>? pacientes,
  })  : _nombres = nombres,
        _apellidos = apellidos,
        _correo = correo,
        _edad = DateTime.now().year - fechaNacimiento.year,
        _fechaNacimiento = fechaNacimiento,
        _contrasena = contrasena,
        _telefono = telefono {
    if (cedulas != null) {
      _listaCedulas.addAll(cedulas);
    }
    if (pacientes != null) {
      _listaPacientes.addAll(pacientes);
    }
  }

  

  // Getters y setters con validaciones
  String get nombres => _nombres;
  set nombre(String value) {
    _nombres = value;
  }

  String get apellidos => _apellidos;
  set apellidos(String value) {
    _apellidos = value;
  }

  String get correo => _correo;
  set correo(String value) {
    _correo = value;
  }

  int get edad => _edad;
  set edad(int value) {
    _edad = value;
  }

  DateTime get fechaNacimiento => _fechaNacimiento;
  set fechaNacimiento(DateTime value) {
    if (value.isAfter(DateTime.now())) throw ArgumentError('Fecha de nacimiento no puede ser futura');
    _fechaNacimiento = value;
    _edad = DateTime.now().year - value.year;
  }

  String get contrasena => _contrasena;
  set contrasena(String value) {
    _contrasena = value;
  }

  int get telefono => _telefono;
  set telefono(int value) {
    if (value.toString().length != 10) throw ArgumentError('Teléfono debe tener 10 dígitos');
    _telefono = value;
  }

 

  // Método para nombre completo
  String get nombreCompleto => '$_nombres $_apellidos'.trim();

  // Método para edad exacta
  int get edadExacta {
    final ahora = DateTime.now();
    int edad = ahora.year - _fechaNacimiento.year;
    if (ahora.month < _fechaNacimiento.month ||
        (ahora.month == _fechaNacimiento.month && ahora.day < _fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

   // Métodos para manejar cédulas
  void agregarCedula(Cedula cedula) => _listaCedulas.add(cedula);
  void removerCedula(Cedula cedula) => _listaCedulas.remove(cedula);
  List<Cedula> get cedulas => _listaCedulas;

  // Métodos para manejar pacientes
  void agregarPaciente(Paciente paciente) => _listaPacientes.add(paciente);
  void removerPaciente(Paciente paciente) => _listaPacientes.remove(paciente);
  List<Paciente> get pacientes => _listaPacientes;

  // Método toString
  @override
  String toString() {
    return 'Médico: $nombreCompleto\n'
            'Fecha de Nacimiento: $_fechaNacimiento\n'
           'Edad: $edadExacta años\n'
           'Correo: $_correo\n'
           'Teléfono: $_telefono\n'
           '# Cédulas: ${_listaCedulas.length}\n'
           '# Pacientes: ${_listaPacientes.length}';
  }
}