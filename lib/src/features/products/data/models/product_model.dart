import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';

/// Data-layer model for product API payload mapping.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.rating,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final num rating;

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

  /// Converts the API model into the domain entity consumed by the app.
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
      rating: rating,
    );
  }
}
