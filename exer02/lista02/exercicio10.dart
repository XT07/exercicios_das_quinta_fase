// Exercício 10: Set e Operações de Conjunto (Intermediário)
// A = {1,2,3,4,5}, B = {4,5,6,7,8}. União, interseção, diferença
// e verificação de pertencimento.

void main() {
  Set<int> a = {1, 2, 3, 4, 5};
  Set<int> b = {4, 5, 6, 7, 8};

  print('Conjunto A: $a');
  print('Conjunto B: $b');

  print('União (A ∪ B): ${a.union(b)}');
  print('Interseção (A ∩ B): ${a.intersection(b)}');
  print('Diferença (A - B): ${a.difference(b)}');

  print('O número 3 está em A? ${a.contains(3)}');
}
