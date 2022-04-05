import 'package:CaterMe/Services/order.dart';
import 'package:CaterMe/Services/placeOrderId.dart';
import 'package:CaterMe/model/order_model.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier{

  OrderServices _orderServices=OrderServices();
  List<OrderModel> _listOrder=[];



  List<OrderModel> get listOrder => _listOrder;

  set listOrder(List<OrderModel> value) {
    _listOrder = value;
  }
deleteorder(int index)async{
  if(await _orderServices.deleteorder(_listOrder[index].id.toString())){
    _listOrder.removeAt(index);
    notifyListeners();
    return true;
  }else{
    return false ;
  }
}
  getAllOrders() async{
    _listOrder=[];
    _listOrder=await _orderServices.getAllOrders();
    notifyListeners();
  }



  clearData(){
    _listOrder=[];
    notifyListeners();
  }
}