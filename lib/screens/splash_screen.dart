import 'package:flutter/material.dart';
import 'home.dart'; // importar a nova tela inicial

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ), // alterado para HomePage
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/silhueta.jpg', fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Olympia Shape',
                style: TextStyle(
                  fontFamily: 'BBHSans',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 32,
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
