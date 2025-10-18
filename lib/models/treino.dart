import 'exercicio.dart';

class Treino {
  String nome;
  List<Exercicio> exercicios;

  Treino({required this.nome, required this.exercicios});

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'exercicios': exercicios.map((e) => e.toJson()).toList(),
  };

  factory Treino.fromJson(Map<String, dynamic> json) => Treino(
    nome: json['nome'],
    exercicios: (json['exercicios'] as List)
        .map((e) => Exercicio.fromJson(e))
        .toList(),
  );
}
