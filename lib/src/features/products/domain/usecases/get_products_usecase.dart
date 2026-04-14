import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';
import 'package:clean_arch_base/src/features/products/domain/repositories/product_repository.dart';

/// Use case for fetching products from repository.
class GetProductsUsecase {
  const GetProductsUsecase({required ProductRepository repository})
    : _repository = repository;

  final ProductRepository _repository;

  /// Executes product loading operation.
  Future<Result<List<Product>>> call() {
    return _repository.getProducts();
  }
}
