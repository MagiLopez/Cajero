import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necesario para formatear la fecha y hora

class FacturaPage extends StatelessWidget {
  final String tipoOperacion = 'RETIRO';
  final String numeroCuenta;
  final Map<int, int> conteoBilletes;
  final int total;

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
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _construirFilaFechaHora(fechaActual, horaActual),
                _construirFilaDetalle('Número de Cuenta:', numeroCuenta),
                _construirFilaDetalle('Tipo de Operación:', tipoOperacion),
                _construirLineaDivisoria(),
                _construirFilaTotal(total),
                _construirLineaDivisoria(),
                _construirDistribucionBilletes(conteoBilletes),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _construirFilaFechaHora(String fecha, String hora) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Fecha: $fecha', style: _estiloTextoNegrita()),
        Text('Hora: $hora', style: _estiloTextoNegrita()),
      ],
    );
  }

  Widget _construirFilaDetalle(String etiqueta, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(etiqueta, style: _estiloTextoNegrita()),
        Text(valor, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _construirLineaDivisoria() {
    return const Column(
      children: [
        Divider(thickness: 2, color: Colors.blue),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _construirFilaTotal(int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Total:', style: _estiloTextoNegrita()),
        Text('\$${total.toString()}', style: _estiloTextoNegrita()),
      ],
    );
  }

  // Widget para la distribución de billetes
  Widget _construirDistribucionBilletes(Map<int, int> conteoBilletes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Distribución de Billetes', style: _estiloTextoNegrita()),
        SizedBox(height: 10),
        _construirEncabezadoBilletes(),
        _construirListaBilletes(conteoBilletes),
      ],
    );
  }

  // Widget para el encabezado de la distribución de billetes
  Widget _construirEncabezadoBilletes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Text('Billete', style: _estiloTextoNegrita())),
        Expanded(
            child: Text('Cantidad',
                textAlign: TextAlign.right, style: _estiloTextoNegrita())),
      ],
    );
  }

  // Widget para la lista de billetes
  Widget _construirListaBilletes(Map<int, int> conteoBilletes) {
    return Column(
      children: conteoBilletes.entries
          .map(
            (entrada) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text('\$${entrada.key}',
                        style: TextStyle(fontSize: 16))),
                Expanded(
                    child: Text(entrada.value.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontSize: 16))),
              ],
            ),
          )
          .toList(),
    );
  }

  // Estilo de texto en negrita
  TextStyle _estiloTextoNegrita() {
    return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  }
}
