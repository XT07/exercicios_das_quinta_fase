// Exercício 6: Stream Simples - Contador (Básico)
// contadorStream() retorna Stream<int>, emitindo 1 a 10 com 1s de
// intervalo usando async*/yield.

Stream<int> contadorStream() async* {
  for (int i = 1; i <= 10; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() {
  print('Iniciando contador...');

  contadorStream().listen(
    (numero) => print('Recebido: $numero'),
    onDone: () => print('Contador finalizado!'),
  );
}
