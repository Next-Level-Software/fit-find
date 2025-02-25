import 'package:flutter/material.dart';

class DaySelector extends StatefulWidget {
  final ValueChanged<String>? onDaySelected; // Callback for selected day

  const DaySelector({
    super.key,
    this.onDaySelected, // Make callback required
  });

  @override
  DaySelectorState createState() => DaySelectorState();
}

class DaySelectorState extends State<DaySelector> {
  // List of days
  final List<String> days = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  // Selected day
  String selectedDay = "Sun";

  // Function to select a day
  void selectDay(String day) {
    setState(() {
      selectedDay = day;
    });
    widget.onDaySelected?.call(day); // Call the callback
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (String day in days) ...[
          Expanded(
            child: GestureDetector(
              onTap: () {
                selectDay(day); // Update selected day
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: selectedDay == day
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day,
                    style: TextStyle(
                      color: selectedDay == day ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
