import 'package:CaterMe/Services/orderById.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:flutter/cupertino.dart';

class OrderByIdProvider extends ChangeNotifier{
  OrderByIdService _orderByIdService=OrderByIdService();
  List<OrderDetailsModel> _orderListDetails=[];

  OrderDetailsModel _orderDetails=OrderDetailsModel();


  OrderDetailsModel get orderDetails => _orderDetails;

  set orderDetails(OrderDetailsModel value) {
    _orderDetails = value;
  }

  List<PaymentFriend> _payment=[];

  List<OrderItems> _items=[];


  List<OrderItems> get items => _items;

  set items(List<OrderItems> value) {
    _items = value;
  }

  List get payment => _payment;

  set payment(List value) {
    _payment = value;
  }

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

  Future getOrderItems() async{
    if(_orderListDetails[0].orderItems.length!=0){
     return _orderListDetails[0].orderItems.forEach((element) {
        items.add(element);
      });
    }else{
      return _items=[];
    }
    notifyListeners();
  }


  getOrderPayment() {
   if (_orderListDetails[0].paymentFriend.length != 0){
     _orderListDetails[0].paymentFriend.forEach((element) {
       _payment.add(element);
      });
    }else{
     return _payment=[];
   }
   notifyListeners();
  }

  clearData(){
    _orderListDetails=[];
    notifyListeners();
  }
}