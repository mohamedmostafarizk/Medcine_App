// ignore_for_file: file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medcineapp/Presentation/views/getStarted.dart';
import 'package:medcineapp/models/client_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.clientModel});
  final ClientModel clientModel;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds and navigate to HomeView
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GetStarted(clientModel: widget.clientModel),
        ),
      );
    });
  }

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
