import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart'; 
import 'Medico.dart';
import 'Cedula.dart';
class MultiScreenPage_Medico extends StatefulWidget {
  @override
  PCrearCuentaMedico createState() => PCrearCuentaMedico();
}

class PCrearCuentaMedico extends State<MultiScreenPage_Medico> {
  final PageController _pageController = PageController();


  int _currentPage = 0;
  final List<GlobalKey<FormState>> keys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),   
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];
// Primero defines los controladores
final TextEditingController nombreController = TextEditingController();
final TextEditingController apellidoController = TextEditingController();
final TextEditingController birthDateController = TextEditingController();
final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cantidadCedulasController= TextEditingController();
  final List<Map<String, TextEditingController>> cedulasData= [];
  final List<TextEditingController> yearControllers= [];
  final TextEditingController codigoController= TextEditingController();


late List<Widget> _screens;

@override
void initState() {
  super.initState();
        _screens = [
          PCrearCuentaMedico1(
            nombreController: nombreController,
            apellidoController: apellidoController,
            birthDateController: birthDateController,
            formKey: keys [0],
          ),
          PCrearCuentaMedico2(
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              phoneController: phoneController,
              formKey: keys [1],

          ),
         PCrearCuentaMedico3(
            cantidadCedulasController: cantidadCedulasController,
            cedulasData: cedulasData,
            yearControllers: yearControllers,
            formKey: keys [2],
          ),

          PCrearCuentaMedico4(
            codigoController:codigoController,


            formKey: keys [3],


          ),
          PCrearCuentaMedico5(
            nombreController: nombreController,
            apellidoController: apellidoController,
            birthDateController: birthDateController,

             emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              phoneController: phoneController,

               cantidadCedulasController: cantidadCedulasController,
                cedulasData: cedulasData,
                yearControllers: yearControllers,


              codigoController:codigoController,

              keys:keys,
          ),
        ];
}

  void verificar_pantalla(int index){
    if (index == 0) {
      if (keys[0].currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (index == 1) {
      if (keys[1].currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (index == 2) {
      if (keys[2].currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    } else if (index == 3) {
      if (keys[3].currentState!.validate()) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear cuenta: Médico')),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: _screens,
      ),


      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Nombre'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Contacto'),
          BottomNavigationBarItem(icon: Icon(Icons.local_hospital), label: 'Profesión'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Activación'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in), label: 'Finalizar'),
        ],
      ),
    );
  }
}


class PCrearCuentaMedico1 extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController birthDateController;
  final  GlobalKey<FormState> formKey;

  PCrearCuentaMedico1({
    super.key,
    required this.nombreController,
    required this.apellidoController,
    required this.birthDateController,
    required this.formKey,
  });


  DateTime? selectedBirthDate;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedBirthDate) {
      selectedBirthDate = picked;
      birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  void _submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final formData = {
        'nombre': nombreController.text,
        'apellido': apellidoController.text,
        'fecha_nacimiento': birthDateController.text,
      };

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Datos registrados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nombre: ${formData['nombre']}'),
              Text('Apellido: ${formData['apellido']}'),
              Text('Fecha Nacimiento: ${formData['fecha_nacimiento']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/doc.jpg',
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    const Text('Nombre', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFormField(
                        controller: nombreController,
                        autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                        decoration: const InputDecoration(
                          labelText: 'Nombre (s)',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          suffixIcon: Icon(Icons.person),
                          
                        ),
                       
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su nombre';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFormField(
                        controller: apellidoController,
                        autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                        decoration: const InputDecoration(
                          labelText: 'Apellido (s)',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          suffixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su apellido';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Fecha de nacimiento', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFormField(
                        controller: birthDateController,
                        autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                        decoration: InputDecoration(
                          labelText: 'Fecha de nacimiento',
                          hintText: 'DD/MM/AAAA',
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => selectDate(context),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => selectDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor seleccione su fecha de nacimiento';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => _submitForm(context),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                      child: const Text('Verificar datos', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}



class PCrearCuentaMedico2 extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;
  final GlobalKey<FormState> formKey;
  const PCrearCuentaMedico2({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.formKey,
  });

  @override
  State<PCrearCuentaMedico2> createState() => _PCrearCuentaMedico2State();
}

class _PCrearCuentaMedico2State extends State<PCrearCuentaMedico2> {
  

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su correo';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != widget.passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  void _submitForm() {
    if (widget.formKey.currentState!.validate()) {
      final formData = {
        'email': widget.emailController.text,
        'phone': widget.phoneController.text,
      };

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Datos registrados'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Correo: ${formData['email']}'),
              Text('Teléfono: ${formData['phone']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                Image.asset('assets/doc.jpg', width: 50),
                const SizedBox(height: 20),
                const Text('Correo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    controller: widget.emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      hintText: 'correo@ejemplo.com',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.mail),
                    ),
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 20),

                
                const Text('Contraseña', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    controller: widget.passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.lock),
                    ),
                    validator: _validatePassword,
                  ),
                ),
                const SizedBox(height: 20),


                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    controller: widget.confirmPasswordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar contraseña',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.lock),
                    ),
                    validator: _validateConfirmPassword,
                  ),
                ),
                const SizedBox(height: 20),


                const Text('Teléfono', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    controller: widget.phoneController,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                    decoration: const InputDecoration(
                      labelText: 'Teléfono',
                      hintText: '55 1234 5678',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Ingrese su teléfono';
                      final clean = value.replaceAll(' ', '');
                      if (clean.length != 10) return 'Deben ser 10 dígitos';
                      if (!RegExp(r'^[0-9]+$').hasMatch(clean)) return 'Solo números permitidos';
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(minimumSize: const Size(300, 50)),
                  child: const Text('Verificar datos', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class PCrearCuentaMedico3 extends StatefulWidget {
  final TextEditingController cantidadCedulasController;
  final List<Map<String, TextEditingController>> cedulasData;
  final List<TextEditingController> yearControllers;
  final GlobalKey<FormState> formKey;

  const PCrearCuentaMedico3({
    super.key,
    required this.cantidadCedulasController,
    required this.cedulasData,
    required this.yearControllers,
    required this.formKey,
  });

  @override
  State<PCrearCuentaMedico3> createState() => _PCrearCuentaMedico3State();
}

class _PCrearCuentaMedico3State extends State<PCrearCuentaMedico3> {
  String? _errorCedula;
  bool _validado = false;
  
  @override
  void dispose() {
    super.dispose();
  }

  // Método para seleccionar año
  void _selectYear(int index, BuildContext context) async {
    final DateTime? picked = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Seleccione el año"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime.now(),
              selectedDate: DateTime.now(),
              onChanged: (DateTime dateTime) {
                Navigator.pop(context, dateTime);
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        widget.yearControllers[index].text = picked.year.toString();
      });
    }
  }

  // Validación de cédula con generación automática de campos
  void _validarYGenerarCampos(String value) {
    final error = _validateCedula(value);
    
    setState(() {
      _errorCedula = error;
      _validado = error == null;
    });

    if (_validado) {
      const SizedBox(height: 10);
      final cantidad = int.tryParse(value) ?? 0;
      _generarCampos(cantidad);
    } else {
      // Limpiar campos si la validación falla
      setState(() {
        widget.cedulasData.clear();
        widget.yearControllers.clear();
      });
    }
  }

  String? _validateCedula(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese la cantidad de cédulas';
    }
    if (value == '0') {
      return 'Se debe ingresar al menos una cédula';
    }
    if (int.tryParse(value) == null) {
      return 'Ingrese un número válido';
    }
    return null;
  }

  void _generarCampos(int cantidad) {
    setState(() {
      // Limpiar campos existentes
      widget.cedulasData.clear();
      widget.yearControllers.clear();
     const SizedBox(height: 10);
      // Generar nuevos campos
      for (int i = 0; i < cantidad; i++) {
        widget.cedulasData.add({
          'cedula': TextEditingController(),
          'institucion': TextEditingController(),
          'tipo': TextEditingController(),
        });
        widget.yearControllers.add(TextEditingController());
      }
    });
  }

  bool _camposCompletos() {
    if (widget.cedulasData.isEmpty) return false;
    
    for (final data in widget.cedulasData) {
      if (data['cedula']!.text.isEmpty || 
          data['institucion']!.text.isEmpty || 
          data['tipo']!.text.isEmpty) {
        return false;
      }
    }
    
    for (final yearController in widget.yearControllers) {
      if (yearController.text.isEmpty) {
        return false;
      }
    }
    
    return true;
  }

  void _guardarDatos() {
    if (!_camposCompletos()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete todos los campos antes de guardar'),
          duration: Duration(seconds: 2),
      ));
      return;
    }

    final datosCompletos = widget.cedulasData.asMap().entries.map((entry) {
      final index = entry.key;
      final data = entry.value;
      
      return {
        'cedula': data['cedula']!.text,
        'institucion': data['institucion']!.text,
        'tipo': data['tipo']!.text,
        'year': widget.yearControllers[index].text,
      };
    }).toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Datos registrados'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < datosCompletos.length; i++) ...[
                Text('Registro ${i + 1}:', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Cédula: ${datosCompletos[i]['cedula']}'),
                Text('Institución: ${datosCompletos[i]['institucion']}'),
                Text('Tipo: ${datosCompletos[i]['tipo']}'),
                Text('Año: ${datosCompletos[i]['year']}'),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/doc.jpg',
                width: 50,
                fit: BoxFit.cover,
              ),
              
              const SizedBox(height: 9),
              const Text('Cantidad de cédulas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300),
                child: TextField(
                  controller: widget.cantidadCedulasController,
                  
                  decoration: InputDecoration(
                    labelText: 'Cantidad de cédulas',
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.numbers),
                    errorText: _errorCedula,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  
                  onChanged: (value) {
                    _validarYGenerarCampos(value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              ...widget.cedulasData.asMap().entries.map((entry) {
                final index = entry.key;
                final data = entry.value;
                
                return Column(
                  children: [
                    Text('Número de cédula profesional ${index + 1}', 
                         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      
                      child: TextField(
                        controller: data['cedula'],
                        decoration: const InputDecoration(
                          labelText: 'Número de cédula',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.numbers),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),

                    const SizedBox(height: 9),
                    const Text('Institución', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextField(
                        controller: data['institucion'],
                        decoration: const InputDecoration(
                          labelText: 'Institución',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.school),
                        ),
                      ),
                    ),

                    const SizedBox(height: 9),
                    const Text('Tipo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextField(
                        controller: data['tipo'],
                        decoration: const InputDecoration(
                          labelText: 'Tipo',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.badge),
                        ),
                      ),
                    ),

                    const SizedBox(height: 9),
                    const Text('Año', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: TextFormField(
                        controller: widget.yearControllers[index],
                        decoration: InputDecoration(
                          labelText: 'Año',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today),
                            onPressed: () => _selectYear(index, context),
                          ),
                        ),
                        readOnly: true,
                        onTap: () => _selectYear(index, context),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                );
              }).toList(),

              if (widget.cedulasData.isNotEmpty) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _camposCompletos() ? _guardarDatos : null,
                  child: const Text('Guardar Todos los Datos'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}




class PCrearCuentaMedico4 extends StatelessWidget {
  final TextEditingController codigoController;
  final GlobalKey<FormState> formKey;

  // Constructor que recibe los controladores
  PCrearCuentaMedico4({
    super.key,
    required this.codigoController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/doc.jpg',
                  width: 50,
                  fit: BoxFit.cover,
                ),
                
                const SizedBox(height: 24),
                const Text(
                  'Código de activación', 
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                
                const SizedBox(height: 8),
                const Text(
                  'Ingrese el código de 12 dígitos que recibió por correo',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 24),
                // Campo de código de activación
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: TextFormField(
                    controller: codigoController,
                    autovalidateMode: AutovalidateMode.onUserInteraction, // <<--- Clave aquí
                    decoration: InputDecoration(
                      labelText: 'XXXX-XXXX-XXXX',
                      border: const OutlineInputBorder(),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, 
                        horizontal: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => codigoController.clear(),
                      ),
                      prefixIcon: const Icon(Icons.vpn_key),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese su código de activación';
                      }
                      if (value.length != 12) {
                        return 'Deben ser 12 dígitos';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Solo números permitidos';
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 32),
                
                // Botón de verificación
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final codigo = codigoController.text;
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Código válido'),
                            content: Text('Código registrado: $codigo'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Continuar'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Verificar Código',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Opción para reenviar código
                TextButton(
                  onPressed: () {
                    // Lógica para reenviar código
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Se ha enviado un nuevo código a su correo'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  },
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '¿No recibió el código? ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                          text: 'Reenviar',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PCrearCuentaMedico5 extends StatelessWidget {
  final List<GlobalKey<FormState>> keys ;

    final TextEditingController nombreController;
  final TextEditingController apellidoController;
  final TextEditingController birthDateController ;
  final TextEditingController emailController;
    final TextEditingController passwordController ;
    final TextEditingController confirmPasswordController ;
    final TextEditingController phoneController;
    final TextEditingController cantidadCedulasController;
    final List<Map<String, TextEditingController>> cedulasData;
    final List<TextEditingController> yearControllers;
    final TextEditingController codigoController;
    

 const PCrearCuentaMedico5({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.nombreController,
    required this.apellidoController,
    required this.cantidadCedulasController,
    required this.codigoController,
    required this.birthDateController,
    required this.confirmPasswordController,
    required this.cedulasData,
    required this.yearControllers,
    required this.keys,
    
  });

void crear_medico() {
  List<Cedula> cedulas_prev = [];

  for (int i = 0; i < int.parse(cantidadCedulasController.text.isNotEmpty ? cantidadCedulasController.text : '0'); i++) {
    cedulas_prev.add(
      Cedula(
        institucion: cedulasData[i]['institucion']?.text ?? '',
        numero: cedulasData[i]['cedula']?.text ?? '',
        profesion: cedulasData[i]['tipo']?.text ?? '',
        tipo: cedulasData[i]['tipo']?.text ?? '',
        yearExpedicion: int.parse(yearControllers[i].text.isNotEmpty ? yearControllers[i].text : '1'),
      )
    );
  }

  final medico = Medico(
    nombres: nombreController.text.isNotEmpty ? nombreController.text : '',
    apellidos: apellidoController.text.isNotEmpty ? apellidoController.text : '',
    correo: emailController.text.isNotEmpty ? emailController.text : '',
    fechaNacimiento: birthDateController.text.isNotEmpty
        ? DateFormat('dd/MM/yyyy').parse(birthDateController.text)
        : DateTime.now(),
    contrasena: passwordController.text.isNotEmpty ? passwordController.text : '',
    telefono: phoneController.text.isNotEmpty ? int.parse(phoneController.text) : 1,
    cedulas: cedulas_prev,
    pacientes: null,
  );

  debugPrint(medico.toString());
}


bool validarCampos() {
  // Verificar campos principales
  if (nombreController.text.isEmpty ||
      apellidoController.text.isEmpty ||
      birthDateController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwordController.text.isEmpty ||
      confirmPasswordController.text.isEmpty ||
      phoneController.text.isEmpty ||
      cantidadCedulasController.text.isEmpty || codigoController.text.isEmpty) {
    debugPrint('Por favor complete todos los campos principales');
    return false;
  }

  // Verificar contraseñas coinciden
  if (passwordController.text != confirmPasswordController.text) {
    debugPrint('Las contraseñas no coinciden');
    return false;
  }

  // Verificar cédulas
  int cantidadCedulas = int.tryParse(cantidadCedulasController.text) ?? 0;
  if (cantidadCedulas==0){
    debugPrint('Por favor ingrese al menos una cédula');
    return false;
  }else{
    for (int i = 0; i < cantidadCedulas; i++) {
          if (cedulasData[i]['institucion']?.text.isEmpty ?? true )
          { 
            debugPrint('Por favor complete todos los datos de la cédula ${i + 1}');
            return false;
          }

          else if (  cedulasData[i]['cedula']?.text.isEmpty ?? true ){
              debugPrint('Por favor complete todos los datos de la cédula ${i + 1}');
            return false;
          }

          else if (   cedulasData[i]['tipo']?.text.isEmpty ?? true  ){
              debugPrint('Por favor complete todos los datos de la cédula ${i + 1}');
            return false;
          }

          else if (  yearControllers[i].text.isEmpty) {
            debugPrint('Por favor complete todos los datos de la cédula ${i + 1}');
            return false;
          }
  }
  
  }

  return true;
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
            body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
                             Image.asset(
                                'assets/doc.jpg',
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                             
                              SizedBox(height: 10), // espacio entre botones

                          ElevatedButton(
                              onPressed: () {
                               if ( validarCampos())
                                crear_medico(); 
                                else
                                {
                                  debugPrint('Por favor complete todos los campos');
                                }
                                //Navigator.push(
                                //  context,
                                  //MaterialPageRoute(builder: (context) => PCrearCuenta()),
                                //);
                              },
                              child: Text('     Crear cuenta    '),
                            ),

                              SizedBox(height: 10), // espacio entre botones

                              
                            
          ],
        ),
      ),
    );
  }


}