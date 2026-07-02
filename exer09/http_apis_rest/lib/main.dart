import 'package:flutter/material.dart';

import 'screens/cep_screen.dart';
import 'screens/pokemon_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP & APIs REST',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Consumo de APIs REST'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.location_on), text: 'CEP'),
              Tab(icon: Icon(Icons.catching_pokemon), text: 'Pokémon'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CepScreen(),
            PokemonScreen(),
          ],
        ),
      ),
    );
  }
}
