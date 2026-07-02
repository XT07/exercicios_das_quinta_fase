// Exercício 11: Classe Básica - Produto (Básico)
// Classe Produto com nome, preco e estoque, construtor e
// método exibirInfo(). Cria 3 objetos.

class Produto {
  String nome;
  double preco;
  int estoque;

  Produto(this.nome, this.preco, this.estoque);

  void exibirInfo() {
    print('Produto: $nome | Preço: R\$${preco.toStringAsFixed(2)} | Estoque: $estoque');
  }
}

void main() {
  var produto1 = Produto('Notebook', 3200.00, 8);
  var produto2 = Produto('Mouse', 45.90, 30);
  var produto3 = Produto('Teclado Mecânico', 250.00, 15);

  produto1.exibirInfo();
  produto2.exibirInfo();
  produto3.exibirInfo();
}
