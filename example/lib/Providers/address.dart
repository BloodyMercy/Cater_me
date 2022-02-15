
import 'package:CaterMe/Services/address.dart';
import 'package:CaterMe/Services/timeSpanService.dart';
import 'package:CaterMe/model/TimeSpanModel.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address/city.dart';
import 'package:CaterMe/model/address/country.dart';
import 'package:CaterMe/model/address/regular.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:flutter/cupertino.dart';

class AdressProvider extends ChangeNotifier{

  // TextEditingController radioButton = TextEditingController();


  AddressService _addressService=AddressService();
List<Country> _listcountry=[];//<Country>
  List<City> _listcity=[];
  List<FriendModel>Friends =[];
  List<Address> _listaddress=[];
  Regular _regular=Regular();
List<String> _listnamenumber=[];
List<String> _listnameevent=[];
Address _addressCreated=Address();
  Address _addressUpdated=Address();
String _eventname="";
  Address get addressUpdated => _addressUpdated;

  FriendModel _value=FriendModel() ;


  String get eventname => _eventname;

  set eventname(String value) {
    _eventname = value;
  }

  FriendModel get value => _value;

  set value(FriendModel value) {
    _value = value;
  }

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
  TextEditingController DailyDatecontroller=TextEditingController();
  TextEditingController numberofguestcontrollerstring=TextEditingController();
  TextEditingController typeofeventcontroller=TextEditingController();
  TextEditingController typeofeventcontrollerstring=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  timeSpanService _spanService =timeSpanService();
  bool load =true;
  timeSpanHours _hours= timeSpanHours();


  timeSpanService get spanService => _spanService;

  set spanService(timeSpanService value) {
    _spanService = value;
  }


  checktime() async{
    load=false;
    notifyListeners();

    _hours= await _spanService.gettimespan(evendatecontroller.text, DailyDatecontroller.text);
    load=true;
    notifyListeners();
  }
clearAddressController(){


       addresstitlecontroller.clear();
       countrycontroller.clear();
      countrycontrollerstring.clear();
       citycontroller.clear();
       citycontrollerstring.clear();
       streetcontroller.clear();
     buildingcontroller.clear();
       floornumbercontroller.clear();
       longtituenumbercontroller.clear();
      latitudenumbercontroller.clear();
       eventnamecontroller.clear();
       evendatecontroller.clear();
      numberofguestcontroller.clear();
       DailyDatecontroller.clear();
       numberofguestcontrollerstring.clear();
       typeofeventcontroller.clear();
      typeofeventcontrollerstring.clear();
       name.clear();
      phone.clear();
}
Future<String> deleteAddress(int id) async{
var em= await _addressService.deleteAddress(id);
notifyListeners();
return em.message;

}

  clearAllData(){
    eventnamecontroller.text = '';
    DailyDatecontroller.text='';
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




  AddressService get addressService => _addressService;

  set addressService(AddressService value) {
    _addressService = value;
  }



 static int _value2Index = 0;

  int get value2Index => _value2Index;

  set value2Index(int value) {
    _value2Index = value;
  }
  static int _value1Index = -1;

  int get value1Index => _value1Index;

  set value1Index(int value) {
    value1Index = value;
  }

  timeSpanHours get hours => _hours;

  set hours(timeSpanHours value) {
    _hours = value;
  }
}