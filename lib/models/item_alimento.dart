class ItemAlimento {
  String nome;
  String quantidade; // ex: 1
  String gramas; // ex: 100g

  ItemAlimento({
    required this.nome,
    required this.quantidade,
    required this.gramas,
  });

  Map<String, dynamic> toJson() => {
    'nome': nome,
    'quantidade': quantidade,
    'gramas': gramas,
  };

  factory ItemAlimento.fromJson(Map<String, dynamic> json) => ItemAlimento(
    nome: json['nome'],
    quantidade: json['quantidade'],
    gramas: json['gramas'],
  );
}
