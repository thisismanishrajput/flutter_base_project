import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/features/orders/data/model/order_model.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_bloc.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_event.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_status.dart';
import 'package:flutter_base_project/features/orders/presentation/widget/orders_card_widget.dart';
import 'package:flutter_base_project/utility/common_widgets/no_data_found.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';
import 'package:flutter_base_project/utility/custom_progress_indicator.dart';


class CancelOrders extends StatefulWidget {
  const CancelOrders({super.key});

  @override
  State<CancelOrders> createState() => _CancelOrdersState();
}

class _CancelOrdersState extends State<CancelOrders> {

  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyCancelOrders());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, upComingOrderState) {
        if (upComingOrderState.upcomingMyOrdersStatus == StateUpdateStatus.updating) {
          return const CustomProgressIndicator(loadingText: kPleaseWait);
        } else {
          if(upComingOrderState.cancelOrders != null && upComingOrderState.cancelOrders!.isEmpty){
            return NoDataWidget(
              message: kNoDataFound,
              onRetry: (){
                context.read<MyOrdersBloc>().add(GetMyUpcomingOrdersEvent());
              },
            );
          }
          return RefreshIndicator(
            onRefresh: ()async=>context.read<MyOrdersBloc>().add(GetMyUpcomingOrdersEvent()),
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: upComingOrderState.cancelOrders?.length,
              itemBuilder: (context, index) {
                MyOrder? myOrder = upComingOrderState.cancelOrders?[index];
                return orderCard(myOrder: myOrder);
              },
            ),
          );
        }
      },
    );
  }
}
