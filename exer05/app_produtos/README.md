# App de Cadastro de Produtos — Atividade Aula 8

**Aluno(a):** _[seu nome aqui]_
**Turma:** 5ª Fase ADS — Desenvolvimento para Dispositivos Móveis | 2026/1
**Disciplina:** Faculdade Senac Joinville

## 📋 Sobre o projeto

App Flutter com 3 telas que praticam navegação (`Navigator`), passagem de dados entre telas
e retorno de dados via `pop()`.

## 🧭 Fluxo de navegação

```
Tela 1 (Lista de Produtos)
   │
   ├── FAB "+"  ──push──>  Tela 2 (Cadastro)
   │                            │
   │        <──pop(produto)─────┘   (retorna o Produto criado)
   │
   └── toque no item  ──push──>  Tela 3 (Detalhes)
                                     │
                <──pop('deletar')───┘   (opcional: sinaliza exclusão)
```

- **Lista → Cadastro → Lista:** ao salvar no formulário, `Navigator.pop(context, produto)` devolve
  o objeto `Produto` para a Tela 1, que usa `await Navigator.push(...)` e `setState` para
  adicioná-lo à lista.
- **Lista → Detalhes → Lista:** a Tela 1 passa o `Produto` direto no construtor da Tela 3. Se o
  usuário excluir o produto lá, a Tela 3 retorna a string `'deletar'`, e a Tela 1 remove o item.

## ✅ Requisitos técnicos implementados

- Classe `Produto` em `models/produto.dart`
- 3 telas em `screens/`: `lista_produtos.dart`, `cadastro_produto.dart`, `detalhe_produto.dart`
- `Navigator.push()` / `Navigator.pop()` com `await` para receber retorno
- `StatefulWidget` na Tela 1 (`List<Produto>` armazenado em estado)
- Todas as telas com `AppBar`
- Validação básica de campos vazios no formulário (via `Form` + `TextFormField`)

## ⭐ Bônus implementados

- Campo de imagem (URL) no `Produto`, com placeholder caso a URL falhe ou esteja vazia
- Botão de excluir produto na Tela 3 (com diálogo de confirmação)
- Formatação de preço no padrão `R$ 0,00`

## 🚀 Como executar

```bash
flutter pub get
flutter run
```

## 📸 Screenshots

> Adicione aqui os screenshots das 3 telas:

| Lista de Produtos | Cadastro | Detalhes |
|---|---|---|
| _(screenshot)_ | _(screenshot)_ | _(screenshot)_ |

## 📁 Estrutura do projeto

```
app_produtos/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── produto.dart
│   └── screens/
│       ├── lista_produtos.dart
│       ├── cadastro_produto.dart
│       └── detalhe_produto.dart
├── pubspec.yaml
└── README.md
```
