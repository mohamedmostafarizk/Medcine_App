import 'package:flutter/material.dart';

class Aftergetstarted2 extends StatelessWidget {
  const Aftergetstarted2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top image
          Container(
            color: const Color(0xFFFFFFFF),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.7,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 300),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Image.asset('asset/images/0_4.png'),
              ],
            ),
          ),

          // Bottom section
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.white,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.43,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Achieve More With Alerts: Stay Ahead Of The Curve',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Lorem Ipsum is simply dummy text of text has been the industry\'s standard',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                ),
                const Spacer(),

                // Arrows + Dots
                Row(
                  children: [
                    SizedBox(width: 20), // Space before left arrow
                    // Left arrow
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left,
                        size: 40,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Spacer(), // Dots
                    // Dots
                    Row(
                      children: [
                        dot(true), // inactive
                        const SizedBox(width: 10),
                        dot(false), // active dot
                      ],
                    ),
                    const Spacer(), // Right arrow
                    // Right arrow (disabled or goes to next page if you add it)
                    Icon(
                      Icons.arrow_circle_right,
                      size: 40,
                      color: Color.fromARGB(255, 185, 206, 231),
                    ),
                    SizedBox(width: 20), // Space after right arrow
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dot(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? Color.fromARGB(255, 185, 206, 231) : Colors.blue,
        shape: BoxShape.circle,
      ),
    );
  }
}
