class LabTestModel {
  final String testName;
  final int numberOfTests;
  final double price;
  final double discountPrice;
  final String description; // Additional information about the test
  final bool reportIn24Hours; // Boolean indicating if the report is available in 24 hours

  LabTestModel({
    required this.testName,
    required this.numberOfTests,
    required this.price,
    required this.discountPrice,
    required this.description,
    required this.reportIn24Hours,
  });
}
