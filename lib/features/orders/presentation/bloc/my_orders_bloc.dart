import 'dart:async';
import 'package:flutter_base_project/features/orders/domain/local/app_local_db.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/features/orders/data/model/order_model.dart';
import 'package:flutter_base_project/features/orders/domain/repo/orders_repo.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_event.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_status.dart';
import 'package:flutter_base_project/services/service_locator.dart';
import 'package:flutter_base_project/utility/utility_function.dart';

class MyOrdersBloc extends Bloc<MyOrdersEvent, MyOrdersState> {
  final OrderDB orderLocalDb = serviceLocator<OrderDB>();
  MyOrdersBloc() : super(const MyOrdersState()) {
    on<GetMyUpcomingOrdersEvent>(_getUpcomingOrders);
    on<GetMyStartOrdersEvent>(_getStartOrders);
    on<GetMyPendingOrders>(_getPendingOrders);
    on<GetMyCancelOrders>(_getCancelOrders);
    on<GetLocalOrders>(_getLocalOrders);
  }

  final OrdersRepo _ordersRepo = serviceLocator<OrdersRepo>();

  FutureOr<void> _getUpcomingOrders(GetMyUpcomingOrdersEvent event, Emitter<MyOrdersState> emit) async {
    emit(state.copyWith(upcomingMyOrdersStatus: StateUpdateStatus.updating));

    final res = await _ordersRepo.fetchOrders();

    res.fold((left) {
      UtilityFunction.instance.showToast(left, level: ToastLevel.error);
      emit(state.copyWith(upcomingMyOrdersStatus: StateUpdateStatus.failed));
    }, (orders) {
      emit(state.copyWith(
        upcomingMyOrdersStatus: StateUpdateStatus.success,
        upcomingOrders: orders?.where((order) => order.status == "0").toList(),
        allOrders: orders, // Save all orders for further filtering
      ));
    });
  }

  FutureOr<void> _getLocalOrders(GetLocalOrders event, Emitter<MyOrdersState> emit) async {
    final res = await _ordersRepo.getLocalOrders();

    res.fold((left) {
      UtilityFunction.instance.showToast(left, level: ToastLevel.error);
      emit(state.copyWith(upcomingMyOrdersStatus: StateUpdateStatus.failed));
    }, (localOrders) {
      emit(state.copyWith(
        allOrders: localOrders,
        upcomingMyOrdersStatus: StateUpdateStatus.success,
      ));
    });
  }


  void _filterOrdersByStatus(
      Emitter<MyOrdersState> emit,
      String statusCode,
      StateUpdateStatus Function(MyOrdersState) statusSelector,
      MyOrdersState Function(MyOrdersState, List<MyOrder>?) updateState,
      ) {
    final allOrders = state.allOrders; // Access all orders from the state
    if (allOrders != null) {
      final filteredOrders = allOrders.where((order) => order.status == statusCode).toList();
      emit(updateState(state, filteredOrders));
    } else {
      emit(state.copyWith(upcomingMyOrdersStatus: StateUpdateStatus.failed));
    }
  }

  FutureOr<void> _getStartOrders(GetMyStartOrdersEvent event, Emitter<MyOrdersState> emit) async {
    _filterOrdersByStatus(
      emit,
      "1", // Status code for "Start"
          (s) => s.startMyOrdersStatus,
          (s, orders) => s.copyWith(
        startMyOrdersStatus: StateUpdateStatus.success,
        startOrders: orders,
      ),
    );
  }

  FutureOr<void> _getPendingOrders(GetMyPendingOrders event, Emitter<MyOrdersState> emit) async {
    _filterOrdersByStatus(
      emit,
      "2", // Status code for "Pending"
          (s) => s.pendingMyOrdersStatus,
          (s, orders) => s.copyWith(
        pendingMyOrdersStatus: StateUpdateStatus.success,
        pendingOrders: orders,
      ),
    );
  }

  FutureOr<void> _getCancelOrders(GetMyCancelOrders event, Emitter<MyOrdersState> emit) async {
    _filterOrdersByStatus(
      emit,
      "3", // Status code for "Cancel"
          (s) => s.cancelMyOrdersStatus,
          (s, orders) => s.copyWith(
        cancelMyOrdersStatus: StateUpdateStatus.success,
        cancelOrders: orders,
      ),
    );
  }
}
