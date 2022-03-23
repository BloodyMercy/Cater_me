
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Survey.dart';
import '../model/contact_us_model.dart';

class SurveyService {
   Future<surveyModel> getallsurvey()async {
    try{
      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.getsurvey));
      request.headers.addAll(headers);
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        surveyModel posts = surveyModel.fromJson(responseData);

        return posts;
      } else {
        print(response.reasonPhrase);
        return surveyModel();
      }
    } catch (e) {
      return surveyModel();
    }
  }

}




