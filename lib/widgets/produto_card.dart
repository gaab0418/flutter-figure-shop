import 'package:flutter/material.dart';

import '../models/produto.dart';
import '../utils/formatacao.dart';
import 'imagem_produto.dart';

class ProdutoCard extends StatelessWidget {
  const ProdutoCard({
    super.key,
    required this.produto,
    required this.onDetalhes,
  });

  static const limitesImagem = BoxConstraints(
    minWidth: 140,
    maxWidth: 260,
    minHeight: 160,
    maxHeight: 200,
  );

  final Produto produto;
  final VoidCallback onDetalhes;

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImagemProduto(produto: produto, limites: limitesImagem),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nome,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: tema.textTheme.titleSmall,
                  ),
                  const Spacer(),
                  Text(
                    formatarPreco(produto.preco),
                    style: tema.textTheme.titleMedium?.copyWith(
                      color: tema.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: FilledButton.tonalIcon(
              onPressed: onDetalhes,
              icon: const Icon(Icons.visibility, size: 18),
              label: const Text('Detalhes'),
            ),
          ),
        ],
      ),
    );
  }
}
