// Exercício 1: Declaração e Inferência de Tipos (Básico)
// Crie variáveis usando 'var' para armazenar: nome, idade, altura e
// se gosta de programar. Imprima todas com seus tipos (runtimeType).

void main() {
  var nome = 'Mestre';
  var idade = 25;
  var altura = 1.78;
  var gostaDeProgramar = true;

  print('Nome: $nome | Tipo: ${nome.runtimeType}');
  print('Idade: $idade | Tipo: ${idade.runtimeType}');
  print('Altura: $altura | Tipo: ${altura.runtimeType}');
  print('Gosta de programar: $gostaDeProgramar | Tipo: ${gostaDeProgramar.runtimeType}');
}
