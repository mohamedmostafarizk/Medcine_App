// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medcineapp/models/client_model.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key, required this.clientModel});

  final ClientModel clientModel;

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  late List<DateTime> currentWeekDates;

  @override
  void initState() {
    super.initState();
    _generateCurrentWeek();
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
                    'Hello👋, ${widget.clientModel.name}!',
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
          ],
        ),
      ),
    );
  }
}
