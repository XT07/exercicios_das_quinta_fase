// Exercício 1: Simulando Chamada de API (Básico)
// Função buscarUsuario() retorna Future<String>, simula delay de 2s
// com Future.delayed. Na main(), usa .then() para pegar o resultado.

Future<String> buscarUsuario() {
  return Future.delayed(Duration(seconds: 2), () => 'Maria Silva');
}

void main() {
  print('Buscando usuário...');

  buscarUsuario().then((nome) {
    print('Usuário encontrado: $nome');
  });

  print('Essa mensagem aparece antes do resultado, pois a busca é assíncrona.');
}
