import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/setup_items_model.dart';
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
       // if(responseData["creditCard"]["cardNumber"]==null)
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

  Future<List<setupItemsModel>> getallsetupItems(String a)async {
    List l=[];
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.setupitems));
      request.headers.addAll(headers);
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        l =List<setupItemsModel>.from(responseData['setupItems'].map((model) => setupItemsModel.fromJson(model,a)));
        // setupItemsModel posts = setupItemsModel.fromJson(responseData,a);

        return l;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<bool> Donate(int id,bool a,bool a1,bool a2,bool a3) async{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
       var request = http.Request('POST', Uri.parse(ApiLink.DonateFood+"/$id"));
       request.headers.addAll(headers);
       request.body=jsonEncode({
         'isDonatingFood': a.toString(),
         'isNeedChair': a1.toString(),
         'isNeedTables': a2.toString(),
         'isNeedCateringService': a3.toString()
       });
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
  Future<String> generateInvoicepdf(int id)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.GenerateInvoice+"/$id"));
      request.headers.addAll(headers);
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        print(response);
        print(response.body);
        print(response.statusCode);
        Map<String, dynamic> responseData = json.decode(response.body);
        // dynamic responseData = json.decode(response.body);
        print(responseData);
        // String link = responseData[];
        return responseData["url"]??'Not found';
      } else {
        print(response.reasonPhrase);
        return "";
      }
    } catch (e) {
      print(e);
      return "";
    }
  }
}