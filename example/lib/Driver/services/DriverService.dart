import 'package:CaterMe/Driver/model/driver_model.dart';

import 'package:CaterMe/Driver/services/apilink.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DriverService {
  Future<Map<String,dynamic>> getOrderDriver() async {
    DriverOrderModel order=DriverOrderModel();
    try {
      var headers = {'Authorization': 'Bearer ${ApiLinkDriver.driverToken}'};
      var request = http.Request('GET', Uri.parse(ApiLinkDriver.AllOrders));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String,dynamic> responseData = json.decode(response.body);
        // order=DriverOrderModel.fromJson(responseData);
        return responseData;
      }else{
       return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<Map<String,dynamic>> getOrdersDetailsDriverById(int id) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${ApiLinkDriver.driverToken}'};
      var request = http.Request('GET', Uri.parse(ApiLinkDriver.orderDetailsDriver+"/$id"));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String,dynamic> responseData = json.decode(response.body);
        // OrderDetailsModel posts =  responseData.map((key, value) => null)
        //map to list
        return responseData;
      } else {
        print(response.reasonPhrase);
        return {};
      }
    } catch (e) {
      print(e);
      return {};
    }
  }
}
