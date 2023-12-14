import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../models/labtest_model.dart';
import '../../models/package_model.dart';
import 'cart_page.dart';

class CartController extends GetxController {
  RxList<LabTestModel> cartItems = <LabTestModel>[].obs;

  void addToCart(LabTestModel test) {
    cartItems.add(test);
  }

  void removeFromCart(LabTestModel test) {
    cartItems.remove(test);
  }
}

class HomePage extends StatelessWidget {
  final cartController = Get.put(CartController());

  final List<PackageModel> package = [
    PackageModel(
      packageName: 'Package 1',
      packageDescription: 'Includes 92 tests\n-Blood Glucose Fasting\n-Liver Function Test',
      packagePrice: 299.99,
      packageImage: 'assets/images/package1.png',
    ),
    PackageModel(
      packageName: 'Package 2',
      packageDescription: 'Description for Package 2',
      packagePrice: 199.99,
      packageImage: 'assets/images/package2.png',
    ),

  ];

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
      appBar: AppBar(
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(CartPage());
              },
              child: SvgPicture.asset(
                'assets/images/cart_icon.svg',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Lab tests',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                GestureDetector(
                  onTap: () {

                  },
                  child: Text(
                    'View more',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            padding: EdgeInsets.all(8.0),
            childAspectRatio: 0.8,
            children: popularTests.map((test) {
              return _buildTestCard(test);
            }).toList(),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Popular Packages',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          _buildPackageCard(package),
        ],
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
                      'assets/images/shield_icon.svg',
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
                    cartController.addToCart(test);
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

  Widget _buildPackageCard(List<PackageModel> packages) {
    return Column(
      children: packages.map((package) {
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 36, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/pill_icon.svg',
                          height: 60,
                          width: 60,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/images/shield_safe_icon.svg',
                          height: 18,
                          width: 53.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      package.packageName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      package.packageDescription,
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        'View more',
                        style: TextStyle(
                          fontSize: 10.5,
                          decoration: TextDecoration.underline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${package.packagePrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF1BA9B5),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cartController.addToCart(LabTestModel(
                          testName: package.packageName,
                          numberOfTests: 1,
                          discountPrice: package.packagePrice,
                          price: package.packagePrice,
                          description: package.packageDescription,
                          reportIn24Hours: true,
                        ));
                      },
                      child: Text('Add to Cart'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
