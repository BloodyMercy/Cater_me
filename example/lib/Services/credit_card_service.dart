import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/credit_card_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';
class CreditCardsService{

  Future<List<CreditCardsModel>> getAllCreditCards() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllCreditCards));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<CreditCardsModel> posts = List<CreditCardsModel>.from(responseData.map((model)=> CreditCardsModel.fromJson(model)));  //map to list
        return posts;
      }
      else {
        print(response.reasonPhrase);
        return [];
      }
    }catch(e){
      return [];
    }
  }

  Future<ErrorMessage> deleteCreditCard(int id) async{
    ErrorMessage em=ErrorMessage();
try{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  var headers = {
    'Authorization': 'Bearer ${prefs.getString("token")}'
  };
  var request = http.Request('POST', Uri.parse(ApiLink.DeleteCreditCards+"/$id"));
  request.headers.addAll(headers);
  http.StreamedResponse responses = await request.send();
  var response = await http.Response.fromStream(responses);
  if(response.statusCode==200){
    em.message="deleted";
    return em;
  }else{
    em.message="cannot delete";
    return em;
  }
}
catch(e){
  print(e);
}
  }
}