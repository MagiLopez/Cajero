import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necesario para formatear la fecha y hora
// Asegúrate de importar tu pantalla de menú principal

class FacturaPage extends StatelessWidget {
  final String tipoOperacion = 'RETIRO'; // Tipo de operación
  final String numeroCuenta; // Número de cuenta
  final Map<int, int> conteoBilletes; // Distribución de billetes
  final int total; // Total

  // Constructor que acepta los parámetros necesarios
  FacturaPage({
    required this.numeroCuenta,
    required this.conteoBilletes,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener la fecha y hora actuales
    String fechaActual = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String horaActual = DateFormat('HH:mm').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Factura'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Redirige al menú principal al presionar el botón de retroceso
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/menu',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // Cambia la posición de la sombra
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Fecha y Hora
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fecha: $fechaActual',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Hora: $horaActual',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Número de Cuenta
                Text(
                  'Número de Cuenta:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  numeroCuenta,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),

                // Tipo de Operación
                Text(
                  'Tipo de Operación:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  tipoOperacion,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),

                // Línea divisoria
                Divider(
                  thickness: 2,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),

                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\$${total.toString()}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Línea divisoria
                Divider(
                  thickness: 2,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),

                // Distribución de Billetes
                Text(
                  'Distribución de Billetes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Billete',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Cantidad',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                ...conteoBilletes.entries.map(
                  (entry) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '\$${entry.key.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
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
