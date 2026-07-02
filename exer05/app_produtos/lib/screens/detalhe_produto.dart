import 'package:flutter/material.dart';
import '../models/produto.dart';

/// TELA 3: Detalhes do Produto
///
/// Recebe um [Produto] via construtor e exibe suas informações de forma
/// visual. Possui botão de exclusão (bônus) que retorna 'deletar' para
/// a Tela 1 remover o item da lista.
class DetalheProduto extends StatelessWidget {
  final Produto produto;

  const DetalheProduto({super.key, required this.produto});

  Future<void> _confirmarExclusao(BuildContext context) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir produto'),
        content: Text('Deseja realmente excluir "${produto.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmar == true && context.mounted) {
      // Sinaliza para a Tela 1 que este produto deve ser removido.
      Navigator.pop(context, 'deletar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Excluir produto',
            onPressed: () => _confirmarExclusao(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagem do produto (ou placeholder, caso não tenha URL)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: produto.imagemUrl.isNotEmpty
                      ? Image.network(
                          produto.imagemUrl,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildPlaceholder(),
                        )
                      : _buildPlaceholder(),
                ),
                const SizedBox(height: 20),
                Text(
                  produto.nome,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  produto.precoFormatado,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 16),
                if (produto.descricao.isNotEmpty) ...[
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    produto.descricao,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ] else
                  const Text(
                    'Sem descrição cadastrada.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 180,
      width: double.infinity,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image_outlined, size: 64, color: Colors.grey),
    );
  }
}
