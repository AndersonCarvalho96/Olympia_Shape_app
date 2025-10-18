class Exercicio {
  String nome;
  String series;
  String repeticoes;
  String carga;
  String observacoes;

  Exercicio({
    required this.nome,
    required this.series,
    required this.repeticoes,
    required this.carga,
    required this.observacoes,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'series': series,
    'repeticoes': repeticoes,
    'carga': carga,
    'observacoes': observacoes,
  };

  factory Exercicio.fromJson(Map<String, dynamic> json) => Exercicio(
    nome: json['nome'],
    series: json['series'],
    repeticoes: json['repeticoes'],
    carga: json['carga'],
    observacoes: json['observacoes'],
  );
}
