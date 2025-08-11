import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medcineapp/Presentation/views/splashView.dart';
import 'package:medcineapp/models/client_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MedcineApp());
}

class MedcineApp extends StatelessWidget {
  const MedcineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(
        clientModel: ClientModel(name: ""),
      ), // Pass an empty ClientModel for now
    );
  }
}
