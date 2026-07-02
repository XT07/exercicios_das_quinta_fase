// Exercício 7: Manipulação de Listas (Básico)
// Lista de 1 a 10, adiciona 11, remove o 5, mostra tamanho,
// primeiro, último elemento e usa forEach para imprimir tudo.

void main() {
  List<int> numeros = List.generate(10, (i) => i + 1); // [1..10]
  print('Lista inicial: $numeros');

  numeros.add(11);
  print('Após adicionar 11: $numeros');

  numeros.remove(5);
  print('Após remover o 5: $numeros');

  print('Tamanho da lista: ${numeros.length}');
  print('Primeiro elemento: ${numeros.first}');
  print('Último elemento: ${numeros.last}');

  print('\nImprimindo todos os elementos com forEach:');
  numeros.forEach((n) => print('- $n'));
}
