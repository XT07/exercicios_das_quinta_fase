import 'package:flutter/material.dart';

import '../models/endereco.dart';
import '../services/api_exceptions.dart';
import '../services/api_service.dart';

class CepScreen extends StatefulWidget {
  const CepScreen({super.key});

  @override
  State<CepScreen> createState() => _CepScreenState();
}

class _CepScreenState extends State<CepScreen> {
  final _cepController = TextEditingController();
  final _apiService = ApiService();

  bool _carregando = false;
  String? _mensagemErro;
  Endereco? _endereco;

  Future<void> _buscarCep() async {
    final cep = _cepController.text.trim().replaceAll('-', '');

    // Validação local: 8 dígitos numéricos, antes de qualquer requisição.
    if (!ApiService.cepValido(cep)) {
      setState(() {
        _mensagemErro = 'CEP inválido. Digite exatamente 8 dígitos numéricos.';
        _endereco = null;
      });
      return;
    }

    setState(() {
      _carregando = true;
      _mensagemErro = null;
      _endereco = null;
    });

    try {
      final endereco = await _apiService.buscarCep(cep);
      setState(() {
        _endereco = endereco;
      });
    } on ApiException catch (e) {
      setState(() {
        _mensagemErro = e.message;
      });
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  void dispose() {
    _cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            'Consulta de CEP (ViaCEP)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _cepController,
            keyboardType: TextInputType.number,
            maxLength: 9,
            decoration: const InputDecoration(
              labelText: 'CEP',
              hintText: 'Ex: 01310930',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _buscarCep(),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _carregando ? null : _buscarCep,
            icon: const Icon(Icons.search),
            label: const Text('Buscar CEP'),
          ),
          const SizedBox(height: 24),
          if (_carregando) const Center(child: CircularProgressIndicator()),
          if (!_carregando && _mensagemErro != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                border: Border.all(color: Colors.red),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _mensagemErro!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          if (!_carregando && _endereco != null) _EnderecoCard(endereco: _endereco!),
        ],
      ),
    );
  }
}

class _EnderecoCard extends StatelessWidget {
  final Endereco endereco;

  const _EnderecoCard({required this.endereco});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _campo('CEP', endereco.cep),
            _campo('Logradouro', endereco.logradouro),
            _campo('Bairro', endereco.bairro),
            _campo('Cidade', endereco.localidade),
            _campo('UF', endereco.uf),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(child: Text(valor.isEmpty ? '-' : valor)),
        ],
      ),
    );
  }
}
