import 'package:flutter/material.dart';

import '../data/produtos_iniciais.dart';
import '../models/produto.dart';
import '../services/registro_ciclo_vida.dart';
import '../widgets/painel_ciclo_vida.dart';
import '../widgets/produto_card.dart';
import 'detalhes_screen.dart';
import 'transformacoes_screen.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key, required this.registro});

  final RegistroCicloVida registro;

  void _abrirDetalhes(BuildContext context, Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => DetalhesScreen(produto: produto, registro: registro),
      ),
    );
  }

  void _abrirTransformacoes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => TransformacoesScreen(registro: registro),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    final cards = produtosIniciais
        .map(
          (produto) => ProdutoCard(
            produto: produto,
            onDetalhes: () => _abrirDetalhes(context, produto),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Figure Shop'),
        actions: [
          IconButton(
            tooltip: 'Transformações',
            icon: const Icon(Icons.auto_awesome),
            onPressed: () => _abrirTransformacoes(context),
          ),
        ],
      ),
      bottomNavigationBar: PainelCicloVida(registro: registro),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  '${produtosIniciais.length} itens no catálogo',
                  style: tema.textTheme.titleMedium,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 240,
                  mainAxisExtent: 330,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                ),
                delegate: SliverChildListDelegate(cards),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
