// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Aftergetstarted1 extends StatelessWidget {
  const Aftergetstarted1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('asset/images/0_3.png'),
              SizedBox(height: 50),
              Text(
                'Dive Into Your Profound Journey Of Wellness',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'Lorem Ipsum is simply dummy text of text has been the industry\'s standard',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
