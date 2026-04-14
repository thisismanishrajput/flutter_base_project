import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';

/// Data-layer model for product API payload mapping.
class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required super.thumbnail,
    required super.rating,
  });

  /// Builds model from API JSON map.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '',
      rating: json['rating'] as num? ?? 0,
    );
  }
}
