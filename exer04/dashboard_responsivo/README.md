# Dashboard Responsivo — Atividade Aula 6

**Aluno(a):** _[seu nome aqui]_
**Turma:** 5ª Fase ADS — Desenvolvimento para Dispositivos Móveis | 2026/1
**Disciplina:** Faculdade Senac Joinville

## 📋 Sobre o projeto

Dashboard em Flutter que se adapta a 3 breakpoints de largura de tela, exibindo 4 cards de
métricas usando um widget reutilizável (`DashboardCard`).

| Dispositivo | Largura | Layout |
|---|---|---|
| 📱 Mobile | < 600px | `Column` — 1 card por linha |
| 💻 Tablet | 600–900px | `Wrap` — 2 cards por linha (grid 2x2) |
| 🖥️ Desktop | > 900px | `Row` com `Expanded` — 4 cards lado a lado |

## ✅ Requisitos técnicos implementados

- `MediaQuery.of(context).size.width` para detectar a largura da tela
- Lógica condicional (`if/else`) para escolher o layout
- `Expanded` (desktop) e dimensionamento via `Wrap`/`SizedBox` (tablet) para distribuir espaço
- Widget reutilizável `DashboardCard` (título, valor, ícone, cor)
- `AppBar` com título do dashboard e `Scaffold` como estrutura principal

## ⭐ Bônus implementados

- Banner decorativo no topo usando `Stack` + `Positioned`
- `Drawer` (menu lateral) simples

## 🚀 Como executar

```bash
flutter pub get
flutter run
```

Para testar os breakpoints:
- **Desktop:** redimensione a janela do app (ou rode com `flutter run -d chrome` e ajuste a largura do navegador)
- **Mobile/Tablet:** use o emulador/dispositivo físico, ou o plugin **Device Preview**

## 📸 Screenshots

> Adicione aqui os 3 screenshots pedidos na atividade (mobile, tablet, desktop):

| Mobile | Tablet | Desktop |
|---|---|---|
| _(screenshot)_ | _(screenshot)_ | _(screenshot)_ |

## 📁 Estrutura do projeto

```
dashboard_responsivo/
├── lib/
│   ├── main.dart                 # Tela principal + lógica responsiva
│   └── widgets/
│       └── dashboard_card.dart   # Widget reutilizável do card
├── pubspec.yaml
└── README.md
```
