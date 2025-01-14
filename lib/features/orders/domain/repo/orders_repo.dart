import 'package:fpdart/fpdart.dart';
import 'package:flutter_base_project/features/orders/data/model/order_model.dart';

abstract class OrdersRepo {
  Future<Either<String, List<MyOrder>?>> fetchOrders();
}

