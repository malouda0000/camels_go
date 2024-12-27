class ShipmentDetailsModel {
  final int shipmentId;
  final String shipmentReference;
  final String addedDate;
  final String deliveredDate;
  final String companyNameAr;
  final String companyNameEn;
  final int shipmentAmount;
  final int deliveryFees;
  final int deliveryExtraFees;
  final String paymentMethod;
  final String feesTypeId;
  final String? shipmentNotes;
  final int hasStock;
  final List<ShipmentContent>? shipmentContent;
  final String? shipmentContentString;
  // final CustomerDetails? customerDetails;

  ShipmentDetailsModel({
    required this.shipmentId,
    required this.shipmentReference,
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
    required this.hasStock,
    required this.shipmentContent,
    this.shipmentContentString,
    // this.customerDetails,
  });

  factory ShipmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ShipmentDetailsModel(
      shipmentId: json['shipment_id'],
      shipmentReference: json['shipment_refrence'],
      addedDate: json['added_date'],
      deliveredDate: json['delivered_date'],
      companyNameAr: json['company_name_ar'],
      companyNameEn: json['company_name_en'],
      shipmentAmount: json['shipment_amount'],
      deliveryFees: json['delivery_fees'],
      deliveryExtraFees: json['delivery_extra_fees'],
      paymentMethod: json['payment_method'],
      feesTypeId: json['fees_type_id'],
      shipmentNotes: json['shipment_notes'],
      hasStock: json['has_stock'],
      shipmentContent: json['shipment_content'] != null
          ? (json['shipment_content'] as List)
              .map((item) => ShipmentContent.fromJson(item))
              .toList()
          : null,
      // customerDetails: json['customer_details'] == null
      //     ? null
      //     : CustomerDetails.fromJson(json['customer_details']),
      shipmentContentString:
          json['has_stock'] == 0 ? json['shipment_content'] : '',
    );
  }
}

class ShipmentContent {
  final int id;
  final int productId;
  final int quantity;
  final Product product;

  ShipmentContent({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.product,
  });

  factory ShipmentContent.fromJson(Map<String, dynamic> json) {
    return ShipmentContent(
      id: json['id'],
      productId: json['product_id'],
      quantity: json['quantity'],
      product: Product.fromJson(json['product']),
    );
  }
}

class Product {
  final int id;
  final String nameAR;
  final String nameEN;

  Product({
    required this.id,
    required this.nameAR,
    required this.nameEN,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nameAR: json['name']['ar'],
      nameEN: json['name']['en'],
    );
  }
}

class CustomerDetailsModel {
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String customerCity;
  final String customerEmirate;

  CustomerDetailsModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.customerCity,
    required this.customerEmirate,
  });

  factory CustomerDetailsModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsModel(
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      customerAddress: json['customer_address'],
      customerCity: json['customer_city'],
      customerEmirate: json['customer_emirate'],
    );
  }
}
