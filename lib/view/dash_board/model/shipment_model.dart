class ShipmentModel {
  final int id;
  final String shipmentReference;
  final String customerPhone;
  final double amount;
  final int statusId;
  final String statusNameAr;
  final String statusNameEn;
  final int? emirateId;
  final String emirateAr;
  final String emirateEn;

  ShipmentModel({
    required this.id,
    required this.shipmentReference,
    required this.customerPhone,
    required this.amount,
    required this.statusId,
    required this.statusNameAr,
    required this.statusNameEn,
    this.emirateId,
    required this.emirateAr,
    required this.emirateEn,
  });

  factory ShipmentModel.fromJson(Map<String, dynamic> json) {
    return ShipmentModel(
      id: json['id'],
      shipmentReference: json['shipment_reference'],
      customerPhone: json['customer_phone'],
      amount: json['amount'].toDouble(),
      statusId: json['status_id'],
      statusNameAr: json['status_name_ar'],
      statusNameEn: json['status_name_en'],
      emirateId: json['emirate_id'],
      emirateAr: json['emirate_ar'],
      emirateEn: json['emirate_en'],
    );
  }
}