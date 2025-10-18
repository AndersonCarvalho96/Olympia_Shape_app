// lib/screens/home.dart
import 'package:flutter/material.dart';
import 'treino_home.dart';
import 'dieta_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset('assets/images/silhueta.jpg', fit: BoxFit.cover),
          ),
          // Overlay escuro
          Container(color: Colors.black.withOpacity(0.6)),
          // Conteúdo centralizado
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding horizontal e vertical no título
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05, // 5% da largura
                    vertical: 40,
                  ),
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Olympia Shape',
                      style: TextStyle(
                        fontFamily: 'BBHSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 36,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Botão Treino
                SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const TreinoHome()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            offset: const Offset(4, 4),
                            blurRadius: 6,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            offset: const Offset(-4, -4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Treino',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botão Dieta
                SizedBox(
                  width: 200,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const DietaHome()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            offset: const Offset(4, 4),
                            blurRadius: 6,
                          ),
                          BoxShadow(
                            color: Colors.white.withOpacity(0.05),
                            offset: const Offset(-4, -4),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Dieta',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
