# Galeria de Receitas Fit — Atividade Aula 9

**Aluno(a):** _[seu nome aqui]_
**Turma:** 5ª Fase ADS — Desenvolvimento para Dispositivos Móveis | 2025/1
**Disciplina:** Faculdade Senac Joinville

## 📋 Sobre o projeto

Tema escolhido: **galeria de receitas fitness**, com grid de cards que leva a uma tela de
detalhes com informações nutricionais animadas. Demonstra os 5 requisitos obrigatórios da
atividade + o bônus de `CustomPainter`.

## ✅ Requisitos implementados

### 1. Animação Implícita
`ReceitaCard` (`widgets/receita_card.dart`) usa `AnimatedContainer` para dar um efeito de
"pressionar" no card (escala, sombra) sempre que o usuário toca — 200ms, `Curves.easeOut`.

### 2. Animação Explícita
Na tela de detalhes (`screens/detalhe_receita.dart`):
- `AnimationController` com `SingleTickerProviderStateMixin`
- `Tween<double>` e `Tween<Offset>` para fade + slide do conteúdo
- `CurvedAnimation` (`Curves.easeOutCubic`) para movimento natural
- `AnimatedBuilder` reconstruindo apenas o necessário
- `dispose()` do controller implementado corretamente
- O mesmo controller também anima o preenchimento do anel de progresso (CustomPainter)

### 3. Hero Animation
O ícone da receita (`CircleAvatar` com `Hero`) usa a mesma tag (`receita.id`) no card da
galeria e na tela de detalhes, criando a transição fluida entre as duas telas.

### 4. Material Design 3
`useMaterial3: true` + `ColorScheme.fromSeed(seedColor: Colors.teal)` no `ThemeData`, e uso
de `FilledButton.icon` (componente M3) na tela de detalhes.

### 5. Widget Customizado Reutilizável
`MacroBadge` (`widgets/macro_badge.dart`) — badge com ícone, rótulo e valor, parametrizável,
usado tanto no card da galeria (calorias) quanto na tela de detalhes (calorias, proteína,
carboidratos, gordura e tempo de preparo) — múltiplos usos, `const` sempre que possível.

## 🌟 Bônus: CustomPainter

`CircleProgressPainter` (`painters/circle_progress_painter.dart`) desenha um anel de
progresso circular via `Canvas.drawCircle` e `Canvas.drawArc`, representando o percentual da
meta calórica diária que a receita ocupa. Animado pelo mesmo `AnimationController` da tela de
detalhes. `shouldRepaint()` implementado comparando `progress`, `color` e `strokeWidth`.

## 🚀 Como executar

```bash
flutter pub get
flutter run
```

## 📸 Screenshots / GIF

> Adicione aqui screenshots ou um GIF demonstrando as animações (galeria, card sendo
> pressionado, transição Hero, tela de detalhes com o anel de progresso preenchendo).

## 📁 Estrutura do projeto

```
galeria_animacoes/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   └── receita.dart
│   ├── screens/
│   │   ├── galeria_receitas.dart     # Tela 1 (origem do Hero)
│   │   └── detalhe_receita.dart      # Tela 2 (destino do Hero + animação explícita)
│   ├── widgets/
│   │   ├── receita_card.dart         # Widget reutilizável + animação implícita
│   │   └── macro_badge.dart          # Widget reutilizável (badge nutricional)
│   └── painters/
│       └── circle_progress_painter.dart  # Bônus: CustomPainter
├── pubspec.yaml
└── README.md
```
