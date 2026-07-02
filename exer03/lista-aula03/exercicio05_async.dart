// Exercício 5: Timeout e Cancelamento (Avançado)
// Busca dados de API lenta (5s), usa .timeout() para cancelar após 3s
// e trata TimeoutException.

import 'dart:async';

Future<String> buscarDadosLentos() {
  return Future.delayed(Duration(seconds: 5), () => 'Dados carregados com sucesso!');
}

Future<void> main() async {
  print('Buscando dados (limite de 3 segundos)...');

  try {
    final resultado = await buscarDadosLentos().timeout(Duration(seconds: 3));
    print('Resultado: $resultado');
  } on TimeoutException {
    print('⚠️  Operação demorou muito! Tente novamente mais tarde.');
  } catch (e) {
    print('Erro inesperado: $e');
  }

  print('Execução finalizada.');
}
