// Exercício 3: Sequência de Operações Assíncronas (Intermediário)
// autenticar() -> buscarPerfil(token) -> buscarPedidos(userId), cada
// uma dependendo do resultado da anterior.

Future<String> autenticar() {
  return Future.delayed(Duration(seconds: 1), () {
    print('Autenticando...');
    return 'token-abc123';
  });
}

Future<Map<String, dynamic>> buscarPerfil(String token) {
  return Future.delayed(Duration(seconds: 1), () {
    print('Buscando perfil com token: $token');
    return {'id': 42, 'nome': 'Mestre'};
  });
}

Future<List<String>> buscarPedidos(int userId) {
  return Future.delayed(Duration(seconds: 1), () {
    print('Buscando pedidos do usuário $userId');
    return ['Pedido #1001', 'Pedido #1002', 'Pedido #1003'];
  });
}

Future<void> main() async {
  try {
    final token = await autenticar();
    final perfil = await buscarPerfil(token);
    final pedidos = await buscarPedidos(perfil['id']);

    print('\nResultado final:');
    print('Perfil: ${perfil['nome']} (ID: ${perfil['id']})');
    print('Pedidos: $pedidos');
  } catch (e) {
    print('Erro na sequência de operações: $e');
  }
}
