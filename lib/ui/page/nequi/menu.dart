import 'package:flutter/material.dart';
import 'pagNeq.dart';
import 'PagBanco.dart';

class CajeroHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cajero Automático', style: TextStyle(fontSize: 15)),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '¡Bienvenido!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                  color: Color.fromARGB(255, 6, 61, 180),
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Color.fromARGB(255, 84, 136, 233),
                      offset: Offset(4.0, 4.0),
                    ),
                  ],
                ),
              ),
            ),
            // Añadir la imagen del banco aquí
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                'assets/bancos.png', // Ruta a la imagen dentro de la carpeta assets
                width: 300, // Ajusta el tamaño según tus necesidades
                height: 300, // Ajusta el tamaño según tus necesidades
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200, // Ancho uniforme para ambos botones
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PagNeq()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 20, 74, 168),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        icon: Icon(Icons.account_balance_wallet,
                            color: Colors
                                .white), // Cambiado a 'account_balance_wallet'
                        label: Text(
                          'Retiro por Nequi',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200, // Ancho uniforme para ambos botones
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PagBanco()),
                          ); // Acción para Retiro por Bancolombia
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 20, 74, 168),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        icon: Icon(Icons.add_card,
                            color: Colors.white), // Cambiado a 'add card'
                        label: Text(
                          'Retiro por Bancolombia',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
