// Exercício 3: Conversão de Tipos (Intermediário)
// Crie uma String '42', converta para int e double. Crie um int 100
// e converta para String. Mostre os tipos antes e depois.

void main() {
  String numeroTexto = '42';
  print('Antes: numeroTexto = $numeroTexto | Tipo: ${numeroTexto.runtimeType}');

  int numeroInt = int.parse(numeroTexto);
  print('Depois (int): numeroInt = $numeroInt | Tipo: ${numeroInt.runtimeType}');

  double numeroDouble = double.parse(numeroTexto);
  print('Depois (double): numeroDouble = $numeroDouble | Tipo: ${numeroDouble.runtimeType}');

  print('');

  int valorInt = 100;
  print('Antes: valorInt = $valorInt | Tipo: ${valorInt.runtimeType}');

  String valorString = valorInt.toString();
  print('Depois (String): valorString = $valorString | Tipo: ${valorString.runtimeType}');
}
