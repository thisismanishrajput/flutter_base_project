import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';

/// Domain contract for product retrieval.
abstract class ProductRepository {
  /// Returns products as success/failure [Result].
  Future<Result<List<Product>>> getProducts();
}
