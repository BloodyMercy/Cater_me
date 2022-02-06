import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/orderByIdStatus_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class StatusOrderService {
  Future<OrderByIdStatusModel> getOrderStatus(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetOrderStatus+"/$id"));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String,dynamic> responseData = json.decode(response.body);
        OrderByIdStatusModel posts =  OrderByIdStatusModel.fromJson(responseData);
        //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return OrderByIdStatusModel();
      }
    } catch (e) {
      return OrderByIdStatusModel();
    }
  }
}