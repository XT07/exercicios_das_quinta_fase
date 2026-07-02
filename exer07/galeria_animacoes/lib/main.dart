import 'package:flutter/material.dart';
import 'screens/galeria_receitas.dart';

void main() {
  runApp(const GaleriaAnimacoesApp());
}

class GaleriaAnimacoesApp extends StatelessWidget {
  const GaleriaAnimacoesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galeria de Receitas Fit',
      debugShowCheckedModeBanner: false,
      // MATERIAL DESIGN 3
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const GaleriaReceitas(),
    );
  }
}
