// lib/models/meta_data.dart

class MetaDataModel {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  MetaDataModel({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  factory MetaDataModel.fromJson(Map<String, dynamic> json) {
    return MetaDataModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }
}
