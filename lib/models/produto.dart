class Produto {
  const Produto({
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.quantidade,
    required this.linha,
    required this.imagem,
  });

  final String nome;
  final String descricao;
  final double preco;
  final int quantidade;
  final String linha;
  final String imagem;

  bool get esgotado => quantidade == 0;
}
