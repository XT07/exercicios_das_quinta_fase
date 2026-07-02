import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OptimizedGridPage extends StatelessWidget {
  const OptimizedGridPage({super.key});

  static const int itemCount = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grid — GridView.builder + Cache')),
      // GridView.builder, assim como ListView.builder, constrói os
      // itens sob demanda. GridView.count(children: [...200 widgets])
      // montava a lista inteira de widgets antes mesmo de rolar a tela.
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: itemCount,
        itemBuilder: (context, i) {
          return Container(
            margin: const EdgeInsets.all(8),
            color: Colors.blueAccent,
            child: Column(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/$i/300/300',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // Célula do grid é pequena: pedir e decodificar
                    // 300x300 em vez de 800x600 evita gasto de memória
                    // e tempo de decode desnecessários.
                    memCacheWidth: 300,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
                Text('Item $i'),
              ],
            ),
          );
        },
      ),
    );
  }
}
