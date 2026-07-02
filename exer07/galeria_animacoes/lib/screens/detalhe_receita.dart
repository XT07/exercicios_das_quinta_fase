import 'package:flutter/material.dart';
import '../models/receita.dart';
import '../painters/circle_progress_painter.dart';
import '../widgets/macro_badge.dart';

/// Tela de destino da animação Hero. Também demonstra:
/// - ANIMAÇÃO EXPLÍCITA: AnimationController + CurvedAnimation +
///   AnimatedBuilder controlando um fade/slide do conteúdo e o
///   preenchimento do anel de progresso (CustomPainter).
class DetalheReceita extends StatefulWidget {
  final Receita receita;

  const DetalheReceita({super.key, required this.receita});

  @override
  State<DetalheReceita> createState() => _DetalheReceitaState();
}

class _DetalheReceitaState extends State<DetalheReceita>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _progressoAnelAnimation;

  bool _favoritado = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    final curva = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curva);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curva);

    // O anel de progresso "enche" do zero até o percentual real da receita.
    _progressoAnelAnimation = Tween<double>(
      begin: 0,
      end: widget.receita.percentualMeta,
    ).animate(curva);

    _controller.forward();
  }

  @override
  void dispose() {
    // Sempre liberar o AnimationController!
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receita = widget.receita;

    return Scaffold(
      appBar: AppBar(
        title: Text(receita.nome),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Hero: mesma tag do card na galeria
            Hero(
              tag: receita.id,
              child: CircleAvatar(
                radius: 56,
                backgroundColor: receita.cor.withOpacity(0.15),
                child: Icon(receita.icone, color: receita.cor, size: 56),
              ),
            ),
            const SizedBox(height: 24),

            // ANIMAÇÃO EXPLÍCITA: conteúdo abaixo aparece com fade + slide
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Transform.translate(
                    offset: Offset(
                      0,
                      _slideAnimation.value.dy * 100,
                    ),
                    child: child,
                  ),
                );
              },
              child: Column(
                children: [
                  Text(
                    receita.nome,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    receita.descricao,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Badges com informações nutricionais (widget reutilizável)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      MacroBadge(
                        icone: Icons.local_fire_department_rounded,
                        label: 'kcal',
                        valor: '${receita.calorias}',
                        cor: receita.cor,
                      ),
                      MacroBadge(
                        icone: Icons.fitness_center_rounded,
                        label: 'g proteína',
                        valor: receita.proteina.toStringAsFixed(0),
                        cor: receita.cor,
                      ),
                      MacroBadge(
                        icone: Icons.grain_rounded,
                        label: 'g carbo',
                        valor: receita.carboidratos.toStringAsFixed(0),
                        cor: receita.cor,
                      ),
                      MacroBadge(
                        icone: Icons.opacity_rounded,
                        label: 'g gordura',
                        valor: receita.gordura.toStringAsFixed(0),
                        cor: receita.cor,
                      ),
                      MacroBadge(
                        icone: Icons.timer_outlined,
                        label: 'min',
                        valor: '${receita.tempoPreparoMin}',
                        cor: receita.cor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // BÔNUS: CustomPainter — anel de progresso animado pelo
            // mesmo AnimationController (percentual da meta calórica).
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(140, 140),
                        painter: CircleProgressPainter(
                          progress: _progressoAnelAnimation.value,
                          color: receita.cor,
                        ),
                      ),
                      Text(
                        '${(_progressoAnelAnimation.value * 100).toStringAsFixed(0)}%',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: receita.cor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'da sua meta calórica diária',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 32),

            // Componente Material 3: FilledButton
            FilledButton.icon(
              onPressed: () {
                setState(() => _favoritado = !_favoritado);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      _favoritado
                          ? 'Receita adicionada aos favoritos!'
                          : 'Receita removida dos favoritos.',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
                child: Icon(
                  _favoritado ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  key: ValueKey(_favoritado),
                ),
              ),
              label: Text(_favoritado ? 'Favoritada' : 'Adicionar aos favoritos'),
            ),
          ],
        ),
      ),
    );
  }
}
