
import 'dart:convert';
import 'package:CaterMe/Services/ApiLink.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Survey.dart';
import '../model/contact_us_model.dart';

class SurveyService {
   Future<List<surveyModel>> getallsurvey()async {
     List<surveyModel> posts =[];
    try{

      SharedPreferences prefs=await SharedPreferences.getInstance();
      var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request=http.Request('GET',Uri.parse(ApiLink.getsurvey));
      request.headers.addAll(headers);
      http.StreamedResponse responses =await request.send();
      var response = await http.Response.fromStream(responses);
      print(response.statusCode);
      if (response.statusCode == 200) {

        List<Map<String, dynamic>> responseData = json.decode(response.body);
        responseData.forEach((element) {
          posts.add(surveyModel.fromJson(element,prefs.getString("locale"))); });


        return posts;
      } else {
        print(response.reasonPhrase);
        return posts;
      }
    } catch (e) {
      print("===========-------======");
      print(e);
      return [surveyModel()];
    }
  }


    Future<bool> postreview({String complaint, double rating ,List<int> feedbackoptionid})async {
     try{
       SharedPreferences prefs=await SharedPreferences.getInstance();
       var headers={'Authorization': 'Bearer ${prefs.getString("token")}'};
       var request=http.Request('POST',Uri.parse(ApiLink.submitsurvey));
       request.headers.addAll(headers);

       request.body=json.encode({
         "complaint":complaint ,
         "rating": rating,
         "feedbackOptionId": feedbackoptionid
       });

       http.StreamedResponse responses =await request.send();
       var response = await http.Response.fromStream(responses);
       if (response.statusCode == 200) {

         return true;
       } else {
         print(response.reasonPhrase);
         return false;
       }
     } catch (e) {
       print(e);
       return false;
     }
   }

}




