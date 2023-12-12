import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../models/labtest_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<LabTestModel> popularTests = [
    LabTestModel(
      testName: 'Thyroid Profile',
      numberOfTests: 3,
      discountPrice: 99.99,
      price: 200,
      description: 'This test includes tests for thyroid function.',
      reportIn24Hours: true,
    ),
    LabTestModel(
      testName: 'Iron Study Test',
      numberOfTests: 4,
      discountPrice: 99.99,
      price: 129.99,
      description: 'This test includes tests for iron levels.',
      reportIn24Hours: true,
    ),
    LabTestModel(
      testName: 'Thyroid Profile',
      numberOfTests: 3,
      discountPrice: 99.99,
      price: 200,
      description: 'This test includes tests for thyroid function.',
      reportIn24Hours: true,
    ),
    LabTestModel(
      testName: 'Iron Study Test',
      numberOfTests: 4,
      discountPrice: 99.99,
      price: 129.99,
      description: 'This test includes tests for iron levels.',
      reportIn24Hours: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Health Checkup App',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/images/cart_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(8.0),
        childAspectRatio: 0.8,
        children: popularTests.map((test) {
          return _buildTestCard(test);
        }).toList(),
      ),
    );
  }

  Widget _buildTestCard(LabTestModel test) {
    return Card(
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Color.fromRGBO(16, 33, 128, 0.6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            alignment: Alignment.center,
            child: Text(
              test.testName,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Includes ${test.numberOfTests} tests',
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/images/safe_image.svg',
                      height: 27,
                      width: 24,
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  test.reportIn24Hours ? 'Get reports in 24 hours' : '',
                  style: TextStyle(fontSize: 7, color: Colors.grey),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹ ${test.discountPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff10217D),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${test.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 6.5,
                        decoration: TextDecoration.lineThrough,
                        color: Color(0xff5B5B5B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontSize: 9.5),
                  ),
                ),
                SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: TextStyle(fontSize: 9.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}