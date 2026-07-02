import 'package:flutter/material.dart';
import 'screens/lista_produtos.dart';

void main() {
  runApp(const AppProdutos());
}

class AppProdutos extends StatelessWidget {
  const AppProdutos({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Cadastro de Produtos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ListaProdutos(),
    );
  }
}
