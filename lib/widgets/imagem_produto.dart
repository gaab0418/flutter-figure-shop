import 'package:flutter/material.dart';

import '../models/produto.dart';

class ImagemProduto extends StatelessWidget {
  const ImagemProduto({
    super.key,
    required this.produto,
    required this.limites,
    this.raio = 0,
  });

  final Produto produto;
  final BoxConstraints limites;
  final double raio;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: limites,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(raio),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: produto.nome,
                child: Image.asset(
                  produto.imagem,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IndicadorQuantidade(quantidade: produto.quantidade),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IndicadorQuantidade extends StatelessWidget {
  const IndicadorQuantidade({super.key, required this.quantidade});

  final int quantidade;

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final esgotado = quantidade == 0;
    final fundo = esgotado ? cores.error : cores.primary;
    final texto = esgotado ? cores.onError : cores.onPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            esgotado ? Icons.block : Icons.inventory_2,
            size: 14,
            color: texto,
          ),
          const SizedBox(width: 4),
          Text(
            esgotado ? 'Esgotado' : '$quantidade un.',
            style: TextStyle(
              color: texto,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
