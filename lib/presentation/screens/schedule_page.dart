import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay = DateTime.now();
  late DateTime _firstDay;
  late DateTime _lastDay;
  late DateTime _selectedDay;
  String _selectedTime = '';

  @override
  void initState() {
    super.initState();
    _firstDay = DateTime.now().add(Duration(days: 1));
    _lastDay = DateTime.now().add(Duration(days: 61));
    _selectedDay = _focusedDay;


    if (_focusedDay.isBefore(_firstDay)) {
      _focusedDay = _firstDay;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Column(
        children: [
          TableCalendar(
        firstDay: _firstDay,
        lastDay: _lastDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
            _selectedDay = selectedDay;
          });
        },
        calendarFormat: CalendarFormat.month,
        onFormatChanged: (format) {},
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
        },
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          outsideDaysVisible: false,
        ),
        headerStyle: HeaderStyle(),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          weekendStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        locale: 'en_US',
      ),
          const SizedBox(height: 20),
          Text(
            'Select Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                final hour = index + 8;
                final isAM = hour < 12;
                final amOrPm = isAM ? 'AM' : 'PM';
                final formattedHour = (isAM ? hour : hour - 12).toString().padLeft(2, '0');
                final time = '$formattedHour:00 $amOrPm';

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedTime == time ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedTime == time ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {'selectedDate': _selectedDay, 'selectedTime': _selectedTime});
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
