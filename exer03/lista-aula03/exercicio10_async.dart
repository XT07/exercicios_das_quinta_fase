// Exercício 10: Stream de Eventos do Usuário (Avançado)
// Emite eventos aleatórios a cada 500ms e implementa debounce manual
// (só processa o evento após 1s de inatividade), usando Timer.

import 'dart:async';
import 'dart:math';

final _tiposDeEvento = ['clique', 'scroll', 'input'];
final _random = Random();

// Emite um evento de usuário aleatório a cada 500ms, num total de 8 eventos.
Stream<String> eventosDoUsuario() async* {
  for (int i = 0; i < 8; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    final tipo = _tiposDeEvento[_random.nextInt(_tiposDeEvento.length)];
    yield '$tipo #$i';
  }
}

Future<void> main() async {
  Timer? debounceTimer;

  print('Escutando eventos do usuário (debounce de 1s)...\n');

  final completer = Completer<void>();

  final subscription = eventosDoUsuario().listen(
    (evento) {
      print('Evento recebido: $evento (aguardando inatividade...)');

      // Cancela o timer anterior a cada novo evento — só o ÚLTIMO evento
      // dentro da janela de inatividade será realmente processado.
      debounceTimer?.cancel();
      debounceTimer = Timer(Duration(seconds: 1), () {
        print('✅ Processando evento (debounce): $evento');
      });
    },
    onDone: () {
      // Espera o último debounce terminar antes de finalizar
      Future.delayed(Duration(seconds: 1), () {
        print('\nStream de eventos finalizado.');
        completer.complete();
      });
    },
  );

  await completer.future;
  await subscription.cancel();
}
