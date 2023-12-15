import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wellness_cart/presentation/screens/home_page.dart';

class SuccessPage extends StatelessWidget {
  final String scheduledDate;
  final String scheduledTime;

  SuccessPage({required this.scheduledDate, required this.scheduledTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Success',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Color(0xff0D99FF)),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/success_icon.svg', height: 165, width: 180),
                SizedBox(height: 20),
                Text(
                  'Lab tests have been scheduled successfully. You will receive an email of the same.',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  '${_formattedDate(scheduledDate)} | ${_formattedTime(scheduledTime)}',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(HomePage());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Color(0xff10217D),
                  ),
                  child: Text(
                    'Back to Home',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  String _formattedDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat('dd MMM y').format(dateTime);
  }
  String _formattedTime(String time) {
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    return '${_formatHour(hour)} ${_getTimePeriod(hour)}';
  }

  String _formatHour(int hour) {
    return (hour % 12).toString();
  }

  String _getTimePeriod(int hour) {
    return (hour < 12) ? 'AM' : 'PM';
  }
}
