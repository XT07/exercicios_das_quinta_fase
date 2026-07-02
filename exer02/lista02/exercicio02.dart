// Exercício 2: const vs final na Prática (Básico)
// Crie 'pi' com const e 'dataAtual' com final. Tente reatribuir e
// documente o que acontece.

void main() {
  const pi = 3.14159;
  final dataAtual = DateTime.now();

  print('Valor de pi (const): $pi');
  print('Data atual (final): $dataAtual');

  // Tentativas de reatribuição (ambas dão erro de compilação se
  // descomentadas, pois const e final só podem ser atribuídos uma vez):
  //
  // pi = 3.14; // ERRO: Constant variables can't be assigned a value.
  // dataAtual = DateTime.now(); // ERRO: The final variable can only be set once.
  //
  // Diferença entre eles:
  // - const: o valor precisa ser conhecido em tempo de COMPILAÇÃO.
  //   Por isso 'const dataAtual = DateTime.now();' NÃO compilaria,
  //   já que DateTime.now() só é conhecido em tempo de EXECUÇÃO.
  // - final: o valor pode ser calculado em tempo de EXECUÇÃO, mas,
  //   uma vez atribuído, não pode mais ser alterado.

  print('\nObservação: const exige valor conhecido em tempo de compilação;');
  print('final permite valor calculado em runtime, mas ambos são imutáveis após a atribuição.');
}
