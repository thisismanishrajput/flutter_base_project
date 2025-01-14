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

class UpcomingOrders extends StatefulWidget {
  const UpcomingOrders({super.key});

  @override
  State<UpcomingOrders> createState() => _UpcomingOrdersState();
}

class _UpcomingOrdersState extends State<UpcomingOrders> {

  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyUpcomingOrdersEvent());
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<MyOrdersBloc, MyOrdersState>(
      builder: (context, upComingOrderState) {
        if (upComingOrderState.upcomingMyOrdersStatus == StateUpdateStatus.updating) {
          return const CustomProgressIndicator(loadingText: kPleaseWait);
        } else {
          if(upComingOrderState.upcomingOrders != null && upComingOrderState.upcomingOrders!.isEmpty){
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
              itemCount: upComingOrderState.upcomingOrders?.length,
              itemBuilder: (context, index) {
                MyOrder? myOrder = upComingOrderState.upcomingOrders?[index];
                return orderCard(myOrder: myOrder);
              },
            ),
         );
        }
      },
    );
  }
}
