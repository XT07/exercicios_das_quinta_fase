// Exercício 6: Função de Alta Ordem (Avançado)
// 'executarOperacao' recebe dois números e uma função como parâmetro.

double executarOperacao(double a, double b, Function operacao) {
  return operacao(a, b);
}

double soma(double a, double b) => a + b;
double subtracao(double a, double b) => a - b;
double multiplicacao(double a, double b) => a * b;
double divisao(double a, double b) => a / b;

void main() {
  double x = 10;
  double y = 5;

  print('Soma: ${executarOperacao(x, y, soma)}');
  print('Subtração: ${executarOperacao(x, y, subtracao)}');
  print('Multiplicação: ${executarOperacao(x, y, multiplicacao)}');
  print('Divisão: ${executarOperacao(x, y, divisao)}');

  // Também é possível passar uma função anônima diretamente:
  print('Potência (função anônima): '
      '${executarOperacao(x, y, (a, b) => a * a)}');
}
