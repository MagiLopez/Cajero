import 'dart:async';
import 'dart:math';

class Nequi {
  Timer? timer;
  int random = 0;
  bool vencio = false;
  int tiempoRestante = 0;
  DateTime? tiempoFin;
  int intentosRestantes = 3; // Inicializa el contador de intentos

  void codNeq(Function updateState) {
    updateState(() {
      random = Random().nextInt(900000) + 100000;
      vencio = false;
      tiempoRestante = 15; // Duración del temporizador en segundos
      intentosRestantes = 3;
      tiempoFin = DateTime.now().add(Duration(seconds: tiempoRestante));
    });
    iniciarTemporizador(updateState);
  }

  void iniciarTemporizador(Function updateState) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      final tiempoActual = DateTime.now();
      updateState(() {
        tiempoRestante = tiempoFin!.difference(tiempoActual).inSeconds;
        if (tiempoRestante <= 0) {
          vencio = true;
          tiempoRestante = 0;
          timer.cancel();
        }
      });
    });
  }

  void actualizarTemporizador(Function updateState) {
    if (tiempoFin != null && tiempoRestante > 0) {
      final tiempoActual = DateTime.now();
      tiempoRestante = tiempoFin!.difference(tiempoActual).inSeconds;
      if (tiempoRestante <= 0) {
        vencio = true;
        tiempoRestante = 0;
      }
      iniciarTemporizador(updateState);
    }
  }

  // Método que maneja la verificación del código y los intentos
  bool verificarCodigo(int codigoIngresado) {
    if (codigoIngresado == random) {
      return true;
    } else {
      intentosRestantes--;
      return false;
    }
  }

  // Método para saber si los intentos se han agotado
  bool intentosAgotados() {
    return intentosRestantes <= 0;
  }

  void dispose() {
    timer?.cancel();
  }
  // Lista de prefijos válidos como cadenas

  List<String> prefijosTelefonicos = [
    '300',
    '301',
    '302',
    '303',
    '304',
    '324',
    '305',
    '310',
    '311',
    '312',
    '313',
    '314',
    '320',
    '321',
    '322',
    '323',
    '315',
    '316',
    '317',
    '318',
    '319',
    '350',
    '351',
    '333'
  ];
  bool verificarTelefono(String telefono) {
    String prefijo = telefono.substring(0, 3);
    if (telefono.length == 10 && prefijosTelefonicos.contains(prefijo)) {
      return true;
    }
    return false;
  }
}
