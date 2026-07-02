// Exercício 4: Função Tradicional e Arrow Function (Básico)
// Duas versões de função que calculam área de retângulo.

double calcularArea(double largura, double altura) {
  return largura * altura;
}

double calcularAreaArrow(double l, double h) => l * h;

void main() {
  double largura = 5;
  double altura = 10;

  print('Área (função tradicional): ${calcularArea(largura, altura)}');
  print('Área (arrow function): ${calcularAreaArrow(largura, altura)}');
}
