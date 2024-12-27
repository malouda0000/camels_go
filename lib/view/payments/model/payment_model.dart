class PaymentModel {
  final String clientName;
  final String mobile;
  final String addressAr;
  final String addressEn;
  final String shipmentReferenceCode;
  final String date;
  final double deliveryFees;
  final double shipmentAmount;
  final String paymentTypeAr;
  final String paymentTypeEn;
  final double dueAmount;
  final String paidOrNotPaidAr;
  final String paidOrNotPaidEn;
  PaymentModel({
    required this.clientName,
    required this.mobile,
    required this.addressAr,
    required this.addressEn,
    required this.shipmentReferenceCode,
    required this.date,
    required this.deliveryFees,
    required this.shipmentAmount,
    required this.paymentTypeAr,
    required this.paymentTypeEn,
    required this.dueAmount,
    required this.paidOrNotPaidAr,
    required this.paidOrNotPaidEn,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      clientName: json['clinet_name'],
      mobile: json['mobile'],
      addressAr: json['address_ar'],
      addressEn: json['address_en'],
      shipmentReferenceCode: json['shipment_refrence_code'],
      date: json['date'],
      deliveryFees: json['delivery_fees'].toDouble(),
      shipmentAmount: json['shipment_amount'].toDouble(),
      paymentTypeAr: json['payment_type_ar'],
      paymentTypeEn: json['payment_type_en'],
      dueAmount: json['due_amount'].toDouble(),
      paidOrNotPaidAr: json['paid_or_not_paid_ar'],
      paidOrNotPaidEn: json['paid_or_not_paid_en'],
    );
  }
}