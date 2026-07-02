import 'package:flutter/material.dart';
import 'widgets/dashboard_card.dart';

void main() {
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Responsivo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F5FA),
        useMaterial3: true,
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // Breakpoints do projeto
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;

  // Dados dos 4 cards do dashboard (métricas fictícias de exemplo)
  List<DashboardCard> _buildCards() {
    return const [
      DashboardCard(
        titulo: 'Usuários Ativos',
        valor: '1.234',
        icone: Icons.people_alt_rounded,
        cor: Color(0xFF5C6BC0), // indigo
      ),
      DashboardCard(
        titulo: 'Receita Mensal',
        valor: 'R\$ 24.500',
        icone: Icons.attach_money_rounded,
        cor: Color(0xFF26A69A), // teal
      ),
      DashboardCard(
        titulo: 'Pedidos Hoje',
        valor: '87',
        icone: Icons.shopping_bag_rounded,
        cor: Color(0xFFFFA726), // laranja
      ),
      DashboardCard(
        titulo: 'Taxa de Conversão',
        valor: '3.8%',
        icone: Icons.trending_up_rounded,
        cor: Color(0xFFEF5350), // vermelho
      ),
    ];
  }

  /// Escolhe o layout de acordo com a largura da tela (breakpoints).
  Widget _buildResponsiveLayout(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cards = _buildCards();

    if (width < mobileBreakpoint) {
      // 📱 Mobile: 1 card por linha (vertical)
      return Column(
        children: cards
            .map((card) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: card,
                ))
            .toList(),
      );
    } else if (width < tabletBreakpoint) {
      // 💻 Tablet: grid 2x2 usando Wrap
      final larguraCard = (width - 48 - 12) / 2; // padding lateral + gap
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: cards
            .map((card) => SizedBox(width: larguraCard, child: card))
            .toList(),
      );
    } else {
      // 🖥️ Desktop: 4 cards na mesma linha, distribuídos com Expanded
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cards
            .map(
              (card) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: card,
                ),
              ),
            )
            .toList(),
      );
    }
  }

  /// Bônus: pequeno banner decorativo usando Stack + Positioned,
  /// só para dar um toque visual ao topo do dashboard.
  Widget _buildBanner(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < mobileBreakpoint;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: isMobile ? 90 : 120,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5C6BC0), Color(0xFF7E57C2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          right: -10,
          top: -20,
          child: Icon(
            Icons.dashboard_rounded,
            size: isMobile ? 100 : 140,
            color: Colors.white.withOpacity(0.15),
          ),
        ),
        Positioned(
          left: 20,
          top: isMobile ? 20 : 30,
          child: const Text(
            'Bem-vindo(a) de volta! 👋',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final String tipoDispositivo = width < mobileBreakpoint
        ? 'Mobile'
        : width < tabletBreakpoint
            ? 'Tablet'
            : 'Desktop';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Responsivo'),
        centerTitle: false,
        elevation: 0,
      ),
      // Bônus: menu drawer simples
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF5C6BC0)),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            const ListTile(leading: Icon(Icons.dashboard), title: Text('Dashboard')),
            const ListTile(leading: Icon(Icons.bar_chart), title: Text('Relatórios')),
            const ListTile(leading: Icon(Icons.settings), title: Text('Configurações')),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(context),
              const SizedBox(height: 20),
              Text(
                'Visão geral (layout: $tipoDispositivo)',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildResponsiveLayout(context),
            ],
          ),
        ),
      ),
    );
  }
}
