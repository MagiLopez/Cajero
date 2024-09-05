import 'package:flutter/material.dart';
import 'package:cajero/ui/page/montos.dart';
import 'package:cajero/ui/widgets/boton.dart';

class PagNeq extends StatefulWidget {
  @override
  _PagNeqState createState() => _PagNeqState();
}

class _PagNeqState extends State<PagNeq> {
  final TextEditingController _telefonoController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Clave para el formulario

  @override
  void dispose() {
    _telefonoController.dispose();
    super.dispose();
  }

  void _continuar() {
    // Verifica si el formulario es válido
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido, navega a la siguiente página
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MontoPage(
                numeroCuenta: '0${_telefonoController.text}', tipo: 'N')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retiro por Nequi'),
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
          // Fondo de la página
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
              key: _formKey, // Asigna la clave del formulario
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
                  SizedBox(height: 40),
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
                      return null; // El valor es válido
                    },
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: 'Continuar',
                    onPressed: _continuar, // Llama a la función de continuar
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
