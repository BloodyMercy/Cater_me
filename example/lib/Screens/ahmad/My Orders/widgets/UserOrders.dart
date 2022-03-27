import 'ItemDetails.dart';

class UserOrder {
  final ItemsOrderedDetails order;

  UserOrder({this.order});
}

List<UserOrder> DemoOrderList = [
  UserOrder(order: Items[0]),
  UserOrder(order: Items[1]),
  UserOrder(order: Items[2]),
  UserOrder(order: Items[3]),
];
