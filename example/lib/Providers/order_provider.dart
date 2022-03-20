import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/Services/address.dart';
import 'package:CaterMe/Services/otpVerify.dart';
import 'package:CaterMe/Services/placeOrderId.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/setup_items_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/setup_items_model.dart';

class OrderCaterProvider extends ChangeNotifier{
  List<ItemOrders> _itemOrders = [];
  List<FriendModel> _listFriend=[];
  List<FriendModel> _choosebillFriend=[];
  List<TextEditingController> _controllers = [];
  List _setupItemModelId = [];
  //InAppWebViewController _webview=new InAppWebViewController();
  List get setupItemModelId => _setupItemModelId;

  set setupItemModelId(List value) {
    _setupItemModelId = value;
  }

  bool get checkotp => _checkotp;

  set checkotp(bool value) {
    _checkotp = value;
  }

  bool _checkotp=false;
  List<setupItemsModel> get setupItemmodel => _setupItemModelId;
  set setupItemmodel(List<setupItemsModel> value) {
    _setupItemModelId = value;
  }

  List<int> _setupOrderList=[];

  List<int> get setupOrderList => _setupOrderList;

  set setupOrderList(List<int> value) {
    _setupOrderList = value;
  }

  addid(int a){
    setupOrderList.add(a);
    notifyListeners();
}
removeid(int a){
    setupOrderList.remove(a);
    notifyListeners();
}

  int _orderid=0;
  Map<String,dynamic> _paymentverify={};
 int _otpVerify =0;

  bool _setup=false;


  bool get setup => _setup;

  set setup(bool value) {
    _setup = value;
    notifyListeners();
  }

  int get otpVerify => _otpVerify;

  set otpVerify(int value) {
    _otpVerify = value;
  }

  Map<String, dynamic> get paymentverify => _paymentverify;

  set paymentverify(Map<String, dynamic> value) {
    _paymentverify = value;
  }

  int get orderid => _orderid;

  set orderid(int value) {
    _orderid = value;
  }

  List<TextEditingController> get controllers => _controllers;
  double _vatshisha=0.0;

  int _totalssha=0;
bool _finaldonatesteps=false;
bool _finaldonatestepsCancel=false;

  bool get finaldonatestepsCancel => _finaldonatestepsCancel;

  set finaldonatestepsCancel(bool value) {
    _finaldonatestepsCancel = value;
  }

  bool get finaldonatesteps => _finaldonatesteps;

  set finaldonatesteps(bool value) {
    _finaldonatesteps = value;
  }



  int get totalssha => _totalssha;

  set totalssha(int value) {
    _totalssha = value;
  }

  set controllers(List<TextEditingController> value) {
    _controllers = value;
  }
  Future<bool> getdistance()async{
    return await PackageService.getDistance(value.id);

  }
updateprocefreind(double a,int index){
    print("i update");
    // // FriendModel f=new FriendModel();
    // f.id = choosebillFriend[index].id;
    // f.name= choosebillFriend[index].name;
    // f.email= choosebillFriend[index].email;
    // f.image= choosebillFriend[index].image;
    choosebillFriend[index].price=a;
   // choosebillFriend.removeAt(index);
   // choosebillFriend.insert(index, f);
    notifyListeners();


}
int _totalpackage=0;
int _totalshisha=0;

  int get totalpackage => _totalpackage;

  set totalpackage(int value) {
    _totalpackage = value;
  }

  double get vatshisha => _vatshisha;
  double _vatfood=0.0;

  double get vatfood => _vatfood;

  set vatfood(double value) {
    _vatfood = value;
  }

  set vatshisha(double value) {
    _vatshisha = value;
  }

  Future<CreditCardsModel> sendtokeknpayemnt(String a,String name,String cvv) async{

    CreditCardsModel card=new  CreditCardsModel();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request;

      request = http.MultipartRequest('POST', Uri.parse(ApiLink.AddCreditCards));
      request.fields.addAll({
        'token':a.toString() ,
        "name":name,
        "cvv":cvv



      });

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
       Map<String,dynamic> responseData = json.decode(response.body);
       card=CreditCardsModel.fromJson(responseData);  //map to list
       // return posts;
    return card;
      }
      else {
        print(response.reasonPhrase);
        return card;
      }
    }catch(e){
      print(e.toString()) ;
      return card;
    }

  }
  Future<int>  makeorder({String date,String time,String type,String nb,String idcard ,String contactname,String contactphone ,String eventname,String eventtime,bool bool1,bool bool2,bool bool3,})async {

    List<Map<String,dynamic>> mapitem=[];
    List<Map<String,dynamic>> mapitemf=[];
  //  Strinmapitems="[\r\n ";
    for(int i=0;i<itemOrders.length;i++){

      mapitem.add(
          {"itemId":itemOrders[i].id,
            "quantity":itemOrders[i].quantity}
      );
    }
    for(int i=0;i<choosebillFriend.length;i++) {
      if(choosebillFriend[i].id==-69){}else{
        if (controllers[i].text.isEmpty || controllers[i].text == null ||
            controllers[i].text == "0") {
          controllers.removeAt(i);
          choosebillFriend.removeAt(i);
        }

        mapitemf.add({
          "friendId": choosebillFriend[i].id,
          "amount": int.parse(controllers[i].text)
        });
      }  }

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}','Content-Type': 'application/json'   };
      var request;

        request = http.Request('POST', Uri.parse(ApiLink.makeorder));

      request.body = json.encode({
        "addressId": value.id,
        "serviceId": serviceId,
        "orderItems": mapitem,
        "event": {
          "eventName": eventname,
          "eventDate":date,
          "eventTime":eventtime,


          "eventTypeId":1,
          "numberOfGuestsId": int.parse(nb),
          "contactPersonName":contactname??"",
          "contactPersonPhoneNumber":contactphone??"",

        },
        "setupItems":setupItemModelId,
        "paymentFriend": mapitemf,
        //"cardId": idcard,
        "isDonatingFood": bool3,
        "isNeedChair": bool2,
        "isNeedTables": bool2,
        "isNeedCateringService": bool1,

      });

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
    String responseData = response.body;
        // List<dynamic> l = json.decode(response.body);
        // List<AddOn> ld=[];
        // for(int i=0;i<l.length;i++)
        //   ld.add(AddOn.fromJson(l[i]));
        var i=responseData;
orderid=int.parse(i);
        // List<Cuisins> posts = List<Cuisins>.from(responseData['cuisine']['categories'].map((model)=> Cuisins.fromJson(model)));  //map to list
        return int.parse(i);
      }
      else {
        print(response.reasonPhrase);
        return 0;
      }
    }catch(e){
      //print()
      return 0;
    }
    // notifyListeners();
    // return 0;
  }

  getPlaceOrderId(String id1,String id2) async{

    paymentverify=await placeOrderId.PlaceOrderId(id1, id2);
    notifyListeners();
  }

  getotpverify(String a) async{

    otpVerify = await OtpVerify.Otpverify(paymentverify["orderId"].toString(),a);
    notifyListeners();
  }


  addcontroller(TextEditingController t){
    controllers.add(t);
    notifyListeners();
  }
  List<FriendModel> get choosebillFriend => _choosebillFriend;

  set choosebillFriend(List<FriendModel> value) {
    _choosebillFriend = value;
  }

  double _subTotal = 0;
  double _totale = 0;
  double _totalefreind = 0;

  double get totalefreind => _totalefreind;

  set totalefreind(double value) {
    _totalefreind = value;
  }

  int _tax =15;


  int get tax => _tax;

  set tax(int value) {
    _tax = value;
  }

  double get totale => _totale;

  set totale(double value) {
    _totale = value;
  }

  double get subTotal => _subTotal;

  set subTotal(double value) {
    _subTotal = value;
  }

  List<FriendModel> get listFriend => _listFriend;

  set listFriend(List<FriendModel> value) {
    _listFriend = value;
  }



  List<ItemOrders> get itemOrders => _itemOrders;

  set itemOrders(List<ItemOrders> value) {
    _itemOrders = value;
  }

  addItems(ItemOrders item,bool a){

   // subTotal=subTotal+item.totalprice;
    totale= totale+item.totalprice;
    if(a) {
      vatshisha = vatshisha + item.tax;
      item.isShisha=true;
    }
    else {
      vatfood = vatfood + item.tax;
      item.isShisha=false;
    }
    _itemOrders.add(item);
    notifyListeners();
  }

  addfriend(FriendModel item){
    _choosebillFriend.add(item);

    notifyListeners();
  }
 removefriend(FriendModel item){
    _choosebillFriend.remove(item);

    notifyListeners();
  }
  addprice(int index,double price){

    _choosebillFriend[index].price=price;
    notifyListeners();

  }

 removeItems(ItemOrders item){
    if(item.ispack)
      totalpackage=totalpackage-1;
   if(item.isShisha) {
      totalssha = totalssha- item.quantity;
    }


    _itemOrders.remove(item);
    if(item.isShisha)
      vatshisha=vatshisha-item.tax;
    else
      vatfood=vatfood-item.tax;
    totale= totale-item.totalprice;
    notifyListeners();
  }
modifyItems(int count,int index){
  // if(  _itemOrders[index].ispack)
  //   totalpackage=totalpackage-1;
  // if(  _itemOrders[index].isShisha) {
  //   totalssha = totalssha- item.quantity;
  // }
  _itemOrders[index].quantity=count;
  totale= totale-  _itemOrders[index].totalprice;
  _itemOrders[index].totalprice=count*_itemOrders[index].price;
  // _itemOrders.remove(item);
  // subTotal=subTotal+(count*_itemOrders[index].price);
  totale= totale+  _itemOrders[index].totalprice;
  notifyListeners();
  }
  modifyItemsmoins(int count,int index){

    _itemOrders[index].quantity=count;
    totale= totale-  _itemOrders[index].totalprice;
    _itemOrders[index].totalprice=count*_itemOrders[index].price;
    // _itemOrders.remove(item);
   // subTotal=subTotal+(count*_itemOrders[index].price);
    totale= totale+  _itemOrders[index].totalprice;
    notifyListeners();
  }

  addfriendlist(FriendModel addedfriendlist){
    _listFriend.add(addedfriendlist);
    notifyListeners();
  }




  int _serviceId = 1;
int _spets = 1;
Address _value=Address();


Address get value => _value;

  set value(Address value) {
    _value = value;
  }




  int get spets => _spets;
bool _paymemtstep=false;

  bool get paymemtstep => _paymemtstep;

  set paymemtstep(bool value) {
    _paymemtstep = value;
    notifyListeners();

  }

  set spets(int value) {
    _spets = value;
    notifyListeners();
  }

  int get serviceId => _serviceId;

  set serviceId(int value) {
    _serviceId = value;
  }

  int _valueIndex = -1;

  int get valueIndex => _valueIndex;

  set valueIndex(int value) {
    _valueIndex = value;
  }

  int get totalshisha => _totalshisha;

  set totalshisha(int value) {
    _totalshisha = value;
  }
}