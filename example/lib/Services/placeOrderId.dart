
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_us_model.dart';

class placeOrderId {
  Future<Map<String,dynamic>> PlaceOrderId(String idPlaceOrder1,String idPlaceOrder2)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('POST',Uri.parse(ApiLink.makeorder+"/$idPlaceOrder1"+"/$idPlaceOrder2"));
      request.headers.addAll(headers);

      request.body=json.encode({
        "addressId":idPlaceOrder1,
        "serviceId":idPlaceOrder2
      });

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




