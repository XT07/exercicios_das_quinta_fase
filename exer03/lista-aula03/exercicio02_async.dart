// Exercício 2: Convertendo .then() para async/await (Básico)
// Reescreve o exercício 1 com async/await e try/catch. A função lança
// exceção ocasionalmente (aqui, de forma controlada por um parâmetro).

Future<String> buscarUsuario({bool comErro = false}) {
  return Future.delayed(Duration(seconds: 2), () {
    if (comErro) {
      throw Exception('Falha ao buscar usuário: usuário não encontrado.');
    }
    return 'Maria Silva';
  });
}

Future<void> main() async {
  // Caso de sucesso
  print('Buscando usuário (caso de sucesso)...');
  try {
    final nome = await buscarUsuario();
    print('Usuário encontrado: $nome');
  } catch (e) {
    print('Erro: $e');
  }

  print('');

  // Caso de erro (simulado)
  print('Buscando usuário (caso de erro)...');
  try {
    final nome = await buscarUsuario(comErro: true);
    print('Usuário encontrado: $nome');
  } catch (e) {
    print('Erro capturado: $e');
  }
}
