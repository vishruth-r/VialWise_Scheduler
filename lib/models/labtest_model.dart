class LabTestModel {
  final String testName;
  final int numberOfTests;
  final double price;
  final double discountPrice;
  final String description;
  final bool reportIn24Hours;
  LabTestModel({
    required this.testName,
    required this.numberOfTests,
    required this.price,
    required this.discountPrice,
    required this.description,
    required this.reportIn24Hours,
  });
}
