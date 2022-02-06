import 'package:CaterMe/Services/HomePage/cuisinesService.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:flutter/cupertino.dart';

class CuisineProvider extends ChangeNotifier{
  CuisinsService _cuisinsService=CuisinsService();
  List<dynamic> _cuisins=[];
  List<Cuisins> _cuisinsbyid=[];
  bool _loading=false;

  List<dynamic> get cuisins => _cuisins;

  set cuisins(List<dynamic> value) {
    _cuisins = value;
  }


  List<Cuisins> get cuisinsbyid => _cuisinsbyid;

  set cuisinsbyid(List<Cuisins> value) {
    _cuisinsbyid = value;
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }

  Future<void>  getallcuisins()async {
    loading=false;
    notifyListeners();
      _cuisins=await _cuisinsService.getcuisins();
    loading=true;

    notifyListeners();
  }



  Future<void>  getcuisinsbyid(int id)async {
    loading=false;
   // notifyListeners();
    _cuisinsbyid=await _cuisinsService.getcuisinsbyid(id);
    loading=true;

    notifyListeners();
  }

  clearData(){

    _cuisinsbyid = [];

}

}