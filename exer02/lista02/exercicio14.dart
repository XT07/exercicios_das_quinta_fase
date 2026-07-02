// Exercício 14: Interface e Implementação (Avançado)
// Classe abstrata Veiculo com método abstrato acelerar().
// Carro e Moto implementam de forma diferente.

abstract class Veiculo {
  void acelerar();
}

class Carro extends Veiculo {
  @override
  void acelerar() {
    print('O carro está acelerando na estrada! Vrum vrum!');
  }
}

class Moto extends Veiculo {
  @override
  void acelerar() {
    print('A moto está acelerando entre os carros! Vruuum!');
  }
}

void main() {
  List<Veiculo> veiculos = [Carro(), Moto(), Carro()];

  for (var veiculo in veiculos) {
    veiculo.acelerar();
  }
}
