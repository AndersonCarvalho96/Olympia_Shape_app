import 'item_alimento.dart';

class Refeicao {
  String nome;
  List<ItemAlimento> itens;

  Refeicao({required this.nome, required this.itens});

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'itens': itens.map((i) => i.toJson()).toList(),
  };

  factory Refeicao.fromJson(Map<String, dynamic> json) => Refeicao(
    nome: json['nome'] ?? '',
    itens:
        (json['itens'] as List<dynamic>?)
            ?.map((i) => ItemAlimento.fromJson(i))
            .toList() ??
        [],
  );
}
