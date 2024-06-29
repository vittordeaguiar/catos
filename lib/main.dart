import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CatApp());
}

class CatApp extends StatelessWidget {
  const CatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Catos',
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const HomeScreen());
  }
}
