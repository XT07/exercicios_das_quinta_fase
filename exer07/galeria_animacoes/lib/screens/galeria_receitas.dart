import 'package:flutter/material.dart';
import '../models/receita.dart';
import '../widgets/receita_card.dart';
import 'detalhe_receita.dart';

/// Tela de origem da animação Hero: exibe a galeria de receitas em grid.
/// Cada [ReceitaCard] já traz sua própria animação implícita embutida.
class GaleriaReceitas extends StatelessWidget {
  const GaleriaReceitas({super.key});

  void _abrirDetalhes(BuildContext context, Receita receita) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheReceita(receita: receita),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galeria de Receitas Fit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: receitasMock.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final receita = receitasMock[index];
            return ReceitaCard(
              receita: receita,
              onTap: () => _abrirDetalhes(context, receita),
            );
          },
        ),
      ),
    );
  }
}
