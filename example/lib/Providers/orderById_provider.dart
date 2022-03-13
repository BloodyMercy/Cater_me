import 'package:CaterMe/Services/orderById.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:flutter/cupertino.dart';

class OrderByIdProvider extends ChangeNotifier{
  OrderByIdService _orderByIdService=OrderByIdService();
  List<OrderDetailsModel> _orderListDetails=[];
bool _check1 =false ;
bool _check2 =false ;
bool _check3 =false ;
bool _check4 =false ;

  OrderByIdService get orderByIdService => _orderByIdService;

  set orderByIdService(OrderByIdService value) {
    _orderByIdService = value;
  }

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

  getOrderById(int id,) async{
    orderbyId= await _orderByIdService.getOrdersDetailsById(id);
    notifyListeners();
  }

  Future getOrderItems(String a) async{

    if(orderbyId['orderItems'].length!=0){
      _items=List<OrderItems>.from(orderbyId['orderItems'].map((model)=> OrderItems.fromJson(model,a)));
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
  bool donate= await _orderByIdService.Donate(id,check1,check2,check3,check4);
   notifyListeners();
   return donate;
  }

  bool get check1 => _check1;

  set check1(bool value) {
    _check1 = value;
    notifyListeners();
  }

  bool get check2 => _check2;

  set check2(bool value) {
    _check2 = value;
    notifyListeners();
  }

  bool get check3 => _check3;

  set check3(bool value) {
    _check3 = value;
    notifyListeners();
  }

  bool get check4 => _check4;

  set check4(bool value) {
    _check4 = value;
    notifyListeners();
  }
}