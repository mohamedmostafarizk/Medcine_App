// ignore_for_file: file_names, deprecated_member_use, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  int _selectedIndex = 0;
  late List<DateTime> currentWeekDates;
  List<bool> isCheckedList = [];

  String clientName = '';

  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Medicine Page")),
    const Center(child: Text("About Page")),
  ];

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _generateCurrentWeek();
    isCheckedList = List.generate(10, (_) => false);
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
            clientName = data['name'];
          });
        }
      }
    }
  }

  void _generateCurrentWeek() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    currentWeekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                'Today',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          const Icon(
                                            Icons.watch_later_outlined,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text('08:00 AM'),
                                          const Spacer(),
                                          Transform.scale(
                                            scale: 1.2,
                                            child: Checkbox(
                                              value: isCheckedList[index],
                                              onChanged: (value) {
                                                setState(() {
                                                  isCheckedList[index] = value!;
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
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.medication),
            label: "Medicine",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
        ],
      ),
    );
  }
}
