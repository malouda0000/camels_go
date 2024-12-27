class EmirateModel {
  int id;
  String nameAr;
  String nameEn;
  String code;

  EmirateModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.code,
  });

  // Factory constructor to create a EmirateModel object from JSON
  factory EmirateModel.fromJson(Map<String, dynamic> json) {
    return EmirateModel(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
      code: json['code'] as String,
    );
  }

  // Method to convert a City object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'code': code,
    };
  }
}
