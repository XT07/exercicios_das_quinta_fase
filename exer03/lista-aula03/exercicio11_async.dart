// Exercício 11: Operadores Null Safety em Async (Intermediário)
// buscarConfiguracao(chave) retorna Future<String?>. Usa cache local
// (Map) e operadores ?., ?? e !.

Map<String, String> cache = {
  'tema': 'escuro', // já vem em cache
};

Future<String?> buscarDaAPI(String chave) {
  return Future.delayed(Duration(seconds: 1), () {
    // Simula que nem toda chave existe na "API"
    final valoresApi = {
      'idioma': 'pt-BR',
      'notificacoes': 'ativadas',
    };
    return valoresApi[chave]; // pode retornar null
  });
}

Future<String?> buscarConfiguracao(String chave) async {
  // ?? -> se não estiver no cache, busca na API
  final valor = cache[chave] ?? await buscarDaAPI(chave);

  // Se veio da API e não é nulo, guarda no cache para próximas buscas
  if (valor != null) {
    cache[chave] = valor;
  }

  return valor;
}

Future<void> main() async {
  // Configuração já em cache (retorno imediato)
  final tema = await buscarConfiguracao('tema');
  print('Tema: ${tema ?? "não definido"}');

  // Configuração que precisa ser buscada na "API"
  final idioma = await buscarConfiguracao('idioma');
  print('Idioma: ${idioma ?? "não definido"}');

  // Uso do operador ?. para acessar propriedades com segurança
  print('Idioma em maiúsculas: ${idioma?.toUpperCase() ?? "N/A"}');

  // Configuração que não existe em lugar nenhum
  final inexistente = await buscarConfiguracao('chave_que_nao_existe');
  print('Configuração inexistente: ${inexistente ?? "valor padrão"}');

  // Uso do operador ! (bang) -- só usar quando temos CERTEZA que não é nulo
  final notificacoes = await buscarConfiguracao('notificacoes');
  if (notificacoes != null) {
    // Aqui já validamos, então o uso de ! é seguro
    print('Notificações (forçado com !): ${notificacoes!}');
  }
}
