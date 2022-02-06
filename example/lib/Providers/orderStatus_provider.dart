import 'package:CaterMe/Services/orderStatus.dart';
import 'package:CaterMe/model/orderByIdStatus_model.dart';
import 'package:flutter/cupertino.dart';

class OrderStatusProvider extends ChangeNotifier{
  StatusOrderService _orderService=StatusOrderService();
  OrderByIdStatusModel _orderStatus=OrderByIdStatusModel();

  OrderByIdStatusModel get orderStatus => _orderStatus;

  set orderStatus(OrderByIdStatusModel value) {
    _orderStatus = value;
  }

  getOrderStatus(int id) async{
    _orderStatus = await _orderService.getOrderStatus(id);
    notifyListeners();
  }
}