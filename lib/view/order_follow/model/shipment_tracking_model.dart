class ShipmentTrackingResponse {
  final int code;
  final String message;
  final Address from;
  final Address to;
  final Shipment shipment;
  final List<Tracking> trackings;

  ShipmentTrackingResponse({
    required this.code,
    required this.message,
    required this.from,
    required this.to,
    required this.shipment,
    required this.trackings,
  });

  factory ShipmentTrackingResponse.fromJson(Map<String, dynamic> json) {
    return ShipmentTrackingResponse(
      code: json['code'],
      message: json['message'],
      from: Address.fromJson(json['from']),
      to: Address.fromJson(json['to']),
      shipment: Shipment.fromJson(json['shipment']),
      trackings: (json['trackings'] as List<dynamic>)
          .map((item) => Tracking.fromJson(item))
          .toList(),
    );
  }
}

class Address {
  final LocalizedData ar;
  final LocalizedData en;

  Address({required this.ar, required this.en});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      ar: LocalizedData.fromJson(json['ar']),
      en: LocalizedData.fromJson(json['en']),
    );
  }
}

class LocalizedData {
  final String name;
  final String address;

  LocalizedData({required this.name, required this.address});

  factory LocalizedData.fromJson(Map<String, dynamic> json) {
    return LocalizedData(
      name: json['name'],
      address: json['address'],
    );
  }
}

class Shipment {
  final ShipmentDetails shipmentDetails;
  final CustomerDetails customerDetails;

  Shipment({required this.shipmentDetails, required this.customerDetails});

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      shipmentDetails: ShipmentDetails.fromJson(json['shipment_details']),
      customerDetails: CustomerDetails.fromJson(json['customer_details']),
    );
  }
}

class ShipmentDetails {
  final int shipmentId;
  final String shipmentRefrence;
  final String addedDate;
  final String deliveredDate;
  final String companyNameAr;
  final String companyNameEn;
  final double shipmentAmount;
  final int deliveryFees;
  final int deliveryExtraFees;
  final String paymentMethod;
  final String feesTypeId;
  final String? shipmentNotes;
  final String? hasStock;
  final String? shipmentContent;

  ShipmentDetails({
    required this.shipmentId,
    required this.shipmentRefrence,
    required this.addedDate,
    required this.deliveredDate,
    required this.companyNameAr,
    required this.companyNameEn,
    required this.shipmentAmount,
    required this.deliveryFees,
    required this.deliveryExtraFees,
    required this.paymentMethod,
    required this.feesTypeId,
    this.shipmentNotes,
    this.hasStock,
    this.shipmentContent,
  });

  factory ShipmentDetails.fromJson(Map<String, dynamic> json) {
    return ShipmentDetails(
      shipmentId: json['shipment_id'],
      shipmentRefrence: json['shipment_refrence'],
      addedDate: json['added_date'],
      deliveredDate: json['delivered_date'],
      companyNameAr: json['company_name_ar'],
      companyNameEn: json['company_name_en'],
      shipmentAmount: (json['shipment_amount'] as num).toDouble(),
      deliveryFees: json['delivery_fees'],
      deliveryExtraFees: json['delivery_extra_fees'],
      paymentMethod: json['payment_method'],
      feesTypeId: json['fees_type_id'],
      shipmentNotes: json['shipment_notes'],
      hasStock: json['has_stock'],
      shipmentContent: json['shipment_content'],
    );
  }
}

class CustomerDetails {
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerCity;
  final String customerEmirate;

  CustomerDetails({
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerCity,
    required this.customerEmirate,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      customerAddress: json['customer_address'],
      customerCity: json['customer_city'],
      customerEmirate: json['customer_emirate'],
    );
  }
}

class Tracking {
  final String nameAr;
  final String nameEn;
  final String time;

  Tracking({
    required this.nameAr,
    required this.nameEn,
    required this.time,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) {
    return Tracking(
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      time: json['time'],
    );
  }
}
