/// Modelo de dados que representa um Produto cadastrado no app.
class Produto {
  String nome;
  double preco;
  String descricao;
  String imagemUrl; // Bônus: campo de imagem (URL)

  Produto({
    required this.nome,
    required this.preco,
    this.descricao = '',
    this.imagemUrl = '',
  });

  /// Formata o preço no padrão monetário brasileiro (R$ 0,00).
  String get precoFormatado {
    final partes = preco.toStringAsFixed(2).split('.');
    return 'R\$ ${partes[0]},${partes[1]}';
  }
}
