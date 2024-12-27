class ServiceModel {
  final int id;
  final String nameAr;
  final String nameEn;

  ServiceModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
    );
  }
}