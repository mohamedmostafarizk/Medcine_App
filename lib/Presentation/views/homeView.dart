// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  late List<DateTime> currentWeekDates;
  bool isChecked = false;
  String clientName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _generateCurrentWeek();
  }

  Future<void> _loadUserName() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null && data.containsKey('name')) {
          setState(() {
            clientName = data['name']; // ✅ Save name here
          });
        }
      }
    }
  }

  void _generateCurrentWeek() {
    DateTime today = DateTime.now();

    // Adjust to week start (Monday as first day)
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    // Create list of 7 days in the current week
    currentWeekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Row
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 42,
                bottom: 40,
              ),
              child: Row(
                children: [
                  Text(
                    'Hello👋, $clientName!',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.healing_outlined),
                ],
              ),
            ),

            // Weekly date navbar
            SizedBox(
              height: 70,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 8),
                scrollDirection: Axis.horizontal,
                itemCount: currentWeekDates.length,
                itemBuilder: (context, index) {
                  final date = currentWeekDates[index];
                  bool isToday =
                      date.day == DateTime.now().day &&
                      date.month == DateTime.now().month &&
                      date.year == DateTime.now().year;

                  return Container(
                    width: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: isToday ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekdays[date.weekday - 1],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isToday ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text(
                'Today',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 196, 225, 249),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch, // full height
                  children: [
                    // Gicon container aligned to bottom
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ), // space from bottom
                        child: Image.asset(
                          'asset/icons/gicon.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),

                    // Main content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            const Text('Paracetamol'),

                            // Subtitle content
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('1 pill | 1 pill'),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.watch_later_outlined),
                                    const SizedBox(width: 5),
                                    const Text('08:00 AM'),
                                    const Spacer(),
                                    Checkbox(
                                      value: isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          isChecked = value!;
                                        });
                                      },
                                      shape: const CircleBorder(),
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
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
            ),
          ],
        ),
      ),
    );
  }
}
