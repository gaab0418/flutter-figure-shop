import 'package:flutter/material.dart';

import '../services/registro_ciclo_vida.dart';
import '../widgets/painel_ciclo_vida.dart';

class TransformacoesScreen extends StatefulWidget {
  const TransformacoesScreen({super.key, required this.registro});

  final RegistroCicloVida registro;

  @override
  State<TransformacoesScreen> createState() => _TransformacoesScreenState();
}

class _TransformacoesScreenState extends State<TransformacoesScreen> {
  final List<int> _numeros = [1, 2, 3, 4, 5];
  final List<String> _palavras = ['Flutter', 'é', 'incrível'];
  final List<String> _nomes = ['Coco', 'Agott', 'Tetia', 'Richeh', 'Qifrey'];

  late final List<String> _numerosEmTexto = _numeros
      .map((numero) => 'Nº $numero')
      .toList();
  late final List<int> _numerosDobrados = _numeros
      .map((numero) => numero * 2)
      .toList();

  String? _ultimoNome;

  void _aoClicarNome(String nome) {
    setState(() => _ultimoNome = nome);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Você clicou em $nome!')));
  }

  List<Widget> _chips(List<String> valores) =>
      valores.map((valor) => Chip(label: Text(valor))).toList();

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    final widgetsPalavras = _palavras
        .map(
          (palavra) => Text(
            palavra,
            style: tema.textTheme.headlineMedium?.copyWith(
              color: tema.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
        .toList();

    final botoesNomes = _nomes
        .map(
          (nome) => FilledButton.tonal(
            onPressed: () => _aoClicarNome(nome),
            child: Text(nome),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Transformações')),
      bottomNavigationBar: PainelCicloVida(registro: widget.registro),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _Secao(
              titulo: 'Números',
              children: [
                _ResultadoLista(
                  rotulo: 'Lista original (List<int>)',
                  codigo: '[1, 2, 3, 4, 5]',
                  itens: _chips(_numeros.map((n) => '$n').toList()),
                ),
                _ResultadoLista(
                  rotulo: 'Convertida em strings (List<String>)',
                  codigo: "numeros.map((numero) => 'Nº \$numero').toList()",
                  itens: _chips(
                    _numerosEmTexto.map((texto) => '"$texto"').toList(),
                  ),
                ),
                _ResultadoLista(
                  rotulo: 'Multiplicada por 2 (List<int>)',
                  codigo: 'numeros.map((numero) => numero * 2).toList()',
                  itens: _chips(_numerosDobrados.map((n) => '$n').toList()),
                ),
              ],
            ),
            _Secao(
              titulo: 'Palavras em widgets Text',
              children: [
                Text(
                  "['Flutter', 'é', 'incrível'] → List<Text>",
                  style: tema.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 12, runSpacing: 4, children: widgetsPalavras),
              ],
            ),
            _Secao(
              titulo: 'Nomes em botões',
              children: [
                Text(
                  _ultimoNome == null
                      ? 'Toque em um nome.'
                      : 'Último clique: $_ultimoNome',
                  style: tema.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: botoesNomes),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao({required this.titulo, required this.children});

  final String titulo;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titulo, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ResultadoLista extends StatelessWidget {
  const _ResultadoLista({
    required this.rotulo,
    required this.codigo,
    required this.itens,
  });

  final String rotulo;
  final String codigo;
  final List<Widget> itens;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(rotulo, style: tema.textTheme.titleSmall),
          Text(
            codigo,
            style: tema.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: tema.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 6),
          Wrap(spacing: 6, runSpacing: 6, children: itens),
        ],
      ),
    );
  }
}
