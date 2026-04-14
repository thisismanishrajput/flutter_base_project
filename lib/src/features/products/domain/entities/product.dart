import 'package:equatable/equatable.dart';

/// Core product entity used by domain and presentation layers.
class Product extends Equatable {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.rating,
  });

  /// Unique identifier of the product.
  final int id;

  /// Display title of the product.
  final String title;

  /// Product summary/details.
  final String description;

  /// Product price value.
  final num price;

  /// Thumbnail URL.
  final String thumbnail;

  /// Product rating score.
  final num rating;

  @override
  List<Object?> get props => <Object?>[
    id,
    title,
    description,
    price,
    thumbnail,
    rating,
  ];
}
