import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_base_project/features/orders/data/model/order_model.dart';
import 'package:flutter_base_project/features/orders/domain/repo/orders_repo.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

import '../../../../api_integration/api_constants.dart';
import '../../../../api_integration/dio_client.dart';
import '../../../../services/service_locator.dart';

class OrdersRepoImpl extends OrdersRepo {
  final DioClient _dio = serviceLocator<DioClient>();

  @override
  Future<Either<String, List<MyOrder>?>> fetchOrders() async {
    try {
      final result = await _dio.post(
        APIEndPoints.getBooking,
      );

      return result.fold((l) {
        return Left(l);
      }, (data) {
        try {
          OrderModel response = OrderModel.fromJson(data);
          if (response.status ?? false) {
            return Right(response.data);
          } else {
            return Left(response.message ?? kSomethingWentWrong);
          }
        } catch (e) {
          return Left(e.toString());
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }


}
