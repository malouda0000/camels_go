class ProductModel {
  final int productId;
  final String productNameAr;
  final String productNameEn;
  final String imageUrl;
  final int quantity;

  ProductModel({
    required this.productId,
    required this.productNameAr,
    required this.productNameEn,
    required this.imageUrl,
    required this.quantity,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      productNameAr: json['product_name_ar'],
      productNameEn: json['product_name_en'],
      imageUrl: json['image_url'],
      quantity: json['quantity'] ?? 0,
    );
  }
}
