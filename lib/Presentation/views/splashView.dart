// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 129, 233),
      body: Center(
        child: Image.asset('asset/images/0_1.png', fit: BoxFit.cover),
      ),
    );
  }
}
