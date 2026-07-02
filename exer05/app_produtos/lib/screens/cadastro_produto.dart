import 'package:flutter/material.dart';
import '../models/produto.dart';

/// TELA 2: Formulário de Cadastro
///
/// Recebe nome, preço, descrição e (opcional) imagem, valida os campos
/// e retorna um objeto [Produto] para a tela anterior via Navigator.pop().
class CadastroProduto extends StatefulWidget {
  const CadastroProduto({super.key});

  @override
  State<CadastroProduto> createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _descricaoController.dispose();
    _imagemController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final precoTexto = _precoController.text.replaceAll(',', '.');
    final produto = Produto(
      nome: _nomeController.text.trim(),
      preco: double.parse(precoTexto),
      descricao: _descricaoController.text.trim(),
      imagemUrl: _imagemController.text.trim(),
    );

    // Retorna o produto criado para a Tela 1
    Navigator.pop(context, produto);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Produto',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'O nome do produto não pode ser vazio.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _precoController,
                decoration: const InputDecoration(
                  labelText: 'Preço (ex: 29,90)',
                  prefixText: 'R\$ ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'O preço não pode ser vazio.';
                  }
                  final precoConvertido = double.tryParse(valor.replaceAll(',', '.'));
                  if (precoConvertido == null || precoConvertido <= 0) {
                    return 'Informe um preço válido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imagemController,
                decoration: const InputDecoration(
                  labelText: 'URL da imagem (opcional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _salvar,
                icon: const Icon(Icons.save),
                label: const Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
