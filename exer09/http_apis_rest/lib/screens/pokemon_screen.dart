import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import '../services/api_exceptions.dart';
import '../services/api_service.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final _nomeController = TextEditingController();
  final _apiService = ApiService();

  bool _carregando = false;
  String? _mensagemErro;
  Pokemon? _pokemon;

  Future<void> _buscarPokemon() async {
    final nome = _nomeController.text.trim();

    if (nome.isEmpty) {
      setState(() {
        _mensagemErro = 'Digite o nome de um Pokémon.';
        _pokemon = null;
      });
      return;
    }

    setState(() {
      _carregando = true;
      _mensagemErro = null;
      _pokemon = null;
    });

    try {
      final pokemon = await _apiService.buscarPokemon(nome);
      setState(() {
        _pokemon = pokemon;
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
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text(
            'Consulta de Pokémon (PokeAPI)',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome do Pokémon',
              hintText: 'Ex: pikachu',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => _buscarPokemon(),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: _carregando ? null : _buscarPokemon,
            icon: const Icon(Icons.search),
            label: const Text('Buscar Pokémon'),
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
          if (!_carregando && _pokemon != null) _PokemonCard(pokemon: _pokemon!),
        ],
      ),
    );
  }
}

class _PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonCard({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (pokemon.imagemUrl.isNotEmpty)
              Image.network(
                pokemon.imagemUrl,
                height: 120,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported, size: 80),
              ),
            const SizedBox(height: 8),
            Text(
              '#${pokemon.id} ${pokemon.nome[0].toUpperCase()}${pokemon.nome.substring(1)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Altura: ${pokemon.alturaMetros} m'),
            Text('Peso: ${pokemon.pesoQuilos} kg'),
            Text('Tipo(s): ${pokemon.tipos.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
