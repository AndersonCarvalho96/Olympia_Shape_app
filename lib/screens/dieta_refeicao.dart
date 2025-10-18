import 'package:flutter/material.dart';
import '../models/refeicao.dart';
import '../models/item_alimento.dart';

class DietaRefeicaoCard extends StatefulWidget {
  final Refeicao refeicao;
  final Function(Refeicao) atualizarRefeicao;
  final VoidCallback excluirRefeicao;

  const DietaRefeicaoCard({
    super.key,
    required this.refeicao,
    required this.atualizarRefeicao,
    required this.excluirRefeicao,
  });

  @override
  State<DietaRefeicaoCard> createState() => _DietaRefeicaoCardState();
}

class _DietaRefeicaoCardState extends State<DietaRefeicaoCard> {
  TextEditingController nomeController = TextEditingController();

  void adicionarItem() {
    TextEditingController itemController = TextEditingController();
    TextEditingController qtdController = TextEditingController();
    TextEditingController gController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Adicionar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: itemController, decoration: const InputDecoration(labelText: 'Item')),
            TextField(controller: qtdController, decoration: const InputDecoration(labelText: 'Quantidade')),
            TextField(controller: gController, decoration: const InputDecoration(labelText: 'Gramas')),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (itemController.text.isEmpty) return;
              setState(() {
                widget.refeicao.itens.add(ItemAlimento(
                  nome: itemController.text,
                  quantidade: qtdController.text,
                  gramas: gController.text,
                ));
              });
              widget.atualizarRefeicao(widget.refeicao);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void editarRefeicao() {
    nomeController.text = widget.refeicao.nome;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Refeição'),
        content: TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome da Refeição')),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                widget.refeicao.nome = nomeController.text;
              });
              widget.atualizarRefeicao(widget.refeicao);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void editarItem(ItemAlimento item) {
    TextEditingController itemController = TextEditingController(text: item.nome);
    TextEditingController qtdController = TextEditingController(text: item.quantidade);
    TextEditingController gController = TextEditingController(text: item.gramas);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: itemController, decoration: const InputDecoration(labelText: 'Item')),
            TextField(controller: qtdController, decoration: const InputDecoration(labelText: 'Quantidade')),
            TextField(controller: gController, decoration: const InputDecoration(labelText: 'Gramas')),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                item.nome = itemController.text;
                item.quantidade = qtdController.text;
                item.gramas = gController.text;
              });
              widget.atualizarRefeicao(widget.refeicao);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void excluirItem(int index) {
    setState(() {
      widget.refeicao.itens.removeAt(index);
    });
    widget.atualizarRefeicao(widget.refeicao);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black87,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.refeicao.nome, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.redAccent), onPressed: editarRefeicao),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: widget.excluirRefeicao),
                  ],
                ),
              ],
            ),
            const Divider(color: Colors.redAccent),
            ...widget.refeicao.itens.asMap().entries.map((entry) {
              int index = entry.key;
              ItemAlimento item = entry.value;
              String quantidade = item.quantidade.isEmpty ? '' : '${item.quantidade} ';
              String gramas = item.gramas.isEmpty ? '' : '${item.gramas}g';
              String text = [quantidade, gramas, item.nome].where((s) => s.isNotEmpty).join(' ');
              return ListTile(
                title: Text(text, style: const TextStyle(color: Colors.white)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit, color: Colors.redAccent), onPressed: () => editarItem(item)),
                    IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => excluirItem(index)),
                  ],
                ),
              );
            }),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Adicionar Item'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: adicionarItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
