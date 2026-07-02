# To-Do List — Atividade Aula 7

**Aluno(a):** _[seu nome aqui]_
**Turma:** 5ª Fase ADS — Desenvolvimento para Dispositivos Móveis | 2026/1
**Disciplina:** Faculdade Senac Joinville

## 📋 Sobre o projeto

App Flutter de lista de tarefas praticando `StatefulWidget`, `setState()` e manipulação
dinâmica de uma `List<Tarefa>`.

## ✅ Funcionalidades implementadas

- Adicionar tarefas via `TextField` + `TextEditingController` (limpa o campo após adicionar)
- Listar tarefas com `ListView.builder`, com mensagem para lista vazia
- Marcar/desmarcar como concluída via `Checkbox`, com texto riscado (`TextDecoration.lineThrough`)
- Remover tarefa pelo ícone de lixeira
- Classe `Tarefa` (`titulo`, `concluida`) em arquivo separado (`models/tarefa.dart`)
- `setState()` chamado em todas as operações que alteram a lista
- `dispose()` implementado para liberar o `TextEditingController`
- `Scaffold` + `AppBar` como estrutura básica

## ⭐ Bônus implementados

- Contador de tarefas (total / concluídas / pendentes)
- Filtros: Todas / Pendentes / Concluídas (`SegmentedButton`)
- Botão para limpar todas as tarefas concluídas de uma vez
- Editar o texto de uma tarefa existente (toque longo no item)
- Cores diferentes para tarefas pendentes (indigo) e concluídas (verde)

## 🚀 Como executar

```bash
flutter pub get
flutter run
```

## 📸 Screenshots

> Adicione aqui os screenshots pedidos (lista vazia, com tarefas, tarefas concluídas):

| Lista vazia | Com tarefas | Tarefas concluídas |
|---|---|---|
| _(screenshot)_ | _(screenshot)_ | _(screenshot)_ |

## 📁 Estrutura do projeto

```
todo_list_flutter/
├── lib/
│   ├── main.dart               # Tela principal, estado e lógica
│   ├── models/
│   │   └── tarefa.dart         # Classe Tarefa
│   └── widgets/
│       └── tarefa_tile.dart    # Widget reutilizável de item da lista
├── pubspec.yaml
└── README.md
```
