// Exercício 8: Lista de Objetos e Filtros (Intermediário)
// Lista de frutas, filtra as que começam com 'M' (where) e cria
// nova lista em MAIÚSCULAS (map).

void main() {
  var frutas = ['maçã', 'banana', 'manga', 'uva', 'morango', 'melancia'];

  print('Lista original: $frutas');

  var comM = frutas.where((f) => f.toLowerCase().startsWith('m')).toList();
  print('Frutas que começam com "M": $comM');

  var maiusculas = frutas.map((f) => f.toUpperCase()).toList();
  print('Frutas em MAIÚSCULAS: $maiusculas');
}
