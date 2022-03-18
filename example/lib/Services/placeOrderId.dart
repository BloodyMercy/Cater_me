
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_us_model.dart';

class placeOrderId {
 static Future<Map<String,dynamic>> PlaceOrderId(String idPlaceOrder1,String idPlaceOrder2)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('POST',Uri.parse(ApiLink.checkorder+"/$idPlaceOrder1"));
      request.headers.addAll(headers);

      request.bodyFields={

        "cardId":idPlaceOrder2
      };

      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        // ContactUsModel posts = ContactUsModel.fromJson(responseData);

        return responseData;
      } else {
        print(response.reasonPhrase);
        return {};
      }
    } catch (e) {
      return {};
    }
  }

}




