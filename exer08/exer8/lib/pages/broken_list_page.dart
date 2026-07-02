import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OptimizedListPage extends StatelessWidget {
  const OptimizedListPage({super.key});

  static const int itemCount = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista — ListView.builder + Cache')),
      // ListView.builder só constrói (e mantém em memória) os itens
      // visíveis + uma pequena margem, em vez dos 200 de uma vez
      // (Column + SingleChildScrollView renderizava tudo de cara).
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // CachedNetworkImage guarda a imagem em disco/memória:
                // ela só é baixada uma vez, mesmo que o item saia e volte
                // para a tela (scroll pra cima e pra baixo, por exemplo).
                //
                // memCacheWidth/Height força o decode em um tamanho
                // pequeno (compatível com o espaço exibido em tela),
                // evitando decodificar uma imagem 800x600 inteira
                // para um espaço de poucos cm.
                CachedNetworkImage(
                  imageUrl: 'https://picsum.photos/seed/$i/400/300',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  memCacheWidth: 400,
                  placeholder: (context, url) => const SizedBox(
                    height: 200,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 200,
                    child: Icon(Icons.broken_image),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Item $i'),
              ],
            ),
          );
        },
      ),
    );
  }
}
