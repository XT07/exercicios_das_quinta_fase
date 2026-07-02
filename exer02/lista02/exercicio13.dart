// Exercício 13: Herança - ContaBancaria (Intermediário)
// ContaBancaria com depositar/sacar. ContaPoupanca herda e adiciona
// aplicarRendimento(taxa).

class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    saldo += valor;
    print('Depósito de R\$${valor.toStringAsFixed(2)} realizado. Saldo: R\$${saldo.toStringAsFixed(2)}');
  }

  void sacar(double valor) {
    if (valor > saldo) {
      print('Saldo insuficiente para saque de R\$${valor.toStringAsFixed(2)}.');
    } else {
      saldo -= valor;
      print('Saque de R\$${valor.toStringAsFixed(2)} realizado. Saldo: R\$${saldo.toStringAsFixed(2)}');
    }
  }
}

class ContaPoupanca extends ContaBancaria {
  ContaPoupanca(String titular, double saldo) : super(titular, saldo);

  void aplicarRendimento(double taxa) {
    saldo += saldo * taxa;
    print('Rendimento de ${(taxa * 100).toStringAsFixed(1)}% aplicado. Novo saldo: R\$${saldo.toStringAsFixed(2)}');
  }
}

void main() {
  var conta = ContaBancaria('Mestre', 1000.00);
  conta.depositar(500);
  conta.sacar(200);

  print('');

  var poupanca = ContaPoupanca('Mestre', 2000.00);
  poupanca.depositar(300);
  poupanca.aplicarRendimento(0.05); // 5% de rendimento
}
