import 'package:flutter/material.dart';
import '../models/receita.dart';
import 'macro_badge.dart';

/// WIDGET CUSTOMIZADO REUTILIZÁVEL
///
/// Card de receita usado na galeria (usado uma vez para CADA receita da
/// lista, ou seja, em múltiplos lugares). Contém:
/// - ANIMAÇÃO IMPLÍCITA: AnimatedContainer que "encolhe" levemente ao ser
///   pressionado, dando feedback tátil visual.
/// - Hero: o ícone da receita usa a mesma tag da tela de detalhes.
class ReceitaCard extends StatefulWidget {
  final Receita receita;
  final VoidCallback onTap;

  const ReceitaCard({
    super.key,
    required this.receita,
    required this.onTap,
  });

  @override
  State<ReceitaCard> createState() => _ReceitaCardState();
}

class _ReceitaCardState extends State<ReceitaCard> {
  bool _pressionado = false;

  @override
  Widget build(BuildContext context) {
    final receita = widget.receita;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressionado = true),
      onTapUp: (_) => setState(() => _pressionado = false),
      onTapCancel: () => setState(() => _pressionado = false),
      onTap: widget.onTap,
      // ANIMAÇÃO IMPLÍCITA: anima escala, sombra e cor de fundo
      // automaticamente sempre que _pressionado muda.
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_pressionado ? 0.96 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_pressionado ? 0.04 : 0.10),
              blurRadius: _pressionado ? 4 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: receita.id,
              child: CircleAvatar(
                radius: 26,
                backgroundColor: receita.cor.withOpacity(0.15),
                child: Icon(receita.icone, color: receita.cor, size: 28),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              receita.nome,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 8),
            MacroBadge(
              icone: Icons.local_fire_department_rounded,
              label: 'kcal',
              valor: '${receita.calorias}',
              cor: receita.cor,
            ),
          ],
        ),
      ),
    );
  }
}
