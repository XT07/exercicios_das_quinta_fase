/// Modelo de dados que representa uma tarefa da lista.
class Tarefa {
  String titulo;
  bool concluida;

  Tarefa({
    required this.titulo,
    this.concluida = false,
  });
}
