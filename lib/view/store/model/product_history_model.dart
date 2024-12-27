class ProductHistoryModel {
  final String? referenceCode;
  final String? customerNumber;
  final String? emirateAr;
  final String? emirateEn;
  final int quantity;
  final String date;
  final String notes;

  ProductHistoryModel({
    required this.referenceCode,
    this.customerNumber,
    this.emirateAr,
    this.emirateEn,
    required this.quantity,
    required this.date,
    required this.notes,
  });

  factory ProductHistoryModel.fromJson(Map<String, dynamic> json) {
    return ProductHistoryModel(
      referenceCode: json['refrenec_code'],
      customerNumber: json['customer_number'],
      emirateAr: json['emirate_ar'],
      emirateEn: json['emirate_en'],
      quantity: json['quantity'],
      date: json['date'],
      notes: json['notes'],
    );
  }
}