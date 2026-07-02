import 'dart:math' as math;
import 'package:flutter/material.dart';

/// BÔNUS: CustomPainter que desenha um anel de progresso circular,
/// usado para representar o percentual da meta calórica diária que
/// a receita representa.
class CircleProgressPainter extends CustomPainter {
  final double progress; // 0.0 a 1.0
  final Color color;
  final double strokeWidth;

  CircleProgressPainter({
    required this.progress,
    required this.color,
    this.strokeWidth = 8,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (math.min(size.width, size.height) - strokeWidth) / 2;

    // Trilha de fundo (anel completo, cor suave)
    final trilhaPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trilhaPaint);

    // Arco de progresso
    final progressoPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const anguloInicial = -math.pi / 2; // começa no topo (12h)
    final anguloVarredura = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      anguloInicial,
      anguloVarredura,
      false,
      progressoPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CircleProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
