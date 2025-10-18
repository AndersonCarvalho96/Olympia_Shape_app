import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/dieta.dart';
import '../models/refeicao.dart';
import 'dieta_refeicao.dart';

class DietaHome extends StatefulWidget {
  const DietaHome({super.key});

  @override
  State<DietaHome> createState() => _DietaHomeState();
}

class _DietaHomeState extends State<DietaHome> {
  Dieta planoAlimentar = Dieta(objetivo: '', observacoes: '');
  List<Refeicao> refeicoes = [];

  TextEditingController objetivoDietaController = TextEditingController();
  TextEditingController observacoesController = TextEditingController();
  TextEditingController novaRefeicaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPlanoAlimentar();
    _loadRefeicoes();
  }

  // ================= SharedPreferences =================
  Future<void> _loadPlanoAlimentar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      planoAlimentar.objetivo = prefs.getString('objetivoDieta') ?? '';
      planoAlimentar.observacoes = prefs.getString('observacoes') ?? '';
    });
  }

  Future<void> _savePlanoAlimentar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('objetivoDieta', planoAlimentar.objetivo);
    await prefs.setString('observacoes', planoAlimentar.observacoes);
  }

  Future<void> _loadRefeicoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? refeicoesJson = prefs.getStringList('refeicoes');
    if (refeicoesJson != null) {
      setState(() {
        refeicoes = refeicoesJson
            .map((r) => Refeicao.fromJson(jsonDecode(r)))
            .toList();
      });
    }
  }

  Future<void> _saveRefeicoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> refeicoesJson = refeicoes
        .map((r) => jsonEncode(r.toJson()))
        .toList();
    await prefs.setStringList('refeicoes', refeicoesJson);
  }

  void editarPlanoAlimentar() {
    objetivoDietaController.text = planoAlimentar.objetivo;
    observacoesController.text = planoAlimentar.observacoes;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar Plano Alimentar'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: objetivoDietaController,
                decoration: const InputDecoration(labelText: 'Objetivo'),
              ),
              TextField(
                controller: observacoesController,
                decoration: const InputDecoration(labelText: 'Observações'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                planoAlimentar.objetivo = objetivoDietaController.text;
                planoAlimentar.observacoes = observacoesController.text;
              });
              _savePlanoAlimentar();
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void adicionarRefeicao() {
    if (novaRefeicaoController.text.isEmpty) return;
    setState(() {
      refeicoes.add(Refeicao(nome: novaRefeicaoController.text, itens: []));
      novaRefeicaoController.clear();
    });
    _saveRefeicoes();
  }

  void atualizarRefeicao(Refeicao refeicao, int index) {
    setState(() {
      refeicoes[index] = refeicao;
    });
    _saveRefeicoes();
  }

  void excluirRefeicao(int index) {
    setState(() {
      refeicoes.removeAt(index);
    });
    _saveRefeicoes();
  }

  void confirmarExclusaoRefeicao(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Tem certeza que deseja excluir esta refeição?'),
        actions: [
          // Cancelar
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context),
          ),
          // Confirmar
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () {
              excluirRefeicao(index); // Executa a exclusão
              Navigator.pop(context); // Fecha o diálogo
            },
          ),
        ],
      ),
    );
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
                // ================= Card Plano Alimentar =================
                Card(
                  color: Colors.black87,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Plano Alimentar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: editarPlanoAlimentar,
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.redAccent),
                        Text(
                          'Objetivo: ${planoAlimentar.objetivo}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Observações: ${planoAlimentar.observacoes}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // ================= Adicionar Refeição =================
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: novaRefeicaoController,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'Adicionar nova refeição...',
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
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
                      onPressed: adicionarRefeicao,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // ================= Lista de Refeições =================
                Expanded(
                  child: ListView.builder(
                    itemCount: refeicoes.length,
                    itemBuilder: (context, index) {
                      final refeicao = refeicoes[index];
                      return DietaRefeicaoCard(
                        refeicao: refeicao,
                        atualizarRefeicao: (r) => atualizarRefeicao(r, index),
                        excluirRefeicao: () => confirmarExclusaoRefeicao(index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // ================= Botão flutuante voltar =================
          Positioned(
            top: 20,
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
                child: const Center(
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
