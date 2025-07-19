// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Aftergetstarted2 extends StatelessWidget {
  const Aftergetstarted2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color(0xFFFFFFFF),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.7,
            child: Image.asset('asset/images/0_3.png'),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.red,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.43,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Dive Into Your Profound Journey Of Wellness',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of text has been the industry\'s standard',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
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
