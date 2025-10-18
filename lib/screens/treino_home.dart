import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/treino.dart';
import 'treino_detalhe.dart';

class TreinoHome extends StatefulWidget {
  const TreinoHome({super.key});

  @override
  State<TreinoHome> createState() => _TreinoHomeState();
}

class _TreinoHomeState extends State<TreinoHome> {
  List<Treino> treinos = [];

  String objetivo = '';
  String divisao = '';
  String tempo = '';
  String observacao = '';

  TextEditingController objetivoController = TextEditingController();
  TextEditingController divisaoController = TextEditingController();
  TextEditingController tempoController = TextEditingController();
  TextEditingController observacaoController = TextEditingController();
  TextEditingController novoTreinoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCampos();
    _loadTreinos();
  }

  // ================= SharedPreferences para campos gerais =================
  Future<void> _loadCampos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      objetivo = prefs.getString('objetivo') ?? '';
      divisao = prefs.getString('divisao') ?? '';
      tempo = prefs.getString('tempo') ?? '';
      observacao = prefs.getString('observacao') ?? '';
    });
  }

  Future<void> _saveCampos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('objetivo', objetivoController.text);
    await prefs.setString('divisao', divisaoController.text);
    await prefs.setString('tempo', tempoController.text);
    await prefs.setString('observacao', observacaoController.text);

    setState(() {
      objetivo = objetivoController.text;
      divisao = divisaoController.text;
      tempo = tempoController.text;
      observacao = observacaoController.text;
    });
  }

  void editarCampos() {
    objetivoController.text = objetivo;
    divisaoController.text = divisao;
    tempoController.text = tempo;
    observacaoController.text = observacao;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar informações do treino'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: objetivoController,
                decoration: const InputDecoration(labelText: 'Objetivo'),
              ),
              TextField(
                controller: divisaoController,
                decoration: const InputDecoration(labelText: 'Divisão'),
              ),
              TextField(
                controller: tempoController,
                decoration: const InputDecoration(labelText: 'Tempo médio'),
              ),
              TextField(
                controller: observacaoController,
                decoration: const InputDecoration(labelText: 'Observações'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _saveCampos();
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  // ================= SharedPreferences para lista de treinos =================
  Future<void> _saveTreinos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> treinosJson = treinos
        .map((t) => jsonEncode(t.toJson()))
        .toList();
    await prefs.setStringList('treinos', treinosJson);
  }

  Future<void> _loadTreinos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? treinosJson = prefs.getStringList('treinos');
    if (treinosJson != null) {
      setState(() {
        treinos = treinosJson
            .map((t) => Treino.fromJson(jsonDecode(t)))
            .toList();
      });
    }
  }

  void adicionarTreino() {
    if (novoTreinoController.text.isEmpty) return;
    setState(() {
      treinos.add(Treino(nome: novoTreinoController.text, exercicios: []));
      novoTreinoController.clear();
    });
    _saveTreinos();
  }

  void excluirTreino(int index) {
    setState(() {
      treinos.removeAt(index);
    });
    _saveTreinos();
  }

  void atualizarTreino(Treino treino, int index) {
    setState(() {
      treinos[index] = treino;
    });
    _saveTreinos();
  }

  void editarNomeTreino(Treino treino, int index) {
    final controller = TextEditingController(text: treino.nome);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar nome do treino'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Nome do treino'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                treino.nome = controller.text;
              });
              atualizarTreino(treino, index);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    ).then((_) => controller.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/silhueta.jpg', fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Olympia Shape',
                      style: TextStyle(
                        fontFamily: 'BBHSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 36,
                        height: 1.5,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: Colors.black87,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Informações do treino',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: editarCampos,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.redAccent),
                        Text(
                          'Objetivo: $objetivo',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Divisão: $divisao',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Tempo médio: $tempo',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Observações: $observacao',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: novoTreinoController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText:
                              'Digite o treino. Ex: Treino A, Treino de Costas...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      onPressed: adicionarTreino,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: treinos.length,
                    itemBuilder: (context, index) {
                      final treino = treinos[index];
                      return Card(
                        color: Colors.black87,
                        child: ListTile(
                          title: Text(
                            treino.nome,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () =>
                                    editarNomeTreino(treino, index),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () => excluirTreino(index),
                              ),
                            ],
                          ),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TreinoDetalhePage(
                                treino: treino,
                                index: index,
                                atualizarTreino: atualizarTreino,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Botão flutuante para voltar
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context); // volta para a tela inicial
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.redAccent,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
