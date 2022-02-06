import 'package:CaterMe/Services/orderById.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:flutter/cupertino.dart';

class OrderByIdProvider extends ChangeNotifier{
  OrderByIdService _orderByIdService=OrderByIdService();

  List<OrderByIdModel> _orderList=[];


  List<OrderByIdModel> get orderList => _orderList;

  set orderList(List<OrderByIdModel> value) {
    _orderList = value;
  }

  getOrderById(int id) async{
    _orderList= await _orderByIdService.getOrdersById(id);
    notifyListeners();
  }

  clearData(){
    _orderList=[];
    notifyListeners();
  }
}