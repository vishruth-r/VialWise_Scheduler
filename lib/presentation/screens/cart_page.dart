import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wellness_cart/models/labtest_model.dart';
import 'package:wellness_cart/presentation/screens/schedule_page.dart';
import 'package:wellness_cart/presentation/screens/success_page.dart';
import 'home_page.dart';

class ScheduleController extends GetxController {
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<String?> selectedTime = Rx<String?>(null);

  void updateSelectedDateTime(DateTime? date, String? time) {
    selectedDate.value = date;
    selectedTime.value = time;
    update();
  }
}

class CartPage extends StatelessWidget {
  final ScheduleController scheduleController = Get.put(ScheduleController());
  @override
  final CartController cartController = Get.find<CartController>();
  bool isDateSelected = true;

  double calculateTotalMRP(List<LabTestModel> items) {
    double total = 0.0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
  double calculateTotalDiscount(List<LabTestModel> items) {
    double totalDiscount = 0.0;
    for (var item in items) {
      totalDiscount += (item.price - item.discountPrice);
    }
    return totalDiscount;
  }
  double calculateAmountToBePaid(List<LabTestModel> items) {
    double totalMRP = calculateTotalMRP(items);
    double totalDiscount = calculateTotalDiscount(items);
    return totalMRP - totalDiscount;
  }
  double calculateTotalSavings(List<LabTestModel> items) {
    double totalMRP = calculateTotalMRP(items);
    double amountToBePaid = calculateAmountToBePaid(items);
    return totalMRP - amountToBePaid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Cart',
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
    body: GetBuilder<CartController>(
    init: cartController,
    builder: (_) =>
    cartController.cartItems.isEmpty
        ? Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your cart is empty.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        : SingleChildScrollView(
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Text(
                'Order Review',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartController.cartItems[index];
                return Card(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (index == 0)
                        Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(16, 33, 125, 0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Pathology Tests',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.testName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₹ ${item.discountPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff1BA9B5),
                                  ),
                                ),
                                Text(
                                  '₹ ${item.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: OutlinedButton.icon(
                              onPressed: () {
                                cartController.removeFromCart(item);
                                Get.find<CartController>().update();
                              },
                              icon: Icon(Icons.delete_outline, color: Color.fromRGBO(16, 33, 125, 0.8)),
                              label: Text(
                                'Remove',
                                style: TextStyle(color: Color.fromRGBO(16, 33, 125, 0.8)),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(16, 33, 125, 0.8)
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: OutlinedButton.icon(
                              onPressed: () {
                              },
                              icon: Icon(Icons.file_upload_outlined, color: Color.fromRGBO(16, 33, 125, 0.8)),
                              label: Text(
                                'Upload Prescription (optional)',
                                style: TextStyle(
                                  color: Color.fromRGBO(16, 33, 125, 0.8),
                                ),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: BorderSide(color: Color.fromRGBO(16, 33, 125, 0.8)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(SchedulePage());
                },
                child: Container(
                  padding: EdgeInsets.only(left: 12,right: 20,top: 20,bottom: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: Color.fromRGBO(16, 33, 125, 0.8),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SchedulePage())?.then((value) {
                              if (value != null && value is Map<String, dynamic>) {
                                DateTime? selectedDate = value['selectedDate'];
                                String? selectedTime = value['selectedTime'];
                                if (selectedDate != null && selectedTime != null) {
                                  scheduleController.updateSelectedDateTime(selectedDate, selectedTime);
                                }
                              }
                            });
                          },
                          child: Container(
                            child: GetBuilder<ScheduleController>(
                              builder: (ScheduleController) {
                                if (ScheduleController.selectedDate == null || ScheduleController.selectedTime == null) {
                                  return Text(
                                    'Select Date',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  );
                                } else {
                                  return Text(
                                    'Date: ${ScheduleController.selectedDate.toString()} \nTime: ${ScheduleController.selectedTime}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('M.R.P. Total:', style: TextStyle(fontSize: 16)),
                      Text('₹ ${calculateTotalMRP(cartController.cartItems)}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount:', style: TextStyle(fontSize: 16)),
                      Text('₹ ${calculateTotalDiscount(cartController.cartItems)}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Amount to be Paid:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Color(0xff10217D))),
                      Text('₹ ${calculateAmountToBePaid(cartController.cartItems)}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: Color(0xff10217D))),
                    ],
                  ),
                  SizedBox(height: 30),
                  Text('Total Savings: ₹ ${calculateTotalSavings(cartController.cartItems)}', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            SizedBox(height:20),
            Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomCheckbox(),
                      SizedBox(width: 8),
                      Text(
                        'Hard Copy of Reports',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Reports will be delivered within 3-4 working days. Hard copy charges are non-refundable once the reports have been dispatched.\n\n₹150 per person',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                onPressed: isDateSelected
                    ? () {
                  Get.to(SuccessPage(
                    scheduledDate: '2023-12-25',
                    scheduledTime: '10:00',
                  ));
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  primary: isDateSelected ? Color(0xff10217D) : Colors.grey,
                ),
                child: Text(
                  'Schedule',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),

      ),
    ),
    );
  }
}

class CustomCheckbox extends StatefulWidget {
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}
class _CustomCheckboxState extends State<CustomCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isChecked ? Colors.blue : Colors.grey,
            width: 1.0,
          ),
          color: isChecked ? Colors.blue : Colors.transparent,
        ),
        child: isChecked
            ? Icon(
          Icons.check,
          size: 18,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}