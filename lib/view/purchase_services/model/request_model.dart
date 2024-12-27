class RequestModel {
  final int id;
  final String requestNumber;
  final String serviceAr;
  final String serviceEn;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String? notes;

  RequestModel({
    required this.id,
    required this.requestNumber,
    required this.serviceAr,
    required this.serviceEn,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      requestNumber: json['request_number'],
      serviceAr: json['service_ar'],
      serviceEn: json['service_en'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      notes: json['notes'],
    );
  }
}