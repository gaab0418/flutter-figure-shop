import 'package:flutter/widgets.dart';

class EventoCicloVida {
  const EventoCicloVida({
    required this.estado,
    required this.horario,
    this.inicial = false,
  });

  final AppLifecycleState estado;
  final DateTime horario;
  final bool inicial;
}

class RegistroCicloVida extends ChangeNotifier {
  RegistroCicloVida() {
    final estadoInicial = WidgetsBinding.instance.lifecycleState;
    if (estadoInicial != null) {
      _eventos.add(
        EventoCicloVida(
          estado: estadoInicial,
          horario: DateTime.now(),
          inicial: true,
        ),
      );
    }
    _listener = AppLifecycleListener(onStateChange: _registrar);
  }

  late final AppLifecycleListener _listener;
  final List<EventoCicloVida> _eventos = [];

  List<EventoCicloVida> get eventos => List.unmodifiable(_eventos);

  AppLifecycleState? get estadoAtual =>
      _eventos.isEmpty ? null : _eventos.last.estado;

  void _registrar(AppLifecycleState estado) {
    _eventos.add(EventoCicloVida(estado: estado, horario: DateTime.now()));
    debugPrint('Ciclo de vida: ${estado.name}');
    notifyListeners();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }
}
