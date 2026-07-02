// Exercício 7: StreamController - Chat Simulado (Básico)
// Usa StreamController para simular um chat: 5 mensagens com
// intervalo de 1s, ouvidas com listen() e o controller é fechado
// ao final.

import 'dart:async';

Future<void> main() async {
  final controller = StreamController<String>();

  // Ouvinte do stream de mensagens
  controller.stream.listen(
    (mensagem) => print('💬 Nova mensagem: $mensagem'),
    onDone: () => print('Chat encerrado.'),
  );

  final mensagens = [
    'Oi, tudo bem?',
    'Tudo ótimo, e você?',
    'Também! Vamos treinar hoje?',
    'Bora! Que horas?',
    'Às 18h no ponto de sempre.',
  ];

  for (final msg in mensagens) {
    await Future.delayed(Duration(seconds: 1));
    controller.sink.add(msg);
  }

  await controller.close();
}
