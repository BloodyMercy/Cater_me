import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OrderByIdService {
  // Future<List<OrderByIdModel>> getOrdersById(int id) async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
  //     var request = http.Request('GET', Uri.parse(ApiLink.GetAllOrdersById+"/$id"));
  //     request.headers.addAll(headers);
  //     http.StreamedResponse responses = await request.send();
  //     var response = await http.Response.fromStream(responses);
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseData = json.decode(response.body);
  //       List<OrderByIdModel> posts = List<OrderByIdModel>.from(
  //         responseData.map(
  //               (model) => OrderByIdModel.fromJson(model),
  //         ),
  //       );
  //       //map to list
  //       return posts;
  //     } else {
  //       print(response.reasonPhrase);
  //        return [];
  //     }
  //   } catch (e) {
  //     return [];
  //   }
  // }

  Future<List<OrderDetailsModel>> getOrdersDetailsById(int id) async {
    OrderDetailsModel order=OrderDetailsModel();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllOrdersById+"/$id"));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<OrderDetailsModel> posts = List<OrderDetailsModel>.from(
          responseData.map(
                (model) => OrderDetailsModel.fromJson(model),
          ),
        );
        //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}