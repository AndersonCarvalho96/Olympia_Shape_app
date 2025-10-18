import 'package:flutter/material.dart';
import '../models/treino.dart';
import '../models/exercicio.dart';

class TreinoDetalhePage extends StatefulWidget {
  final Treino treino;
  final int index;
  final Function(Treino, int) atualizarTreino;

  const TreinoDetalhePage({
    super.key,
    required this.treino,
    required this.index,
    required this.atualizarTreino,
  });

  @override
  State<TreinoDetalhePage> createState() => _TreinoDetalhePageState();
}

class _TreinoDetalhePageState extends State<TreinoDetalhePage> {
  Map<String, List<String>> bdExercicios = {
    'Peito': [
      'Supino reto com barra',
      'Supino reto com halteres',
      'Supino inclinado com barra',
      'Supino inclinado com halteres',
      'Supino declinado com barra',
      'Supino declinado com halteres',
      'Crucifixo reto com halteres',
      'Crucifixo inclinado com halteres',
      'Crucifixo declinado com halteres',
      'Crossover no cabo',
      'Flexão de braço',
      'Flexão pegada aberta',
      'Flexão pegada fechada',
      'Flexão pés elevados',
      'Peck deck',
      'Chest press',
      'Pullover com halteres',
    ],
    'Costas': [
      'Puxada frontal aberta',
      'Puxada frontal neutra',
      'Puxada atrás da nuca',
      'Remada curvada com barra',
      'Remada curvada com halteres',
      'Remada unilateral com halteres',
      'Remada baixa na polia',
      'Remada cavalinho',
      'Remada na máquina Hammer',
      'Barra fixa',
      'Barra fixa supinada',
      'Barra fixa neutra',
      'Levantamento terra',
      'Levantamento terra sumô',
      'Pullover na polia alta',
    ],
    'Ombros': [
      'Desenvolvimento com barra',
      'Desenvolvimento com halteres',
      'Desenvolvimento Arnold',
      'Elevação lateral com halteres',
      'Elevação lateral na polia',
      'Elevação frontal com halteres',
      'Elevação frontal na polia',
      'Remada alta com barra',
      'Remada alta com halteres',
      'Crucifixo invertido com halteres',
      'Crucifixo invertido na máquina',
      'Face pull na polia',
      'Desenvolvimento na máquina',
      'Shrug com halteres',
      'Shrug com barra',
    ],
    'Pernas': [
      'Agachamento livre',
      'Agachamento com halteres',
      'Agachamento frontal com barra',
      'Agachamento sumô',
      'Agachamento no Smith',
      'Leg press',
      'Cadeira extensora',
      'Cadeira flexora',
      'Stiff com barra',
      'Stiff com halteres',
      'Avanço com halteres',
      'Avanço com barra',
      'Passada no Smith',
      'Step-up com halteres',
      'Glute bridge',
      'Elevação quadril com barra',
      'Abdução quadril máquina',
      'Adução quadril máquina',
      'Panturrilha em pé',
      'Panturrilha sentado',
      'Panturrilha leg press',
    ],
    'Bíceps': [
      'Rosca direta com barra',
      'Rosca direta com halteres',
      'Rosca alternada com halteres',
      'Rosca martelo',
      'Rosca concentrada',
      'Rosca Scott',
      'Rosca 21',
      'Rosca polia baixa',
      'Rosca inversa com barra',
    ],
    'Tríceps': [
      'Tríceps testa barra',
      'Tríceps testa halteres',
      'Tríceps coice halteres',
      'Tríceps polia alta',
      'Tríceps banco',
      'Tríceps francês halteres',
      'Tríceps unilateral polia',
      'Tríceps máquina',
      'Tríceps supino pegada fechada',
    ],
    'Personalizado': [],
  };

  void adicionarExercicio() {
    String? categoriaSelecionada;
    String? exercicioSelecionado;
    final nomeController = TextEditingController();
    final seriesController = TextEditingController();
    final repeticoesController = TextEditingController();
    final cargaController = TextEditingController();
    final obsController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Adicionar exercício'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: categoriaSelecionada,
                  hint: const Text('Escolha uma categoria'),
                  items: bdExercicios.keys
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) {
                    setDialogState(() {
                      categoriaSelecionada = val;
                      exercicioSelecionado = null;
                    });
                  },
                ),
                const SizedBox(height: 10),
                if (categoriaSelecionada != null &&
                    categoriaSelecionada != 'Personalizado')
                  DropdownButtonFormField<String>(
                    value: exercicioSelecionado,
                    hint: const Text('Escolha um exercício'),
                    isExpanded: true,
                    items: bdExercicios[categoriaSelecionada]!
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setDialogState(() {
                        exercicioSelecionado = val;
                      });
                    },
                  ),
                if (categoriaSelecionada == 'Personalizado') ...[
                  const SizedBox(height: 10),
                  TextField(
                    controller: nomeController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do exercício',
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                TextField(
                  controller: seriesController,
                  decoration: const InputDecoration(labelText: 'Séries'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: repeticoesController,
                  decoration: const InputDecoration(labelText: 'Repetições'),
                  keyboardType: TextInputType.text,
                ),
                TextField(
                  controller: cargaController,
                  decoration: const InputDecoration(labelText: 'Carga'),
                ),
                TextField(
                  controller: obsController,
                  decoration: const InputDecoration(labelText: 'Observações'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if ((categoriaSelecionada == 'Personalizado' &&
                        nomeController.text.isEmpty) ||
                    (categoriaSelecionada != 'Personalizado' &&
                        exercicioSelecionado == null))
                  return;

                String nomeExercicio = categoriaSelecionada == 'Personalizado'
                    ? nomeController.text
                    : exercicioSelecionado!;

                Exercicio novoEx = Exercicio(
                  nome: nomeExercicio,
                  series: seriesController.text,
                  repeticoes: repeticoesController.text,
                  carga: cargaController.text,
                  observacoes: obsController.text,
                );

                setState(() {
                  widget.treino.exercicios.add(novoEx);
                  if (categoriaSelecionada == 'Personalizado') {
                    bdExercicios['Personalizado']!.add(nomeExercicio);
                  }
                });

                widget.atualizarTreino(widget.treino, widget.index);
                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  void editarExercicio(Exercicio e) {
    final nomeController = TextEditingController(text: e.nome);
    final seriesController = TextEditingController(text: e.series);
    final repeticoesController = TextEditingController(text: e.repeticoes);
    final cargaController = TextEditingController(text: e.carga);
    final obsController = TextEditingController(text: e.observacoes);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Editar exercício'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: seriesController,
                decoration: const InputDecoration(labelText: 'Séries'),
              ),
              TextField(
                controller: repeticoesController,
                decoration: const InputDecoration(labelText: 'Repetições'),
              ),
              TextField(
                controller: cargaController,
                decoration: const InputDecoration(labelText: 'Carga'),
              ),
              TextField(
                controller: obsController,
                decoration: const InputDecoration(labelText: 'Observações'),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                e.nome = nomeController.text;
                e.series = seriesController.text;
                e.repeticoes = repeticoesController.text;
                e.carga = cargaController.text;
                e.observacoes = obsController.text;
              });
              widget.atualizarTreino(widget.treino, widget.index);
              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  void excluirExercicio(int index) {
    setState(() {
      widget.treino.exercicios.removeAt(index);
    });
    widget.atualizarTreino(widget.treino, widget.index);
  }

  void confirmarExclusaoExercicio(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmação'),
        content: const Text('Tem certeza que deseja excluir este exercício?'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.red),
            onPressed: () => Navigator.pop(context), // Fecha o diálogo
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: () {
              excluirExercicio(index); // Chama a função de exclusão
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
      appBar: AppBar(title: Text(widget.treino.nome)),
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
                Expanded(
                  child: widget.treino.exercicios.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.fitness_center,
                                size: 48,
                                color: Colors.white30,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Nenhum exercício adicionado',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: widget.treino.exercicios.length,
                          itemBuilder: (context, index) {
                            final e = widget.treino.exercicios[index];
                            return Card(
                              color: Colors.black87,
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              child: ListTile(
                                title: Text(
                                  e.nome,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: true, // agora quebra linha
                                  overflow: TextOverflow.visible,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Séries: ${e.series}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Repetições: ${e.repeticoes}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Carga: ${e.carga}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Observações: ${e.observacoes}',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => editarExercicio(e),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () =>
                                          confirmarExclusaoExercicio(index),
                                    ),
                                  ],
                                ),
                                onTap: () => editarExercicio(e),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: adicionarExercicio,
                  child: const Text('Adicionar exercício'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
