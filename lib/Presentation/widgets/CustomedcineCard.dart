// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class CustomedcineCard extends StatefulWidget {
  const CustomedcineCard({super.key, required this.index});
  final int index;

  @override
  State<CustomedcineCard> createState() => _CustomedcineCardState();
}

class _CustomedcineCardState extends State<CustomedcineCard> {
  List<bool> isCheckedList = [];

  @override
  void initState() {
    super.initState();
    isCheckedList = List.generate(10, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Container(
        height: 155,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F8FF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gicon container aligned to bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Container(
                width: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFD5D7FD),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  // Replace with a placeholder if asset is an issue
                  child: Image.asset(
                    'asset/icons/gicon.png',
                    height: 50,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
                ),
              ),
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const Text(
                      'Paracetamol',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Subtitle content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 pill | 1 pill',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.6),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const Icon(Icons.watch_later_outlined),
                            const SizedBox(width: 5),
                            const Text('08:00 AM'),
                            const Spacer(),
                            Transform.scale(
                              scale: 1.2,
                              child: Checkbox(
                                value: isCheckedList[widget.index],
                                onChanged: (value) {
                                  setState(() {
                                    isCheckedList[widget.index] = value!;
                                  });
                                },
                                shape: const CircleBorder(),
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
