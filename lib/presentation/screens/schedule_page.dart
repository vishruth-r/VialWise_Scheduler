import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  bool get canConfirm => _selectedDay != null && _selectedTime.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Schedule',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.blue,),
            onPressed: () {
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 18.0),
              child: Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.all(16.0),
              elevation: 4.0,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TableCalendar(
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
                    selectedDecoration: BoxDecoration(color: Color(0xff10217D),shape: BoxShape.circle),
                    isTodayHighlighted: true,
                    outsideDaysVisible: false,
                  ),
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.blue,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.blue,
                    ),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    weekendStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                'Select Time',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 12,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 20,
                childAspectRatio: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                final hour = index + 8;
                final isAM = hour < 12;
                final amOrPm = isAM ? 'AM' : 'PM';
                final formattedHour = (isAM ? hour : hour - 12)
                    .toString()
                    .padLeft(2, '0');
                final time = '$formattedHour:00 $amOrPm';

                return GestureDetector(
                  onTap: _selectedDay != null
                      ? () {
                    setState(() {
                      _selectedTime = time;
                    });
                  }
                      : null,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: _selectedTime == time
                          ? Color(0xff10217D)
                          : Colors.white,
                      border: Border.all(
                        color: Color(0xff10217D)
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedTime == time ? Colors.white : Color(0xff10217D),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: canConfirm
                    ? () {
                  print("Works");
                  //print(_selectedTime);
                  //print(_selectedDay);

                  Get.back(result: {
                    'selectedDate': _selectedDay,
                    'selectedTime': _selectedTime
                  });
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(320, 50),
                  primary: Color(0xff10217D)
                ),
                child: Text('Confirm'),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
