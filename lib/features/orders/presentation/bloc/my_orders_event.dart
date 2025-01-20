

abstract class MyOrdersEvent {}


class GetMyUpcomingOrdersEvent extends MyOrdersEvent {}
class GetMyStartOrdersEvent extends MyOrdersEvent {}
class GetMyPendingOrders extends MyOrdersEvent {}
class GetMyCancelOrders extends MyOrdersEvent {}
class GetLocalOrders extends MyOrdersEvent {}
