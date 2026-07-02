import 'package:flutter/material.dart';
import '../models/tarefa.dart';

/// Widget que exibe uma [Tarefa] com checkbox, texto (riscado se concluída)
/// e botão de excluir. Toque longo abre a edição do texto (bônus).
class TarefaTile extends StatelessWidget {
  final Tarefa tarefa;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TarefaTile({
    super.key,
    required this.tarefa,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    // Cores diferentes para tarefas pendentes e concluídas (bônus)
    final corFundo = tarefa.concluida
        ? Colors.green.withOpacity(0.08)
        : Colors.indigo.withOpacity(0.05);

    return Card(
      color: corFundo,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onLongPress: onEdit, // Bônus: editar texto da tarefa
        leading: Checkbox(
          value: tarefa.concluida,
          onChanged: onToggle,
        ),
        title: Text(
          tarefa.titulo,
          style: TextStyle(
            decoration: tarefa.concluida ? TextDecoration.lineThrough : null,
            color: tarefa.concluida ? Colors.grey : Colors.black87,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          tooltip: 'Excluir tarefa',
          onPressed: onDelete,
        ),
      ),
    );
  }
}
