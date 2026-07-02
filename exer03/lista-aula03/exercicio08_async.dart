// Exercício 8: Transformando Streams (Intermediário)
// Stream de 1 a 20, filtra pares (where), multiplica por 2 (map) e
// pega os 5 primeiros (take).

Stream<int> numerosStream() async* {
  for (int i = 1; i <= 20; i++) {
    yield i;
  }
}

void main() {
  print('Processando stream de números...');

  numerosStream()
      .where((n) => n % 2 == 0)
      .map((n) => n * 2)
      .take(5)
      .listen(
        (n) => print('Resultado: $n'),
        onDone: () => print('Processamento concluído!'),
      );
}
