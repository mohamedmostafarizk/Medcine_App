// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medcineapp/models/client_model.dart';

class Homeview extends StatelessWidget {
  const Homeview({super.key, required this.clientModel});

  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Hello👋, ${clientModel.name}!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                Icon(Icons.healing_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
