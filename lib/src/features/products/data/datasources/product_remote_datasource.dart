import 'package:clean_arch_base/src/core/constants/api_endpoints.dart';
import 'package:clean_arch_base/src/core/error/error_handler.dart';
import 'package:clean_arch_base/src/core/error/exceptions.dart';
import 'package:clean_arch_base/src/features/products/data/models/product_model.dart';
import 'package:dio/dio.dart';

/// Remote data source contract for products API.
abstract class ProductRemoteDataSource {
  /// Fetches and parses products from backend.
  Future<List<ProductModel>> getProducts();
}

/// Dio implementation of [ProductRemoteDataSource].
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get<dynamic>(ApiEndpoints.products);
      final data = response.data;

      // Validate top-level payload shape before parsing models.
      if (data is! Map<String, dynamic>) {
        throw const UnknownException('Invalid API response format.');
      }

      final rawProducts = data['products'];

      // Ensure products key is a list before mapping.
      if (rawProducts is! List<dynamic>) {
        throw const UnknownException('Products list not found in response.');
      }

      return rawProducts
          .whereType<Map<String, dynamic>>()
          .map(ProductModel.fromJson)
          .toList();
    } on DioException catch (error) {
      throw ErrorHandler.fromDioException(error);
    }
  }
}
