// Exercício 15: Mixins em Ação (Avançado)
// Mixins Voador, Nadador e Corredor. Pato (nada e voa),
// Golfinho (nada) e Avestruz (corre).

mixin Voador {
  void voar() => print('Voando...');
}

mixin Nadador {
  void nadar() => print('Nadando...');
}

mixin Corredor {
  void correr() => print('Correndo...');
}

class Pato with Nadador, Voador {
  String nome;
  Pato(this.nome);
}

class Golfinho with Nadador {
  String nome;
  Golfinho(this.nome);
}

class Avestruz with Corredor {
  String nome;
  Avestruz(this.nome);
}

void main() {
  var pato = Pato('Donald');
  print('${pato.nome}:');
  pato.nadar();
  pato.voar();

  print('');

  var golfinho = Golfinho('Flipper');
  print('${golfinho.nome}:');
  golfinho.nadar();

  print('');

  var avestruz = Avestruz('Zazu');
  print('${avestruz.nome}:');
  avestruz.correr();
}
