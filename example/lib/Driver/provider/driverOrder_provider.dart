import 'package:CaterMe/Driver/model/driver_model.dart';
import 'package:CaterMe/Driver/services/DriverService.dart';
import 'package:flutter/cupertino.dart';

class DriverOrderProvider extends ChangeNotifier{
  DriverService _driverService=DriverService();
  Map<String,dynamic> _allData={};

  Map<String, dynamic> get allData => _allData;

  set allData(Map<String, dynamic> value) {
    _allData = value;
  }

  List<TodayOrders> _todayOrder=[];

  List get todayOrder => _todayOrder;

  set todayOrder(List value) {
    _todayOrder = value;
  }

  getOrder()async{
   allData = await _driverService.getOrderDriver();
   if(allData==null){
     print("No Data");
   }else{
     todayOrder=List<TodayOrders>.from(allData['todayOrders'].map((model) => TodayOrders.fromJson(model)));
   }
   notifyListeners();
  }
}