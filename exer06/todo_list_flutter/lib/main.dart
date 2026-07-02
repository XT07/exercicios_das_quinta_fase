import 'package:flutter/material.dart';
import 'models/tarefa.dart';
import 'widgets/tarefa_tile.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TelaTarefas(),
    );
  }
}

// Bônus: filtros de visualização
enum FiltroTarefas { todas, pendentes, concluidas }

class TelaTarefas extends StatefulWidget {
  const TelaTarefas({super.key});

  @override
  State<TelaTarefas> createState() => _TelaTarefasState();
}

class _TelaTarefasState extends State<TelaTarefas> {
  final List<Tarefa> _tarefas = [];
  final TextEditingController _controller = TextEditingController();
  FiltroTarefas _filtroAtual = FiltroTarefas.todas;

  @override
  void dispose() {
    // Boa prática: sempre liberar o controller ao destruir o widget.
    _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------
  // Operações sobre a lista de tarefas — todas passam por setState()
  // ---------------------------------------------------------------

  void _adicionarTarefa() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _tarefas.add(Tarefa(titulo: texto));
    });

    _controller.clear();
  }

  void _alternarConclusao(Tarefa tarefa, bool? valor) {
    setState(() {
      tarefa.concluida = valor ?? false;
    });
  }

  void _removerTarefa(Tarefa tarefa) {
    setState(() {
      _tarefas.remove(tarefa);
    });
  }

  // Bônus: editar o texto de uma tarefa existente
  Future<void> _editarTarefa(Tarefa tarefa) async {
    final editController = TextEditingController(text: tarefa.titulo);

    final novoTexto = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar tarefa'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, editController.text.trim()),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );

    if (novoTexto != null && novoTexto.isNotEmpty) {
      setState(() {
        tarefa.titulo = novoTexto;
      });
    }
  }

  // Bônus: limpar todas as tarefas concluídas
  void _limparConcluidas() {
    setState(() {
      _tarefas.removeWhere((tarefa) => tarefa.concluida);
    });
  }

  // Bônus: lista filtrada conforme o filtro selecionado
  List<Tarefa> get _tarefasFiltradas {
    switch (_filtroAtual) {
      case FiltroTarefas.pendentes:
        return _tarefas.where((t) => !t.concluida).toList();
      case FiltroTarefas.concluidas:
        return _tarefas.where((t) => t.concluida).toList();
      case FiltroTarefas.todas:
        return _tarefas;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = _tarefas.length;
    final concluidas = _tarefas.where((t) => t.concluida).length;
    final tarefasVisiveis = _tarefasFiltradas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [
          if (_tarefas.any((t) => t.concluida))
            IconButton(
              icon: const Icon(Icons.cleaning_services_outlined),
              tooltip: 'Limpar concluídas',
              onPressed: _limparConcluidas,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de entrada + botão adicionar
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite uma nova tarefa...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _adicionarTarefa(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _adicionarTarefa,
                  icon: const Icon(Icons.add),
                  tooltip: 'Adicionar tarefa',
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Bônus: contador de tarefas
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Total: $total | Concluídas: $concluidas | Pendentes: ${total - concluidas}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),
            const SizedBox(height: 8),

            // Bônus: filtros (Todas / Pendentes / Concluídas)
            SegmentedButton<FiltroTarefas>(
              segments: const [
                ButtonSegment(value: FiltroTarefas.todas, label: Text('Todas')),
                ButtonSegment(value: FiltroTarefas.pendentes, label: Text('Pendentes')),
                ButtonSegment(value: FiltroTarefas.concluidas, label: Text('Concluídas')),
              ],
              selected: {_filtroAtual},
              onSelectionChanged: (selecionado) {
                setState(() => _filtroAtual = selecionado.first);
              },
            ),
            const SizedBox(height: 12),

            // Lista de tarefas
            Expanded(
              child: tarefasVisiveis.isEmpty
                  ? Center(
                      child: Text(
                        _tarefas.isEmpty
                            ? 'Nenhuma tarefa cadastrada.\nAdicione a primeira acima! ✅'
                            : 'Nenhuma tarefa nesse filtro.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tarefasVisiveis.length,
                      itemBuilder: (context, index) {
                        final tarefa = tarefasVisiveis[index];
                        return TarefaTile(
                          tarefa: tarefa,
                          onToggle: (valor) => _alternarConclusao(tarefa, valor),
                          onDelete: () => _removerTarefa(tarefa),
                          onEdit: () => _editarTarefa(tarefa),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
