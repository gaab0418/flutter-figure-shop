import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../services/registro_ciclo_vida.dart';
import '../utils/formatacao.dart';
import '../widgets/painel_ciclo_vida.dart';
import '../widgets/imagem_produto.dart';

class DetalhesScreen extends StatelessWidget {
  const DetalhesScreen({
    super.key,
    required this.produto,
    required this.registro,
  });

  static const limitesImagem = BoxConstraints(
    minWidth: 240,
    maxWidth: 520,
    minHeight: 240,
    maxHeight: 380,
  );

  final Produto produto;
  final RegistroCicloVida registro;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final cores = tema.colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      bottomNavigationBar: PainelCicloVida(registro: registro),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ImagemProduto(
                    produto: produto,
                    limites: limitesImagem,
                    raio: 16,
                  ),
                  const SizedBox(height: 20),
                  Text(produto.nome, style: tema.textTheme.headlineSmall),
                  const SizedBox(height: 4),
                  Text(
                    produto.linha,
                    style: tema.textTheme.titleSmall?.copyWith(
                      color: cores.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _Informacao(
                          icone: Icons.sell,
                          rotulo: 'Preço',
                          valor: formatarPreco(produto.preco),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _Informacao(
                          icone: Icons.inventory_2,
                          rotulo: 'Quantidade disponível',
                          valor: produto.esgotado
                              ? '0 (esgotado)'
                              : '${produto.quantidade} unidade'
                                    '${produto.quantidade == 1 ? '' : 's'}',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Descrição', style: tema.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(produto.descricao, style: tema.textTheme.bodyLarge),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar ao catálogo'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Informacao extends StatelessWidget {
  const _Informacao({
    required this.icone,
    required this.rotulo,
    required this.valor,
  });

  final IconData icone;
  final String rotulo;
  final String valor;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      elevation: 0,
      color: tema.colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, color: tema.colorScheme.onSecondaryContainer),
            const SizedBox(height: 6),
            Text(rotulo, style: tema.textTheme.labelMedium),
            Text(
              valor,
              style: tema.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
