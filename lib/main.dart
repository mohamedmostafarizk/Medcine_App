import 'package:flutter/material.dart';
import 'package:medcineapp/Presentation/views/homeView.dart';

void main() {
  runApp(MedcineApp());
}

class MedcineApp extends StatelessWidget {
  const MedcineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
