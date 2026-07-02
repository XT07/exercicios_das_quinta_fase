import 'package:flutter/material.dart';
import '../models/produto.dart';
import 'cadastro_produto.dart';
import 'detalhe_produto.dart';

/// TELA 1: Lista de Produtos
///
/// Exibe os produtos cadastrados, permite navegar para o cadastro (FAB)
/// e para os detalhes de um produto (ao tocar em um item da lista).
class ListaProdutos extends StatefulWidget {
  const ListaProdutos({super.key});

  @override
  State<ListaProdutos> createState() => _ListaProdutosState();
}

class _ListaProdutosState extends State<ListaProdutos> {
  final List<Produto> produtos = [];

  /// Navega para a Tela 2 (Cadastro) e aguarda o retorno de um novo produto.
  Future<void> _abrirCadastro() async {
    final produto = await Navigator.push<Produto>(
      context,
      MaterialPageRoute(builder: (context) => const CadastroProduto()),
    );

    if (produto != null) {
      setState(() => produtos.add(produto));
    }
  }

  /// Navega para a Tela 3 (Detalhes) e trata o retorno (ex: exclusão).
  Future<void> _abrirDetalhes(int index) async {
    final resultado = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheProduto(produto: produtos[index]),
      ),
    );

    // Bônus: se a Tela 3 sinalizar exclusão, remove o produto da lista.
    if (resultado == 'deletar') {
      setState(() => produtos.removeAt(index));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Produtos'),
      ),
      body: produtos.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 72, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Nenhum produto cadastrado ainda.\nToque no botão "+" para adicionar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.shopping_bag_outlined),
                    ),
                    title: Text(produto.nome),
                    subtitle: Text(produto.precoFormatado),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => _abrirDetalhes(index),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirCadastro,
        tooltip: 'Cadastrar produto',
        child: const Icon(Icons.add),
      ),
    );
  }
}
