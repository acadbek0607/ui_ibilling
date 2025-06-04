import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selecteDay = DateTime.now();

  List<DateTime> _getVisibleWeekDay(DateTime focusedDay) {
    final startOfWeek = focusedDay.subtract(
      Duration(days: focusedDay.weekday - 1),
    );
    return List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  void _goToPreviousWeek() {
    setState(() {
      _focusedDay = _focusedDay.subtract(Duration(days: 7));
    });
  }

  void _goToNextWeek() {
    setState(() {
      _focusedDay = _focusedDay.add(Duration(days: 7));
    });
  }

  @override
  Widget build(BuildContext context) {
    final weekDays = _getVisibleWeekDay(_focusedDay);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMM().format(_focusedDay),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFDADADA),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _goToPreviousWeek,
                    icon: Icon(Icons.chevron_left_rounded),
                    color: Color(0xFFdadada),
                  ),
                  IconButton(
                    onPressed: _goToNextWeek,
                    icon: Icon(Icons.chevron_right_rounded),
                    color: Color(0xFFdadada),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...weekDays.map((day) {
                final isSelected = isSameDay(day, _selecteDay);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selecteDay = day;
                      _focusedDay = day.subtract(
                        Duration(days: day.weekday - 1),
                      );
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 10.0,
                    ),
                    decoration: isSelected
                        ? BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(8),
                          )
                        : null,
                    child: Column(
                      children: [
                        Text(
                          DateFormat.E().format(day),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Ubuntu',
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${day.day}',
                          style: TextStyle(color: Color(0xFFD1D1D1)),
                        ),
                        if (isSelected)
                          Container(
                            margin: EdgeInsets.only(top: 4),
                            height: 2,
                            width: 20,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
