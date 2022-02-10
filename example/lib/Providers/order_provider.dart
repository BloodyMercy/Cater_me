import 'dart:convert';


import 'package:CaterMe/Providers/address.dart';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/ItemsOrder.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:CaterMe/model/friend_model.dart';

import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderCaterProvider extends ChangeNotifier{
  List<ItemOrders> _itemOrders = [];
  List<FriendModel> _listFriend=[];
  List<FriendModel> _choosebillFriend=[];
  List<TextEditingController> _controllers = [];

  List<TextEditingController> get controllers => _controllers;

  set controllers(List<TextEditingController> value) {
    _controllers = value;
  }

  Future<CreditCardsModel> sendtokeknpayemnt(String a) async{

    CreditCardsModel card=new  CreditCardsModel();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request;

      request = http.MultipartRequest('POST', Uri.parse(ApiLink.AddCreditCards));
      request.fields.addAll({
        'token':a ,



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
      return card;
    }

  }
  Future<bool>  makeorder(String date,String type,String nb,String idcard)async {

    List<Map<String,dynamic>> mapitem=[];
    List<Map<String,dynamic>> mapitemf=[];
    for(int i=0;i<itemOrders.length;i++){
      
      mapitem.add({"id":itemOrders[i].id,"quantity":itemOrders[i].quantity});
    }
    for(int i=0;i<choosebillFriend.length;i++){

      mapitemf.add({"friendId":choosebillFriend[i].id,"amount":choosebillFriend[i].price});
    }

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request;

        request = http.MultipartRequest('POST', Uri.parse(ApiLink.makeorder));
      request.fields.addAll({
        'AddressId': value.id,
        'ServiceId': serviceId,
        "OrderItems":mapitem,
        "EventDate":date,
        "EventTypeId":type,
        "NumberOfGuests":nb,
        "PaymentFriend":mapitemf,

        "CardId":idcard,

      });

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        // List<dynamic> l = json.decode(response.body);
        // List<AddOn> ld=[];
        // for(int i=0;i<l.length;i++)
        //   ld.add(AddOn.fromJson(l[i]));

        // List<Cuisins> posts = List<Cuisins>.from(responseData['cuisine']['categories'].map((model)=> Cuisins.fromJson(model)));  //map to list
        return true;
      }
      else {
        print(response.reasonPhrase);
        return false;
      }
    }catch(e){
      return false;
    }
    notifyListeners();
    return true;
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
  int _tax =3;


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

  addItems(ItemOrders item){
    _itemOrders.add(item);
    subTotal=subTotal+item.totalprice;
    totale= subTotal+subTotal*tax/100;
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
    _itemOrders.remove(item);
    subTotal=subTotal-item.totalprice;
    totale= subTotal+subTotal*tax/100;
    notifyListeners();
  }
modifyItems(int count,int index){

    _itemOrders[index].quantity=count;
    subTotal=subTotal- _itemOrders[index].totalprice;
    _itemOrders[index].totalprice=count*_itemOrders[index].price;
   // _itemOrders.remove(item);
    subTotal=subTotal+(count*_itemOrders[index].price);
    totale= subTotal+subTotal*tax/100;
    notifyListeners();
  }
  modifyItemsmoins(int count,int index){

    _itemOrders[index].quantity=count;
    subTotal=subTotal- _itemOrders[index].totalprice;
    _itemOrders[index].totalprice=count*_itemOrders[index].price;
    // _itemOrders.remove(item);
    subTotal=subTotal+(count*_itemOrders[index].price);
    totale= subTotal+subTotal*tax/100;
    notifyListeners();
  }

  addfriendlist(FriendModel addedfriendlist){
    _listFriend.add(addedfriendlist);
    notifyListeners();
  }




  int _serviceId = 0;
int _spets = 1;
Address _value=Address();


Address get value => _value;

  set value(Address value) {
    _value = value;
  }




  int get spets => _spets;

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


}