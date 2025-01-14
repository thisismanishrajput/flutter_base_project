import 'package:flutter_base_project/features/orders/data/model/order_model.dart';

import 'package:equatable/equatable.dart';

enum StateUpdateStatus { none, updating, success, failed }


class MyOrdersState extends Equatable {
  final List<MyOrder>? allOrders;
  final List<MyOrder>? upcomingOrders;
  final List<MyOrder>? startOrders;
  final List<MyOrder>? pendingOrders;
  final List<MyOrder>? cancelOrders;

  final StateUpdateStatus upcomingMyOrdersStatus;
  final StateUpdateStatus startMyOrdersStatus;
  final StateUpdateStatus pendingMyOrdersStatus;
  final StateUpdateStatus cancelMyOrdersStatus;

  const MyOrdersState({
    this.allOrders,
    this.upcomingOrders,
    this.startOrders,
    this.pendingOrders,
    this.cancelOrders,
    this.upcomingMyOrdersStatus = StateUpdateStatus.none,
    this.startMyOrdersStatus = StateUpdateStatus.none,
    this.pendingMyOrdersStatus = StateUpdateStatus.none,
    this.cancelMyOrdersStatus = StateUpdateStatus.none,
  });

  MyOrdersState copyWith({
    List<MyOrder>? allOrders,
    List<MyOrder>? upcomingOrders,
    List<MyOrder>? startOrders,
    List<MyOrder>? pendingOrders,
    List<MyOrder>? cancelOrders,
    StateUpdateStatus? upcomingMyOrdersStatus,
    StateUpdateStatus? startMyOrdersStatus,
    StateUpdateStatus? pendingMyOrdersStatus,
    StateUpdateStatus? cancelMyOrdersStatus,
  }) {
    return MyOrdersState(
      allOrders: allOrders ?? this.allOrders,
      upcomingOrders: upcomingOrders ?? this.upcomingOrders,
      startOrders: startOrders ?? this.startOrders,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      cancelOrders: cancelOrders ?? this.cancelOrders,
      upcomingMyOrdersStatus: upcomingMyOrdersStatus ?? this.upcomingMyOrdersStatus,
      startMyOrdersStatus: startMyOrdersStatus ?? this.startMyOrdersStatus,
      pendingMyOrdersStatus: pendingMyOrdersStatus ?? this.pendingMyOrdersStatus,
      cancelMyOrdersStatus: cancelMyOrdersStatus ?? this.cancelMyOrdersStatus,
    );
  }

  @override
  List<Object?> get props => [
    allOrders,
    upcomingOrders,
    startOrders,
    pendingOrders,
    cancelOrders,
    upcomingMyOrdersStatus,
    startMyOrdersStatus,
    pendingMyOrdersStatus,
    cancelMyOrdersStatus,
  ];
}
