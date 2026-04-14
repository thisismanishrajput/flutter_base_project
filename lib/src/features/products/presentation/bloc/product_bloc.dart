import 'package:clean_arch_base/src/core/utils/result.dart';
import 'package:clean_arch_base/src/features/products/domain/entities/product.dart';
import 'package:clean_arch_base/src/features/products/domain/usecases/get_products_usecase.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_event.dart';
import 'package:clean_arch_base/src/features/products/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Coordinates products screen state using domain use case output.
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({required GetProductsUsecase getProductsUsecase})
    : _getProductsUsecase = getProductsUsecase,
      super(const ProductState()) {
    on<FetchProducts>(_onFetchProducts);
  }

  final GetProductsUsecase _getProductsUsecase;

  /// Handles product loading event and emits loading/success/failure states.
  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.loading, errorMessage: ''));
    final Result<List<Product>> result = await _getProductsUsecase();

    result.when(
      success: (List<Product> products) {
        emit(state.copyWith(status: ProductStatus.success, products: products));
      },
      failure: (failure) {
        emit(
          state.copyWith(
            status: ProductStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
    );
  }
}
