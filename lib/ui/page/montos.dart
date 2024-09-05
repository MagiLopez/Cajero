import 'package:flutter/material.dart';
import 'nequi/pagCodigo.dart';
import 'package:cajero/ui/widgets/boton.dart';
import 'package:cajero/Models/billetes.dart'; // Asegúrate de importar la clase Billetes
import 'package:cajero/ui/page/factura.dart';

class MontoPage extends StatefulWidget {
  final String numeroCuenta;
  final String tipo;
  MontoPage({required this.numeroCuenta, required this.tipo});

  @override
  _MontoPageState createState() => _MontoPageState();
}

class _MontoPageState extends State<MontoPage> {
  final List<String> montos = [
    '20.000',
    '50.000',
    '100.000',
    '200.000',
    '500.000',
    '1.000.000'
  ];

  final TextEditingController _controller = TextEditingController();

  void _mostrarAdvertencia() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, ingrese un monto válido.'),
          actions: [
            TextButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
            ),
          ],
        );
      },
    );
  }

  void _procesarMonto(String monto) {
    int valor = int.parse(monto.replaceAll('.', ''));
    Billetes billetes = Billetes();
    billetes.calcularBilletes(valor);
    billetes.imprimirBilletes(); // Muestra la distribución en la consola
    if (widget.tipo == 'N') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PagCod(
            numeroCuenta: widget.numeroCuenta,
            valor: valor,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacturaPage(
            conteoBilletes: billetes.mandarBilletes(valor),
            numeroCuenta: widget.numeroCuenta,
            total: valor,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleccionar Monto'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemCount: montos.length,
                itemBuilder: (context, index) {
                  return CustomButton(
                    text: montos[index],
                    onPressed: () {
                      _procesarMonto(montos[index]);
                      print('Monto seleccionado: ${montos[index]}');
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Text('Valor diferente:'),
            SizedBox(height: 10),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Ingrese monto',
                prefixIcon: Icon(Icons.money),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Aceptar',
              onPressed: () {
                if (_controller.text.isEmpty) {
                  _mostrarAdvertencia();
                } else {
                  _procesarMonto(_controller.text);
                  print('Monto ingresado: ${_controller.text}');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
