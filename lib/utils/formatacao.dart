String formatarPreco(double valor) {
  final partes = valor.toStringAsFixed(2).split('.');
  final inteiro = partes[0].replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'R\$ $inteiro,${partes[1]}';
}

String formatarHorario(DateTime horario) {
  String doisDigitos(int valor) => valor.toString().padLeft(2, '0');
  return '${doisDigitos(horario.hour)}:${doisDigitos(horario.minute)}:'
      '${doisDigitos(horario.second)}';
}
