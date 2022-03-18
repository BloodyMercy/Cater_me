
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/contact_us_model.dart';

class OtpVerify {
  static Future<Map<String,dynamic>> Otpverify(String id)async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.GetOrderStatus+"/$id"));
      request.headers.addAll(headers);
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




