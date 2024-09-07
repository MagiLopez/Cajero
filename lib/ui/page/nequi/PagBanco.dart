import 'package:flutter/material.dart';
import 'package:cajero/ui/page/montos.dart';
import 'package:cajero/ui/widgets/boton.dart';
import 'package:cajero/Models/banco.dart'; // Asegúrate de importar la clase Banco

class PagBanco extends StatefulWidget {
  @override
  _PagBancoState createState() => _PagBancoState();
}

class _PagBancoState extends State<PagBanco> {
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _claveController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Banco banco = Banco();

  // Variable para contar los intentos
  int _intentosRestantes = 3;

  @override
  void dispose() {
    _telefonoController.dispose();
    _claveController.dispose();
    super.dispose();
  }

  void _continuar() {
    String telefono = _telefonoController.text;
    String clave = _claveController.text;

    if (!banco.camposNoBlancos(telefono, clave)) {
      _mostrarOverlay('Todos los campos deben ser llenados');
      return;
    }
    if (!banco.validarDatos(telefono, clave)) {
      _mostrarOverlay(
          'Número de teléfono debe tener 10 dígitos y clave 6 dígitos');
      return;
    }
    if (_formKey.currentState!.validate()) {
      if (banco.cuentaBloqueada(telefono)) {
        _mostrarOverlay('Cuenta Bloqueada');
        return;
      }
      if (banco.verificarContrasena(telefono, clave)) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MontoPage(numeroCuenta: '2$telefono', tipo: 'C'),
          ),
        );
      } else {
        _intentosRestantes--;
        if (_intentosRestantes <= 0) {
          _mostrarOverlay('Cuenta bloqueada por intentos fallidos');
          _bloquearCuenta(telefono);
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(
                  'Número de teléfono o clave incorrectos. Te quedan $_intentosRestantes intentos.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  void _bloquearCuenta(String telefono) {
    // Lógica para bloquear la cuenta (esto es solo un ejemplo)
    banco.actualizarEstado(telefono, true);
  }

  void _mostrarOverlay(String mensaje) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            color: Colors.red,
            padding: EdgeInsets.all(16),
            child: Text(
              mensaje,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retiro por Banco X'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ingrese su número de teléfono (10 dígitos)',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _telefonoController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 6, 61, 180),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 6, 61, 180),
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      hintText: 'Número de teléfono',
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no puede estar vacío';
                      } else if (value.length != 10) {
                        return 'El número debe tener exactamente 10 dígitos';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingrese su clave',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _claveController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 6, 61, 180),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 6, 61, 180),
                          width: 2.0,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      hintText: 'Clave',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo de clave no puede estar vacío';
                      } else if (value.length != 6) {
                        return 'La clave debe tener exactamente 6 dígitos';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: 'Continuar',
                    onPressed: _continuar,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
