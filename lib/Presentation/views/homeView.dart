// ignore_for_file: file_names, deprecated_member_use, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medcineapp/Presentation/widgets/Custom_dateBar.dart';
import 'package:medcineapp/Presentation/widgets/CustomedcineCard.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  int _selectedIndex = 0;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            CustomDatebar(),
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
                  return CustomedcineCard(index: index);
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
