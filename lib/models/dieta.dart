class Dieta {
  String objetivo;
  String observacoes;

  Dieta({required this.objetivo, required this.observacoes});

  Map<String, dynamic> toJson() => {
    'objetivo': objetivo,
    'observacoes': observacoes,
  };

  factory Dieta.fromJson(Map<String, dynamic> json) => Dieta(
    objetivo: json['objetivo'] ?? '',
    observacoes: json['observacoes'] ?? '',
  );
}
