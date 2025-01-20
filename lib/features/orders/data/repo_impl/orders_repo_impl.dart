import 'dart:async';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_base_project/features/orders/data/model/order_model.dart';
import 'package:flutter_base_project/features/orders/domain/repo/orders_repo.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

import '../../../../api_integration/api_constants.dart';
import '../../../../api_integration/dio_client.dart';
import '../../../../services/service_locator.dart';
import '../../domain/local/app_local_db.dart';

class OrdersRepoImpl extends OrdersRepo {
  final DioClient _dio = serviceLocator<DioClient>();
  final OrderDB _orderLocalDb = serviceLocator<OrderDB>();

  @override
  Future<Either<String, List<MyOrder>?>> fetchOrders() async {
    try {
      final result = await _dio.post(
        APIEndPoints.getBooking,
      );

      return result.fold((l) {
        return Left(l);
      }, (data) async {
        try {
          OrderModel response = OrderModel.fromJson(data);
          if (response.status ?? false) {
            // Save fetched data to local DB
            await _orderLocalDb.insertOrders(response.data);
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

  Future<Either<String, List<MyOrder>>> getLocalOrders() async {
    try {
      final localOrders = _orderLocalDb.getAllOrders();
      if (localOrders.isEmpty) {
        return const Left("No local data found");
      }
      return Right(localOrders);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
