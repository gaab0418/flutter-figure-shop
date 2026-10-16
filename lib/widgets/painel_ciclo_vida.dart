import 'package:flutter/material.dart';

import '../services/registro_ciclo_vida.dart';
import '../utils/formatacao.dart';

class PainelCicloVida extends StatefulWidget {
  const PainelCicloVida({super.key, required this.registro});

  final RegistroCicloVida registro;

  @override
  State<PainelCicloVida> createState() => _PainelCicloVidaState();
}

class _PainelCicloVidaState extends State<PainelCicloVida> {
  bool _expandido = false;

  static IconData _icone(AppLifecycleState estado) => switch (estado) {
    AppLifecycleState.resumed => Icons.play_circle,
    AppLifecycleState.inactive => Icons.pause_circle_outline,
    AppLifecycleState.hidden => Icons.visibility_off,
    AppLifecycleState.paused => Icons.pause_circle,
    AppLifecycleState.detached => Icons.power_settings_new,
  };

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Material(
      color: cores.surfaceContainer,
      elevation: 6,
      child: SafeArea(
        top: false,
        child: ListenableBuilder(
          listenable: widget.registro,
          builder: (context, _) {
            final eventos = widget.registro.eventos;
            final atual = widget.registro.estadoAtual?.name ?? 'aguardando';
            final alturaMaxima = _expandido
                ? MediaQuery.sizeOf(context).height * 0.5
                : 112.0;

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => setState(() => _expandido = !_expandido),
                    child: Row(
                      children: [
                        Icon(
                          _expandido ? Icons.expand_more : Icons.expand_less,
                          size: 20,
                          color: cores.primary,
                        ),
                        const SizedBox(width: 4),
                        Icon(Icons.history, size: 20, color: cores.primary),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Ciclo de vida (${eventos.length})',
                            style: tema.textTheme.titleSmall,
                          ),
                        ),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text('Atual: $atual'),
                        ),
                      ],
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: alturaMaxima),
                    child: eventos.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Nenhum estado recebido ainda.',
                              style: tema.textTheme.bodySmall,
                            ),
                          )
                        : ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            itemCount: eventos.length,
                            itemBuilder: (context, indice) {
                              final posicao = eventos.length - 1 - indice;
                              final evento = eventos[posicao];
                              return ListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  _icone(evento.estado),
                                  color: cores.primary,
                                ),
                                title: Text(
                                  '${posicao + 1}. ${evento.estado.name}'
                                  '${evento.inicial ? ' (estado inicial)' : ''}',
                                ),
                                trailing: Text(
                                  formatarHorario(evento.horario),
                                  style: tema.textTheme.bodySmall,
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
