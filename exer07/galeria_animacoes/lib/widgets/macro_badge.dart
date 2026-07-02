import 'package:flutter/material.dart';

/// WIDGET CUSTOMIZADO REUTILIZÁVEL
///
/// Pequeno "badge" que exibe um ícone, um rótulo e um valor — usado para
/// mostrar informações nutricionais (calorias, proteína, carboidratos...).
/// Recebe parâmetros e é usado em múltiplos lugares (card da galeria e
/// tela de detalhes), sempre com [const] quando possível.
class MacroBadge extends StatelessWidget {
  final IconData icone;
  final String label;
  final String valor;
  final Color cor;

  const MacroBadge({
    super.key,
    required this.icone,
    required this.label,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 14, color: cor),
          const SizedBox(width: 4),
          Text(
            '$valor $label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: cor,
            ),
          ),
        ],
      ),
    );
  }
}
