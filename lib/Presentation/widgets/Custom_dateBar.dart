// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomDatebar extends StatefulWidget {
  const CustomDatebar({super.key});

  @override
  State<CustomDatebar> createState() => _CustomDatebarState();
}

class _CustomDatebarState extends State<CustomDatebar> {
  late List<DateTime> currentWeekDates;

  @override
  void initState() {
    super.initState();
    _generateCurrentWeek();
  }

  void _generateCurrentWeek() {
    DateTime today = DateTime.now();
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    currentWeekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

    return SizedBox(
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
    );
  }
}
