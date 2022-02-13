import 'package:CaterMe/Services/ApiLink.dart';
import 'package:CaterMe/model/orderById.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class OrderByIdService {
  Future<Map<String,dynamic>> getOrdersDetailsById(int id) async {
      try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllOrdersById+"/$id"));
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

  Future<bool> Donate(int id) async{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
       var request = http.Request('POST', Uri.parse(ApiLink.DonateFood+"/$id"));
       request.headers.addAll(headers);
       http.StreamedResponse responses = await request.send();
       var response = await http.Response.fromStream(responses);
       if(response.statusCode==200){
         return true;
       }else{
         return false;
       }
     }
     catch(e){
       print(e);
     }
  }
}