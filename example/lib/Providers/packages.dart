
import 'package:CaterMe/Screens/auth/login_screen.dart';
import 'package:CaterMe/Screens/auth/newlogin/screens/loginScreen.dart';
import 'package:CaterMe/Services/HomePage/PackageService.dart';
import 'package:CaterMe/model/Cuisines.dart';
import 'package:CaterMe/model/addons/addonsall.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/package.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackagesProvider extends  ChangeNotifier{


Packages _packages=new Packages();
 List<Package> _allpackages=[];
 List<Package> _allpackagesorder=[];
 Cuisines _cuisins=Cuisines();
int _selectedIndex= 0;
List<Package> get allpackagesorder => _allpackagesorder;

  set allpackagesorder(List<Package> value) {
    _allpackagesorder = value;
  }

  List<Package> get allpackages => _allpackages;

  set allpackages(List<Package> value) {
    _allpackages = value;
  }

  List<Cuisins> _allcuisins=[];
List<Package> _allons=[];
List<Package> _allonsorder=[];
Map<String, dynamic> _alldata={};
List<Package> _listItems=[];


List<Package> get listItems => _listItems;

  set listItems(List<Package> value) {
    _listItems = value;
  }

  List<Package> get allonsorder => _allonsorder;

  set allonsorder(List<Package> value) {
    _allonsorder = value;
  }

  TextEditingController controllersearch=TextEditingController();


List<Package> get allons => _allons;

  set allons(List<Package> value) {
    _allons = value;
  }

  Packages get packages => _packages;

  set packages(Packages value) {
    _packages = value;
  }

  List<Addonall> _addonsall=[];
  List<Addonall> _addonsallorder=[];

int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

  List<Occasion> _occasions=[];
List<Occasion> _alloccasions=[];
List<Package> _listfavorite=[];

List<Occasion> get alloccasions => _alloccasions;

  set alloccasions(List<Occasion> value) {
    _alloccasions = value;
  }

  List<Package> get listfavorite => _listfavorite;

  set listfavorite(List<Package> value) {
    _listfavorite = value;
  }

  List<Occasion> get occasions => _occasions;

  set occasions(List<Occasion> value) {
    _occasions = value;
  }

  List<Addonall> get addonsall => _addonsall;

set addonsall(List<Addonall> value) {
  _addonsall = value;
}

Map<String, dynamic> get alldata => _alldata;

  set alldata(Map<String, dynamic> value) {
    _alldata = value;
  }





bool _loading=false;


bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }



String _nbnotification="";


String get nbnotification => _nbnotification;

  set nbnotification(String value) {
    _nbnotification = value;
  }
Future<void>  getallpacakgesorder(int id,int id2)async {
  loading=false;
//notifyListeners();
  _alldata=await PackageService.getPackagesrder(id,id2);


    if( _alldata['packages']!=null) {
      //   _packages = Packages.fromJson( _alldata['packages']);
      // if(_alldata['cuisine']!=null)
      // _cuisins = Cuisines.fromJson(_alldata['cuisine']);
      _addonsallorder = List<Addonall>.from(
          _alldata['addons'].map((model) => Addonall.fromJson(model)));
      //  _occasions = List<Occasion>.from(_alldata['occasions'].map((model) => Occasion.fromJson(model)));

      _allpackagesorder = List<Package>.from(
          _alldata['packages'].map((model) => Package.fromJson(model)));
      //  _nbnotification=_alldata["notificationCount"].toString();
    }




  loading=true;
  notifyListeners();
}

  Future<void>  getallpacakges(BuildContext c)async {
loading=false;
//notifyListeners();
    _alldata=await PackageService.getPackages();
    if(_alldata.length==0){

    }
  else  if(_alldata['status']!=null){

      Navigator.of(c).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              LoginScreen()), (Route<dynamic> route) => false);
    }
    else {
      if( _alldata['packages']!=null)
      _packages = Packages.fromJson( _alldata['packages']);
      // if(_alldata['cuisine']!=null)
       _cuisins = Cuisines.fromJson(_alldata['cuisine']);
     _addonsall = List<Addonall>.from(_alldata['addons'].map((model) => Addonall.fromJson(model)));
      _occasions = List<Occasion>.from(_alldata['occasions'].map((model) => Occasion.fromJson(model)));

       _listItems = List<Package>.from(
          _alldata['dropDown'].map((model) => Package.fromJson(model)));
       _nbnotification=_alldata["notificationCount"].toString();


    }

loading=true;
    notifyListeners();
  }


Future<void>  getalloccasions()async {
  loading=false;
//notifyListeners();
  _alloccasions=await PackageService.AllOccasions();

  loading=true;
  notifyListeners();

}




Future<void>  getonid(int id)async {


  _allons = await PackageService.getOnsbyid(id);

  //         Cuisines.fromJson(_alldata['cuisine']);
  // _addonsall = List<Addonall>.from(
  //     _alldata['addons'].map((model) => Addonall.fromJson(model)));
  // _occasions = List<Occasion>.from(
  //     _alldata['occasions'].map((model) => Occasion.fromJson(model)));
  // _listItems = List<Item>.from(
  //     _alldata['dropDown'].map((model) => Item.fromJson(model)));

//loading=true;

  notifyListeners();
}

Future<void>  getonidorder(int id,int idservice,bool a)async {
    print(id);
  loading = false;
  // notifyListeners();
  _allonsorder = await PackageService.getOnsbyidorder(id,idservice,a);
  loading = true;
  //         Cuisines.fromJson(_alldata['cuisine']);
  // _addonsall = List<Addonall>.from(
  //     _alldata['addons'].map((model) => Addonall.fromJson(model)));
  // _occasions = List<Occasion>.from(
  //     _alldata['occasions'].map((model) => Occasion.fromJson(model)));
  // _listItems = List<Item>.from(
  //     _alldata['dropDown'].map((model) => Item.fromJson(model)));

//loading=true;

  notifyListeners();
}

getAllFavorite()async{
    _listfavorite=await PackageService.getAllFavorite();
    notifyListeners();
}

Future<void>  getpacakgesby(int id)async {

//notifyListeners();
  _allpackages=await PackageService.getPackagesbyid(id);



  loading=true;

  notifyListeners();


}
Future<void>  getpacakgesbyidorder(int idservice,int iditemtyp,int idnumberguest)async {

//notifyListeners();
  _allpackagesorder=await PackageService.getPackagesbyidorder(idservice,iditemtyp,idnumberguest);



  loading=true;

  notifyListeners();


}
Future<void>  getcuisinby(int ic)async {

//notifyListeners();
  _allcuisins=await PackageService.getCuisbyid(ic);



  loading=true;

  notifyListeners();


}

 cleardata(){

  _alldata={};
  _packages.items=[];
  _cuisins.categories=[];
  _addonsall=[];
  loading=false;
  notifyListeners();

}

List<Cuisins> get allcuisins => _allcuisins;

  set allcuisins(List<Cuisins> value) {
    _allcuisins = value;
  }

Cuisines get cuisins => _cuisins;

  set cuisins(Cuisines value) {
    _cuisins = value;
  }

List<Addonall> get addonsallorder => _addonsallorder;

  set addonsallorder(List<Addonall> value) {
    _addonsallorder = value;
  }
}