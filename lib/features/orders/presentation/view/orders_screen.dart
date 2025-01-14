import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_bloc.dart';
import 'package:flutter_base_project/features/orders/presentation/bloc/my_orders_event.dart';
import 'package:flutter_base_project/features/orders/presentation/widget/cancel_orders.dart';
import 'package:flutter_base_project/features/orders/presentation/widget/pending_orders.dart';
import 'package:flutter_base_project/features/orders/presentation/widget/start_orders.dart';
import 'package:flutter_base_project/features/orders/presentation/widget/upcoming_orders.dart';
import 'package:flutter_base_project/utility/constants/color_constants.dart';
import 'package:flutter_base_project/utility/constants/string_constants.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});
  static const String path = '/orders';
  static const String routeName = 'orders';
  @override
  OrdersScreenState createState() => OrdersScreenState();
}

class OrdersScreenState extends State<OrdersScreen> {
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    context.read<MyOrdersBloc>().add(GetMyUpcomingOrdersEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kOrders),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width,
              child: IntrinsicWidth(
                child: Center(
                  child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: ColorConst.colorPrimary,
                    indicatorPadding: EdgeInsets.zero,
                    unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    indicatorWeight: 2,
                    tabs: const [
                      Tab(child: Text(kUpcoming),),
                      Tab(child: Text(kStart),),
                      Tab(child: Text(kPending),),
                      Tab(child: Text(kStart),),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: const [
                  UpcomingOrders(),
                  StartOrders(),
                  PendingOrders(),
                  CancelOrders()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
