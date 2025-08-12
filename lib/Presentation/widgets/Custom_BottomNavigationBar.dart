// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomBottomnavigationbar extends StatefulWidget {
  const CustomBottomnavigationbar({super.key});

  @override
  State<CustomBottomnavigationbar> createState() =>
      _CustomBottomnavigationbarState();
}

class _CustomBottomnavigationbarState extends State<CustomBottomnavigationbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}
