import 'package:flutter/material.dart';

/// Modelo de dados de uma receita exibida na galeria.
class Receita {
  final String id; // usado como tag única do Hero
  final String nome;
  final String descricao;
  final IconData icone;
  final Color cor;
  final int calorias;
  final double proteina; // gramas
  final double carboidratos; // gramas
  final double gordura; // gramas
  final int tempoPreparoMin;
  final double percentualMeta; // % da meta calórica do dia (0.0 a 1.0)

  const Receita({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.icone,
    required this.cor,
    required this.calorias,
    required this.proteina,
    required this.carboidratos,
    required this.gordura,
    required this.tempoPreparoMin,
    required this.percentualMeta,
  });
}

/// Lista fixa de receitas de exemplo para popular a galeria.
final List<Receita> receitasMock = [
  const Receita(
    id: 'receita-tamagoyaki',
    nome: 'Tamagoyaki Proteico',
    descricao:
        'Omelete japonesa enrolada, leve e rica em proteína. Ótima opção '
        'pós-treino, combina bem com arroz (gohan) e um shoyu leve.',
    icone: Icons.egg_alt_rounded,
    cor: Color(0xFFFFA726),
    calorias: 220,
    proteina: 18,
    carboidratos: 4,
    gordura: 14,
    tempoPreparoMin: 15,
    percentualMeta: 0.18,
  ),
  const Receita(
    id: 'receita-whey-panqueca',
    nome: 'Panqueca de Whey',
    descricao:
        'Panqueca fit feita com whey protein, aveia e banana. Rápida de '
        'preparar e ótima fonte de proteína para o café da manhã.',
    icone: Icons.local_dining_rounded,
    cor: Color(0xFF66BB6A),
    calorias: 310,
    proteina: 28,
    carboidratos: 32,
    gordura: 8,
    tempoPreparoMin: 10,
    percentualMeta: 0.24,
  ),
  const Receita(
    id: 'receita-frango-gohan',
    nome: 'Frango com Gohan',
    descricao:
        'Frango grelhado com arroz japonês (gohan) e legumes salteados. '
        'Prato completo, equilibrado entre proteína e carboidrato.',
    icone: Icons.rice_bowl_rounded,
    cor: Color(0xFF42A5F5),
    calorias: 480,
    proteina: 40,
    carboidratos: 52,
    gordura: 10,
    tempoPreparoMin: 30,
    percentualMeta: 0.38,
  ),
  const Receita(
    id: 'receita-shake-nao-whey',
    nome: 'Shake Proteico (sem whey)',
    descricao:
        'Shake proteico à base de iogurte grego, pasta de amendoim e '
        'cacau — ótima alternativa para quem evita whey.',
    icone: Icons.local_bar_rounded,
    cor: Color(0xFFAB47BC),
    calorias: 260,
    proteina: 22,
    carboidratos: 18,
    gordura: 11,
    tempoPreparoMin: 5,
    percentualMeta: 0.20,
  ),
];
