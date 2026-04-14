import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';
import 'package:equatable/equatable.dart';

/// UI-agnostic loading status for products flow.
enum ProductStatus { initial, loading, success, failure }

/// Immutable state for products BLoC.
class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <Product>[],
    this.errorMessage = '',
  });

  /// Current loading status.
  final ProductStatus status;

  /// Loaded products list.
  final List<Product> products;

  /// Error message when request fails.
  final String errorMessage;

  /// Returns a new state with selectively updated fields.
  ProductState copyWith({
    ProductStatus? status,
    List<Product>? products,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[status, products, errorMessage];
}
