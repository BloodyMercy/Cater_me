
import 'dart:convert';

import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class placeOrderId {
 static Future<Map<String,dynamic>> PlaceOrderId(String idPlaceOrder1,String idPlaceOrder2,bool a,bool b,Map<dynamic,dynamic> map) async {
 //static Future<Map<String,dynamic>> PlaceOrderId(String idPlaceOrder1,String idPlaceOrder2,bool a,bool b)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}',
        'Content-Type': 'application/json'


      };
      var request=http.Request('POST',Uri.parse(ApiLink.checkorder));
      request.headers.addAll(headers);
if(a) {
  request.body =json.encode( {
"orderid":idPlaceOrder1,
    "cardId": idPlaceOrder2
  });
}
else{
  if(b) {
    request.body=json.encode( {
 "orderid":idPlaceOrder1,
      "type": "applepay",
 "applePayData": {

 "version":map["version"],
 "data":map["data"],
 "signature":map["signature"],
 "ephemeralPublicKey":map["header"]["ephemeralPublicKey"],
 "publicKeyHash":map["header"]["publicKeyHash"],
 "transactionId":map["header"]["transactionId"],

 }
    });
  }
  else{
    request.bodyFields = {
 "orderid":idPlaceOrder1,
      "type": "googlepay",
      "googlePayData": {
   "":""
 }.toString()
    };
  }
}

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




