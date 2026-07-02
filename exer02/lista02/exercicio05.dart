// Exercício 5: Parâmetros Nomeados e Opcionais (Intermediário)
// Função 'saudar' com nome obrigatório, titulo opcional (padrão 'Sr.')
// e mostrarHora opcional (padrão false).

String saudar({
  required String nome,
  String titulo = 'Sr.',
  bool mostrarHora = false,
}) {
  String saudacao = 'Olá, $titulo $nome!';

  if (mostrarHora) {
    var agora = DateTime.now();
    String hora = agora.hour.toString().padLeft(2, '0');
    String minuto = agora.minute.toString().padLeft(2, '0');
    saudacao += ' Agora são $hora:$minuto.';
  }

  return saudacao;
}

void main() {
  print(saudar(nome: 'João'));
  print(saudar(nome: 'Maria', titulo: 'Dra.'));
  print(saudar(nome: 'Carlos', titulo: 'Sr.', mostrarHora: true));
}
