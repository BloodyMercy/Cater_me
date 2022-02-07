import 'package:CaterMe/model/personal_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ApiLink.dart';

class PersonalInfoService {
  Future<PersonalInfoModel> getAllInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetPersonalInfo));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        PersonalInfoModel posts = PersonalInfoModel.fromJson(responseData);
        //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return PersonalInfoModel();
      }
    } catch (e) {
      return PersonalInfoModel();
    }
  }
}