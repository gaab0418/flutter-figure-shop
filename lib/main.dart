import 'package:flutter/material.dart';

import 'app.dart';
import 'services/registro_ciclo_vida.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final registro = RegistroCicloVida();
  runApp(FigureShopApp(registro: registro));
}
