import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const TreinoApp());
}

class TreinoApp extends StatelessWidget {
  const TreinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Olympia Shape',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
        primaryColor: Colors.redAccent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
        textTheme: ThemeData.dark().textTheme,
      ),
      home: const SplashScreen(),
    );
  }
}
