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



  List<OrderItems> _items=[];


  List<OrderItems> get items => _items;

  set items(List<OrderItems> value) {
    _items = value;
  }

  List<PaymentFriend> _paymentFreind=[];

  List<PaymentFriend> get paymentFreind => _paymentFreind;

  set paymentFreind(List<PaymentFriend> value) {
    _paymentFreind = value;
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
Map<String,dynamic> _orderbyId={};

  Map<String, dynamic> get orderbyId => _orderbyId;

  set orderbyId(Map<String, dynamic> value) {
    _orderbyId = value;
  }

  getOrderById(int id) async{
    orderbyId= await _orderByIdService.getOrdersDetailsById(id);
    notifyListeners();
  }

  Future getOrderItems() async{

    if(orderbyId['orderItems'].length!=0){
      _items=List<OrderItems>.from(orderbyId['orderItems'].map((model)=> OrderItems.fromJson(model)));
     // return orderbyId['orderItems'].forEach((element) {
     //    items.add(element);
     //
     //  });
    }else{

      return _items=[];
    }

  }
  Future getOrderPaymentFreind() async{
paymentFreind=[];

    if(orderbyId["paymentFriend"]!=0){
      paymentFreind=List<PaymentFriend>.from(orderbyId["paymentFriend"].map((model)=>PaymentFriend.fromJson(model)));

    }else{
      return paymentFreind=[];
    }
  }


  clearData(){
    _orderListDetails=[];
    notifyListeners();
  }
bool _buttonDonate=false;

  bool get buttonDonate => _buttonDonate;

  set buttonDonate(bool value) {
    _buttonDonate = value;
  }

  bool _textDonate=false;

  bool get textDonate => _textDonate;

  set textDonate(bool value) {
    _textDonate = value;
  }

  donate(int id) async{
  bool donate= await _orderByIdService.Donate(id);
   notifyListeners();
   return donate;
  }
}