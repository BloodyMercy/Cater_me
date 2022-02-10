import 'package:CaterMe/Services/orderById.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:flutter/cupertino.dart';

class OrderByIdProvider extends ChangeNotifier{
  OrderByIdService _orderByIdService=OrderByIdService();
  List<OrderDetailsModel> _orderListDetails=[];

  List<OrderDetailsModel> get orderListDetails => _orderListDetails;

  set orderListDetails(List<OrderDetailsModel> value) {
    _orderListDetails = value;
  }

  // List<OrderByIdModel> _orderList=[];
  //
  //
  // List<OrderByIdModel> get orderList => _orderList;
  //
  // set orderList(List<OrderByIdModel> value) {
  //   _orderList = value;
  // }

  getOrderById(int id) async{
    _orderListDetails= await _orderByIdService.getOrdersDetailsById(id);
    notifyListeners();
  }

  clearData(){
    _orderListDetails=[];
    notifyListeners();
  }
}