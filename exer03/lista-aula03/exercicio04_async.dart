// Exercício 4: Future.wait - Requisições Paralelas (Intermediário)
// 4 funções simulando chamadas de API. Compara execução paralela
// (Future.wait) com execução sequencial, medindo o tempo.

Future<List<String>> buscarProdutos() {
  return Future.delayed(Duration(seconds: 2), () => ['Produto A', 'Produto B']);
}

Future<List<String>> buscarCategorias() {
  return Future.delayed(Duration(seconds: 1), () => ['Eletrônicos', 'Roupas']);
}

Future<List<String>> buscarPromocoes() {
  return Future.delayed(Duration(seconds: 3), () => ['Promoção 1']);
}

Future<List<String>> buscarDestaques() {
  return Future.delayed(Duration(seconds: 1), () => ['Destaque 1', 'Destaque 2']);
}

Future<void> main() async {
  // ---- Execução PARALELA com Future.wait ----
  print('Iniciando execução paralela...');
  final inicioParalelo = DateTime.now();

  final resultados = await Future.wait([
    buscarProdutos(),
    buscarCategorias(),
    buscarPromocoes(),
    buscarDestaques(),
  ]);

  final duracaoParalelo = DateTime.now().difference(inicioParalelo);
  print('Produtos: ${resultados[0]}');
  print('Categorias: ${resultados[1]}');
  print('Promoções: ${resultados[2]}');
  print('Destaques: ${resultados[3]}');
  print('Tempo total (paralelo): ${duracaoParalelo.inSeconds}s');

  print('');

  // ---- Execução SEQUENCIAL (para comparação) ----
  print('Iniciando execução sequencial...');
  final inicioSequencial = DateTime.now();

  await buscarProdutos();
  await buscarCategorias();
  await buscarPromocoes();
  await buscarDestaques();

  final duracaoSequencial = DateTime.now().difference(inicioSequencial);
  print('Tempo total (sequencial): ${duracaoSequencial.inSeconds}s');

  print('\nConclusão: a execução paralela leva o tempo da chamada mais '
      'lenta (~3s), enquanto a sequencial soma todos os tempos (~7s).');
}
