import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/language/language.dart';
import 'package:CaterMe/model/personal_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';

class PersonalInfoService {
  Future<Map<String,Map<String,String>>> getLangauge() async{
   try{
     var request = http.Request('GET', Uri.parse(ApiLink.getLanguage));
    // request.headers.addAll(headers);
    http.StreamedResponse responses = await request.send();
    var response = await http.Response.fromStream(responses);
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      LanguageModel posts = LanguageModel.fromJson(responseData);
      //map to list
      return posts.lg;
    } else {
      print(response.reasonPhrase);
      return {};
    }
  } catch (e) {
  return {};
  }
  }
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

  Future<ErrorMessage> updateInfo(String name,String email,String phoneNumber,String birthDate)async{
    PersonalInfoModel personalInfo=PersonalInfoModel();
    ErrorMessage msg=ErrorMessage();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.MultipartRequest('POST', Uri.parse(ApiLink.UpdatePersonalInfo));
      request.headers.addAll(headers);
      request.fields.addAll({
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'birthDate': birthDate
      });


      // open a bytestream

      http.StreamedResponse responses = await request.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        //  SharedPreferences prefs = await SharedPreferences.getInstance();

        personalInfo =   PersonalInfoModel.fromJson(responseData);
       msg.response=true;
        return msg;

      } else {
        print(response.reasonPhrase);
        msg.response=false;
        return msg;
      }

    }catch(e){
print(e);
    }
    return msg;
  }

  Future<ErrorMessage> resetPasswordbymail(String email,String newPassword,String confirmPassword) async{
    ErrorMessage msg=ErrorMessage();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.MultipartRequest('POST', Uri.parse(ApiLink.ResetPasswordbyemail));
      request.headers.addAll(headers);
      request.fields.addAll({
        'Email': email,
        'NewPassword': newPassword,
        'ConfirmPassword': confirmPassword
      });


      // open a bytestream

      http.StreamedResponse responses = await request.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {

        msg.response=true;
        return msg;

      } else {
        print(response.reasonPhrase);
        msg.response=false;
        return msg;
      }

    }catch(e){
      print('mmmmmmmmmmmmmmmmmmmmmmmmm');
      print(e);
    }
    return msg;
  }


  Future<ErrorMessage> resetPasswordbyphone(String phone,String newPassword,String confirmPassword) async{
    ErrorMessage msg=ErrorMessage();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var request = http.MultipartRequest('POST', Uri.parse(ApiLink.ResetPasswordbyphone));
      // request.headers.addAll(headers);
      request.fields.addAll({
        'PhoneNumber': phone,
        'NewPassword': newPassword,
        'ConfirmPassword': confirmPassword
      });


      // open a bytestream

      http.StreamedResponse responses = await request.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {

        msg.response=true;
        return msg;

      } else {
        print(response.reasonPhrase);
        msg.response=false;
        return msg;
      }

    }catch(e){
      print(e);
    }
    return msg;
  }

  Future<ErrorMessage> resetPassword(String oldPassword,String newPassword,String confirmPassword) async{
    ErrorMessage msg=ErrorMessage();
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.MultipartRequest('POST', Uri.parse(ApiLink.ResetPassword));
      request.headers.addAll(headers);
      request.fields.addAll({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      });


      // open a bytestream

      http.StreamedResponse responses = await request.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {

        msg.response=true;
        return msg;

      } else {
        print(response.reasonPhrase);
        msg.response=false;
        return msg;
      }

    }catch(e){
      print(e);
    }
    return msg;
  }
}