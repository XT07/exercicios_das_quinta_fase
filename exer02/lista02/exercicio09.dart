// Exercício 9: Map de Produtos (Intermediário)
// Map<int, String> de produtos com funções para buscar, listar e
// remover por ID.

Map<int, String> produtos = {
  1: 'Notebook',
  2: 'Mouse',
  3: 'Teclado',
  4: 'Monitor',
  5: 'Headset',
};

String? buscarProduto(int id) {
  if (produtos.containsKey(id)) {
    return produtos[id];
  }
  return null;
}

void listarProdutos() {
  print('Lista de produtos:');
  produtos.forEach((id, nome) {
    print('ID: $id -> $nome');
  });
}

void removerProduto(int id) {
  if (produtos.containsKey(id)) {
    produtos.remove(id);
    print('Produto de ID $id removido.');
  } else {
    print('Produto de ID $id não encontrado.');
  }
}

void main() {
  listarProdutos();

  print('\nBuscando produto de ID 3: ${buscarProduto(3)}');
  print('Buscando produto de ID 10: ${buscarProduto(10)}');

  print('');
  removerProduto(2);

  print('\nLista após remoção:');
  listarProdutos();
}
