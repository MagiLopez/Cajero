class Billetes {
  List<int> billetes = [10000, 20000, 50000, 100000];
  Map<int, int> conteoBilletes = {};

  // Método para calcular la distribución de billetes
  void calcularBilletes(int valor) {
    int total = 0;
    conteoBilletes = {for (int billete in billetes) billete: 0};

    while (valor != total) {
      for (int i = 0; i < billetes.length; i++) {
        for (int j = i; j < billetes.length; j++) {
          if (total + billetes[j] <= valor) {
            total += billetes[j];
            conteoBilletes[billetes[j]] = conteoBilletes[billetes[j]]! + 1;
          }
        }
      }
    }
  }

  // Método para imprimir la distribución de billetes
  void imprimirBilletes() {
    conteoBilletes.forEach((billete, cantidad) {
      if (cantidad > 0) {
        print(' $billete     $cantidad');
      }
    });
  }

  Map<int, int> mandarBilletes(int valor) {
    calcularBilletes(valor);
    return conteoBilletes;
  }
}
