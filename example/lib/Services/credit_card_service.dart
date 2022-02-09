import 'dart:convert';

import 'package:CaterMe/model/credit_card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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
  Future deleteCreditCard(int id) async{

  }
}