import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/order_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderServices {
  Future<List<OrderModel>> getAllOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllOrders));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<OrderModel> posts = List<OrderModel>.from(
          responseData.map(
                (model) => OrderModel.fromJson(model),
          ),
        ); //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<OrderModel> getOrdersById(int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllOrdersById+"/$id"));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String,dynamic> responseData = json.decode(response.body);
        OrderModel posts =  OrderModel.fromJson(responseData);
        //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return OrderModel();
      }
    } catch (e) {
      return OrderModel();
    }
  }

}