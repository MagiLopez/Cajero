import 'package:flutter/material.dart';
import 'nequi/menu.dart'; // Asegúrate de que esta ruta sea correcta

void main() {
  runApp(CajeroApp()); // Asegúrate de usar la clase correcta aquí
}

class CajeroApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cajero Automático',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/menu', // Ruta inicial
      routes: {
        '/menu': (context) => CajeroHomePage(), // Ruta para el menú principal
      },
    );
  }
}
