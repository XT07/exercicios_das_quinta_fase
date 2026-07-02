// Exercício 12: Construtores Nomeados (Intermediário)
// Estende Produto com construtores nomeados: semEstoque() e
// promocao() (20% de desconto).

class Produto {
  String nome;
  double preco;
  int estoque;

  Produto(this.nome, this.preco, this.estoque);

  // Construtor nomeado: cria produto com estoque zero
  Produto.semEstoque(String nome, double preco)
      : nome = nome,
        preco = preco,
        estoque = 0;

  // Construtor nomeado: cria produto com 20% de desconto no preço
  Produto.promocao(String nome, double precoOriginal, int estoque)
      : nome = nome,
        preco = precoOriginal * 0.8,
        estoque = estoque;

  void exibirInfo() {
    print('Produto: $nome | Preço: R\$${preco.toStringAsFixed(2)} | Estoque: $estoque');
  }
}

void main() {
  var produtoNormal = Produto('Cadeira Gamer', 900.00, 5);
  var produtoSemEstoque = Produto.semEstoque('Placa de Vídeo', 2500.00);
  var produtoPromocao = Produto.promocao('Fone Bluetooth', 200.00, 20);

  print('Produto comum:');
  produtoNormal.exibirInfo();

  print('\nProduto sem estoque:');
  produtoSemEstoque.exibirInfo();

  print('\nProduto em promoção (20% off):');
  produtoPromocao.exibirInfo();
}
