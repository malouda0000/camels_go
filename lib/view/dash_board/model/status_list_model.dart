class StatusListModel {
  final int id;
  final String nameAr;
  final String nameEn;

  StatusListModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  // Factory constructor for creating a StatusListModel instance from a JSON map
  factory StatusListModel.fromJson(Map<String, dynamic> json) {
    return StatusListModel(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
    );
  }

  // Method to convert a Status instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }
}
