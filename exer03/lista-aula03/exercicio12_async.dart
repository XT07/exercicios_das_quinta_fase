// Exercício 12: Projeto Integrador - Dashboard Assíncrono (Avançado)
// Integra: (1) autenticação (Future), (2) busca paralela de dados
// (Future.wait), (3) escuta de atualizações em tempo real (Stream),
// (4) null safety para dados opcionais, com tratamento de erros
// robusto em todas as etapas.

import 'dart:async';

// ---------------------------------------------------------------
// (1) Autenticação
// ---------------------------------------------------------------
Future<String> autenticarUsuario(String usuario, String senha) {
  return Future.delayed(Duration(seconds: 1), () {
    if (usuario.isEmpty || senha.isEmpty) {
      throw Exception('Usuário e senha são obrigatórios.');
    }
    return 'token-${usuario.hashCode}';
  });
}

// ---------------------------------------------------------------
// (2) Busca de dados em múltiplas fontes, em paralelo
// ---------------------------------------------------------------
Future<Map<String, dynamic>> buscarPerfil(String token) {
  return Future.delayed(Duration(seconds: 1), () => {
        'nome': 'Mestre',
        'plano': 'Premium',
      });
}

Future<List<String>> buscarNotificacoes(String token) {
  return Future.delayed(Duration(seconds: 2), () => [
        'Novo treino disponível',
        'Meta de proteína batida hoje!',
      ]);
}

Future<String?> buscarConfiguracaoTema(String token) {
  // Pode não existir configuração de tema para esse usuário (null safety)
  return Future.delayed(Duration(milliseconds: 800), () => null);
}

// ---------------------------------------------------------------
// (3) Stream de atualizações em tempo real
// ---------------------------------------------------------------
Stream<String> atualizacoesEmTempoReal() async* {
  final eventos = [
    'Novo pedido recebido',
    'Estoque atualizado',
    'Usuário conectado',
  ];
  for (final evento in eventos) {
    await Future.delayed(Duration(seconds: 1));
    yield evento;
  }
}

// ---------------------------------------------------------------
// Orquestração do dashboard
// ---------------------------------------------------------------
Future<void> carregarDashboard() async {
  try {
    // (1) Autenticação
    print('🔐 Autenticando...');
    final token = await autenticarUsuario('mestre', 'senha123');
    print('Autenticado com sucesso! Token: $token\n');

    // (2) Busca em paralelo, com tratamento de erro individual
    print('📡 Carregando dados do dashboard em paralelo...');
    final resultados = await Future.wait([
      buscarPerfil(token),
      buscarNotificacoes(token),
      buscarConfiguracaoTema(token),
    ]);

    final perfil = resultados[0] as Map<String, dynamic>;
    final notificacoes = resultados[1] as List<String>;
    final tema = resultados[2] as String?;

    print('Perfil: ${perfil['nome']} (${perfil['plano']})');
    print('Notificações: $notificacoes');
    // (4) Null safety: usa valor padrão caso o tema não esteja definido
    print('Tema: ${tema ?? "claro (padrão)"}\n');

    // (3) Escutando atualizações em tempo real
    print('🔴 Ouvindo atualizações em tempo real...');
    await for (final evento in atualizacoesEmTempoReal()) {
      print('Atualização: $evento');
    }

    print('\n✅ Dashboard carregado com sucesso!');
  } on Exception catch (e) {
    print('❌ Erro ao carregar dashboard: $e');
  } catch (e) {
    print('❌ Erro inesperado: $e');
  }
}

Future<void> main() async {
  await carregarDashboard();
}
