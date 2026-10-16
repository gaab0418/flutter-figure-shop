import 'package:flutter/material.dart';

import 'screens/catalogo_screen.dart';
import 'services/registro_ciclo_vida.dart';

class FigureShopApp extends StatelessWidget {
  const FigureShopApp({super.key, required this.registro});

  final RegistroCicloVida registro;

  @override
  Widget build(BuildContext context) {
    final cores = ColorScheme.fromSeed(seedColor: Colors.blue);

    return MaterialApp(
      title: 'Figure Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: cores,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: cores.primary,
          foregroundColor: cores.onPrimary,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: CatalogoScreen(registro: registro),
    );
  }
}
