import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/Services/address.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address/city.dart';
import 'package:CaterMe/model/address/country.dart';
import 'package:CaterMe/model/address/regular.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AdressProvider extends ChangeNotifier{

  // TextEditingController radioButton = TextEditingController();


  AddressService _addressService=AddressService();
List<Country> _listcountry=[];//<Country>
  List<City> _listcity=[];
  List<Address> _listaddress=[];
  Regular _regular=Regular();
List<String> _listnamenumber=[];
List<String> _listnameevent=[];
Address _addressCreated=Address();
  Address _addressUpdated=Address();

  Address get addressUpdated => _addressUpdated;

  set addressUpdated(Address value) {
    _addressUpdated = value;
  }

  bool _loading=false;


  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  int _valueIndex = -1;

  int get valueIndex => _valueIndex;

  set valueIndex(int value) {
    _valueIndex = value;
  }

  Address get addressCreated => _addressCreated;

  set addressCreated(Address value) {
    _addressCreated = value;
  }

  List<String> get listnamenumber => _listnamenumber;

  set listnamenumber(List<String> value) {
    _listnamenumber = value;
  }

  Regular get regular => _regular;

  set regular(Regular value) {
    _regular = value;
  }

  List<Address> get listaddress => _listaddress;

  set listaddress(List<Address> value) {
    _listaddress = value;
  }

  List<String> _listcountryname=[];//<Country>
List<String> _listcityname=[];

  List<String> get listcountryname => _listcountryname;

  set listcountryname(List<String> value) {
    _listcountryname = value;
  }


  List<Country> get listcountry => _listcountry;

  set listcountry(List<Country> value) {
    _listcountry = value;
  }

  TextEditingController addresstitlecontroller=TextEditingController();
  TextEditingController countrycontroller=TextEditingController();
  TextEditingController countrycontrollerstring=TextEditingController();
  TextEditingController citycontroller=TextEditingController();
  TextEditingController citycontrollerstring=TextEditingController();
  TextEditingController streetcontroller=TextEditingController();
  TextEditingController buildingcontroller=TextEditingController();
  TextEditingController floornumbercontroller=TextEditingController();
  TextEditingController longtituenumbercontroller=TextEditingController();
  TextEditingController latitudenumbercontroller=TextEditingController();



  TextEditingController eventnamecontroller=TextEditingController();
  TextEditingController evendatecontroller=TextEditingController();
  TextEditingController numberofguestcontroller=TextEditingController();
  TextEditingController numberofguestcontrollerstring=TextEditingController();
  TextEditingController typeofeventcontroller=TextEditingController();
  TextEditingController typeofeventcontrollerstring=TextEditingController();

clearAddressController(){

      addresstitlecontroller.clear();
      streetcontroller.clear();
      buildingcontroller.clear();
      floornumbercontroller.clear();
      latitudenumbercontroller.clear();
      longtituenumbercontroller.clear();
}
Future<String> deleteAddress(int id) async{
var em= await _addressService.deleteAddress(id);
notifyListeners();
return em.message;

}

  clearAllData(){
    eventnamecontroller.text = '';
    evendatecontroller.text = '';
    numberofguestcontroller.text = '';
    typeofeventcontroller.text = '';

    notifyListeners();
  }

//  String _cou

  List<City> get listcity => _listcity;

  set listcity( List<City> value) {
    _listcity = value;
  }

  List<String> get listcityname => _listcityname;

  set listcityname(List<String> value) {
    _listcityname = value;
  }

  int _id=0;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int _createOrUpdate=0;


  int get createOrUpdate => _createOrUpdate;

  set createOrUpdate(int value) {
    _createOrUpdate = value;
  }

  updateAddresss() async{

  _addressUpdated= await _addressService.updateAddress(
      id:id,
      addresstitle: addresstitlecontroller.text,
      country: countrycontroller.text,
      city: citycontroller.text,
      street: streetcontroller.text,
      building: buildingcontroller.text,
      floor: floornumbercontroller.text,
      longitude: longtituenumbercontroller.text,
      latitude: latitudenumbercontroller.text,
    );
  // _listaddress.insert(0,_addressCreated);
  _listaddress[valueIndex]=_addressUpdated;
  notifyListeners();


  }
  createAddress() async {

  _addressCreated=await  _addressService.createAddress(
        addresstitle: addresstitlecontroller.text,
        country: countrycontroller.text,
        city: citycontroller.text,
        street: streetcontroller.text,
        building: buildingcontroller.text,
        floor: floornumbercontroller.text,
    longitude: longtituenumbercontroller.text,
    latitude: latitudenumbercontroller.text,

    );
  _listaddress.insert(0,_addressCreated);
  notifyListeners();
  }
  bool _loadingCity=false;

  bool get loadingCity => _loadingCity;

  set loadingCity(bool value) {
    _loadingCity = value;
  }

  getallcity(int id) async {
    loadingCity=true;
     _listcity=await _addressService.getAllCity(id);
     List<String> l=[];
    for(int i=0;i<_listcity.length;i++){
      l.add(_listcity[i].name);
    }
     _listcityname=l;
    loadingCity=false;
    notifyListeners();
  }

  Future<void> getallcountry() async {
    _listcountry=await _addressService.getAllCountry();
    List<String> l=[];
    for(int i=0;i<_listcountry.length;i++){
      l.add(_listcountry[i].name);
    }
    _listcountryname=l;
    notifyListeners();
  }


  getAllAddress()async{
    _listaddress=await _addressService.getAllAddress();
    notifyListeners();
  }

  getRegular() async {
_regular=await _addressService.getRegular();
List<String> _listnamenumberi=[];
List<String> _listnameeventi=[];
for(int i=0;i<_regular.numberOfGuests.length;i++){
  _listnamenumberi.add(_regular.numberOfGuests[i].title);
}
for(int i=0;i<_regular.events.length;i++){
  _listnameeventi.add(_regular.events[i].name);
}
_listnamenumber=_listnamenumberi;
_listnameevent=_listnameeventi;

notifyListeners();
  }

  List<String> get listnameevent => _listnameevent;

  set listnameevent(List<String> value) {
    _listnameevent = value;
  }
}