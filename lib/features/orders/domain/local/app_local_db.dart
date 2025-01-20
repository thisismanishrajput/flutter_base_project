import '../../../../objectbox.g.dart';
import '../../../../services/object_box_service.dart';
import '../../data/model/order_model.dart';

class OrderDB {
  static final OrderDB _singleton = OrderDB._internal();

  factory OrderDB() {
    return _singleton;
  }

  OrderDB._internal();

  late Box<MyOrder> _orderBox;

  void init() {
    final store = ObjectBoxService.store;
    _orderBox = store.box<MyOrder>();
  }

  Future<int> insertOrder(MyOrder order) async {
    return _orderBox.put(order);
  }

  List<int> insertOrders(List<MyOrder> orders) {
    return _orderBox.putMany(orders);
  }

  MyOrder? getOrderById(int id) {
    return _orderBox.get(id);
  }

  List<MyOrder> getAllOrders() {
    return _orderBox.getAll();
  }

  void deleteOrder(int id) {
    _orderBox.remove(id);
  }

  void clearAllOrders() {
    _orderBox.removeAll();
  }
}
