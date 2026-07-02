// ============================================================
// LISTA 1 - Exercícios de Dart
// ============================================================

// ------------------------------------------------------------
// Exercício 1: Criar classe Produto com atributos e métodos
// ------------------------------------------------------------
class Produto {
  String nome;
  double preco;
  int quantidade;

  Produto(this.nome, this.preco, this.quantidade);

  double calcularValorTotal() {
    return preco * quantidade;
  }

  void aplicarDesconto(double percentual) {
    preco -= preco * (percentual / 100);
  }

  @override
  String toString() {
    return 'Produto: $nome | Preço: R\$${preco.toStringAsFixed(2)} | '
        'Qtd: $quantidade | Total: R\$${calcularValorTotal().toStringAsFixed(2)}';
  }
}

void exercicio1() {
  print('--- Exercício 1: Classe Produto ---');
  var produto = Produto('Notebook', 3000.0, 2);
  print(produto);

  produto.aplicarDesconto(10); // 10% de desconto
  print('Após desconto de 10%:');
  print(produto);
  print('');
}

// ------------------------------------------------------------
// Exercício 2: Implementar lista de compras usando List
// ------------------------------------------------------------
class ListaDeCompras {
  List<String> itens = [];

  void adicionarItem(String item) {
    itens.add(item);
  }

  void removerItem(String item) {
    itens.remove(item);
  }

  void listarItens() {
    if (itens.isEmpty) {
      print('Lista de compras vazia.');
      return;
    }
    for (var i = 0; i < itens.length; i++) {
      print('${i + 1}. ${itens[i]}');
    }
  }

  int get totalItens => itens.length;
}

void exercicio2() {
  print('--- Exercício 2: Lista de Compras ---');
  var lista = ListaDeCompras();
  lista.adicionarItem('Arroz');
  lista.adicionarItem('Feijão');
  lista.adicionarItem('Ovos');
  lista.adicionarItem('Whey Protein');

  print('Itens na lista:');
  lista.listarItens();

  lista.removerItem('Ovos');
  print('\nApós remover "Ovos":');
  lista.listarItens();

  print('Total de itens: ${lista.totalItens}');
  print('');
}

// ------------------------------------------------------------
// Exercício 3: Map de clientes com ID e nome
// ------------------------------------------------------------
void exercicio3() {
  print('--- Exercício 3: Map de Clientes ---');

  Map<int, String> clientes = {
    1: 'Ana Silva',
    2: 'Bruno Costa',
    3: 'Carla Dias',
  };

  // Adicionando um novo cliente
  clientes[4] = 'Diego Souza';

  // Listando todos os clientes
  print('Lista de clientes:');
  clientes.forEach((id, nome) {
    print('ID: $id -> Nome: $nome');
  });

  // Buscando um cliente pelo ID
  int idBusca = 2;
  if (clientes.containsKey(idBusca)) {
    print('\nCliente encontrado (ID $idBusca): ${clientes[idBusca]}');
  }

  // Removendo um cliente
  clientes.remove(3);
  print('\nApós remover o cliente de ID 3:');
  clientes.forEach((id, nome) {
    print('ID: $id -> Nome: $nome');
  });
  print('');
}

// ------------------------------------------------------------
// Exercício 4: Herança - ContaBancaria e ContaPoupanca
// ------------------------------------------------------------
class ContaBancaria {
  String titular;
  double saldo;

  ContaBancaria(this.titular, this.saldo);

  void depositar(double valor) {
    saldo += valor;
    print('Depósito de R\$${valor.toStringAsFixed(2)} realizado.');
  }

  void sacar(double valor) {
    if (valor > saldo) {
      print('Saldo insuficiente para saque de R\$${valor.toStringAsFixed(2)}.');
    } else {
      saldo -= valor;
      print('Saque de R\$${valor.toStringAsFixed(2)} realizado.');
    }
  }

  void exibirSaldo() {
    print('Titular: $titular | Saldo: R\$${saldo.toStringAsFixed(2)}');
  }
}

class ContaPoupanca extends ContaBancaria {
  double taxaRendimento; // em porcentagem

  ContaPoupanca(String titular, double saldo, this.taxaRendimento)
      : super(titular, saldo);

  void renderizar() {
    double rendimento = saldo * (taxaRendimento / 100);
    saldo += rendimento;
    print('Rendimento de R\$${rendimento.toStringAsFixed(2)} aplicado '
        '(taxa de $taxaRendimento%).');
  }

  @override
  void exibirSaldo() {
    print('[Poupança] Titular: $titular | Saldo: R\$${saldo.toStringAsFixed(2)}');
  }
}

void exercicio4() {
  print('--- Exercício 4: Herança (ContaBancaria / ContaPoupanca) ---');

  var contaComum = ContaBancaria('Mestre', 1000.0);
  contaComum.depositar(500);
  contaComum.sacar(200);
  contaComum.exibirSaldo();

  print('');

  var poupanca = ContaPoupanca('Mestre', 2000.0, 5.0);
  poupanca.depositar(300);
  poupanca.renderizar();
  poupanca.exibirSaldo();
  print('');
}

// ------------------------------------------------------------
// Exercício 5: Mixin para adicionar funcionalidade de log
// ------------------------------------------------------------
mixin Log {
  void registrarLog(String mensagem) {
    var agora = DateTime.now();
    print('[LOG ${agora.toIso8601String()}] $mensagem');
  }
}

class Servico with Log {
  String nome;

  Servico(this.nome);

  void executar() {
    registrarLog('Serviço "$nome" iniciado.');
    // ... lógica do serviço ...
    registrarLog('Serviço "$nome" finalizado com sucesso.');
  }
}

void exercicio5() {
  print('--- Exercício 5: Mixin de Log ---');
  var servico = Servico('Processamento de Pedido');
  servico.executar();
  print('');
}

// ------------------------------------------------------------
// MAIN - executa todos os exercícios em sequência
// ------------------------------------------------------------
void main() {
  exercicio1();
  exercicio2();
  exercicio3();
  exercicio4();
  exercicio5();
}
