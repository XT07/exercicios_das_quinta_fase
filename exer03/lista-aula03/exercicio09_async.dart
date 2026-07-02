// Exercício 9: Broadcast Stream (Intermediário)
// StreamController.broadcast() com 3 listeners diferentes (imprime,
// conta, soma). Emite 10 números.

import 'dart:async';

Future<void> main() async {
  final controller = StreamController<int>.broadcast();

  int contador = 0;
  int soma = 0;

  // Listener 1: imprime cada número recebido
  controller.stream.listen((numero) {
    print('[Impressor] Recebi: $numero');
  });

  // Listener 2: conta quantos números foram recebidos
  controller.stream.listen((numero) {
    contador++;
    print('[Contador] Total recebido até agora: $contador');
  });

  // Listener 3: soma todos os números recebidos
  controller.stream.listen((numero) {
    soma += numero;
    print('[Somador] Soma acumulada: $soma');
  });

  for (int i = 1; i <= 10; i++) {
    controller.sink.add(i);
    await Future.delayed(Duration(milliseconds: 200));
  }

  await controller.close();

  print('\nResultado final -> Contador: $contador | Soma: $soma');
}
