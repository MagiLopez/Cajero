import 'package:flutter/material.dart';
import 'package:cajero/ui/widgets/boton.dart';
import '/Models/nequi.dart';
import 'package:cajero/Models/billetes.dart';
import 'package:cajero/ui/page/factura.dart';
import 'dart:async'; // Importa para usar Timer

class PagCod extends StatefulWidget {
  final String numeroCuenta;
  final int valor;

  PagCod({required this.numeroCuenta, required this.valor});

  @override
  _PagCodState createState() => _PagCodState();
}

class _PagCodState extends State<PagCod> {
  late Nequi nequi;
  final TextEditingController _codigoController = TextEditingController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    nequi = Nequi();
    WidgetsBinding.instance.addPostFrameCallback((_) => _iniciarTemporizador());
  }

  void _iniciarTemporizador() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (nequi.vencio) {
        _mostrarOverlay('Su código ha caducado. Redirigiendo al menú...');
        timer.cancel();
      } else {
        setState(() {});
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nequi.actualizarTemporizador(setState);
  }

  @override
  void dispose() {
    nequi.dispose();
    _codigoController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _verificarCodigo() {
    final codigoIngresado = int.tryParse(_codigoController.text) ?? 0;
     Billetes billetes = Billetes();
    if (nequi.vencio) {
      _mostrarOverlay('Su código ha caducado. Redirigiendo al menú...');
    } else if (codigoIngresado == 0) {
      return;
    } else if (nequi.verificarCodigo(codigoIngresado)) {
      _timer?.cancel(); // Cancelar el temporizador
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacturaPage(conteoBilletes:billetes.mandarBilletes(widget.valor),numeroCuenta:widget.numeroCuenta ,total: widget.valor,),

        ),
      );
    } else {
      if (nequi.intentosAgotados()) {
        _mostrarOverlay('Código cancelado. Redirigiendo al menú...');
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Código Incorrecto'),
            content: Text(
                'El código ingresado es incorrecto. Te quedan ${nequi.intentosRestantes} intentos.'),
            actions: <Widget>[
              TextButton(
                child: Text('Aceptar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      }
    }
  }

  void _generarNuevoCodigo() {
    setState(() {
      nequi.codNeq(setState); // Genera un nuevo código y reinicia intentos
    });
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/menu', // Reemplaza con el nombre de tu ruta de menú
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clave Dinámica'),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: 'Generar Código',
                      onPressed: _generarNuevoCodigo, // Genera el código
                    ),
                    Text(
                      '${nequi.random}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      nequi.vencio ? '00:00' : '${nequi.tiempoRestante} s',
                      style: TextStyle(
                        fontSize: 24,
                        color: nequi.vencio ? Colors.red : Colors.blue,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                TextField(
                  controller: _codigoController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ingrese Código',
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(height: 20),
                CustomButton(
                  text: 'Continuar',
                  onPressed:
                      _codigoController.text.isEmpty ? () {} : _verificarCodigo,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
