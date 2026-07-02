import 'package:flutter/material.dart';
import 'pages/broken_list_page.dart';
import 'pages/broken_grid_page.dart';

void main() {
  runApp(const MyApp());
}

// Antes era StatefulWidget com um "counter" que não era usado em nenhum
// lugar da UI. Cada tap no FAB disparava setState() e reconstruía a
// árvore inteira (AppBar, ListTile, tudo) à toa.
// Como não há estado real para gerenciar aqui, a tela vira StatelessWidget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tema sóbrio: sem fontSize 20 forçado no body inteiro nem
      // primarySwatch berrante — deixa o Material padrão fazer o trabalho.
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Versão Otimizada')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Lista otimizada (ListView.builder)'),
            // Antes: onTap chamava runApp(BrokenListPage()) de novo,
            // o que reinicia o app inteiro em vez de navegar para a tela.
            // Correto é usar Navigator.push.
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OptimizedListPage()),
            ),
          ),
          ListTile(
            title: const Text('Grid otimizado (GridView.builder)'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OptimizedGridPage()),
            ),
          ),
        ],
      ),
    );
  }
}
