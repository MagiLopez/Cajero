class Banco {
  int intentosRestantes = 3;
  Map<String, Map<String, dynamic>> cuentas = {
    '1234567890': {'password': '125656', 'estado': false},
    '3173293903': {'password': '252525', 'estado': true},
    '3167246618': {'password': '123456', 'estado': false},
  };
  
  bool camposNoBlancos(String telefono, String clave) {
    return telefono.isNotEmpty && clave.isNotEmpty;
  }
  bool validarDatos(String telefono, String clave) {
      return telefono.length == 10 && clave.length == 6;
  }
  
  bool verificarContrasena(String numeroCuenta, String contrasena) {
    if (cuentas.containsKey(numeroCuenta)) {
      return cuentas[numeroCuenta]!['password'] == contrasena;
    } else {
      intentosRestantes--;
    }
    return false; // Si la cuenta no existe o la contraseña es incorrecta
  }

  bool cuentaBloqueada(String telefono) {
    if (cuentas.containsKey(telefono)) {
      return cuentas[telefono]!['estado'] == true;
    }
    return false;// valida q la cuenta no este bloqueada
  }

  // Método para actualizar el estado de una cuenta (activo/inactivo)
  void actualizarEstado(String numeroCuenta, bool nuevoEstado) {
    if (cuentas.containsKey(numeroCuenta)) {
      cuentas[numeroCuenta]!['estado'] = nuevoEstado;
      print(
          'El estado de la cuenta $numeroCuenta ha sido actualizado a $nuevoEstado.');
    } else {
      print('La cuenta $numeroCuenta no existe.');
    }
  }

  bool intentosAgotados() {
    return intentosRestantes <= 0;
  }

  
}
