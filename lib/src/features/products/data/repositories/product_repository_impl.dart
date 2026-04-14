import 'package:clean_arch_base/src/core/constants/app_strings.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:clean_arch_base/src/core/error/failures.dart';
import 'package:clean_arch_base/src/core/network/network_info.dart';
import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/products/data/datasources/product_remote_datasource.dart';
import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';
import 'package:clean_arch_base/src/features/products/domain/repositories/product_repository.dart';

/// Repository implementation that bridges domain contracts and data sources.
class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  final ProductRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<List<Product>>> getProducts() async {
    // Fail fast when internet is unavailable.
    if (!await _networkInfo.isConnected) {
      return const FailureResult<List<Product>>(NoInternetFailure());
    }

    try {
      final products = await _remoteDataSource.getProducts();
      return Success<List<Product>>(products);
      // Map low-level exceptions to domain failures.
    } on NoInternetException catch (error) {
      return FailureResult<List<Product>>(NoInternetFailure(error.message));
    } on ServerException catch (error) {
      return FailureResult<List<Product>>(ServerFailure(error.message));
    } on AppException catch (error) {
      return FailureResult<List<Product>>(UnknownFailure(error.message));
    } catch (_) {
      return const FailureResult<List<Product>>(
        UnknownFailure(AppStrings.unexpectedProductsError),
      );
    }
  }
}
