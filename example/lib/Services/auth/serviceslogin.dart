import 'dart:convert';
import 'dart:io';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/Users.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLink.dart';

class AuthModelSignin {
  //thread


//get



/*
{
[
{
},

{
},



]


}




 */

  static Future<ErrorMessage> login(String username, String password) async {
    Users users = Users();
    String _username = username;
    String _password = password;

    try {
      var respons = http.MultipartRequest(
        'POST',
        Uri.parse(ApiLink.login),
      );
      String token = "";
      await FirebaseMessaging.instance.getToken().then((value) {
        token = value.toString();
        print("the token is $value");

        token = token;
      });
      respons.fields.addAll({
        'Email': username,
        'Password': password,
        'DeviceToken': token,
      });

      http.StreamedResponse responses = await respons.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", responseData['token']);

        prefs.setString('imageUrl', responseData['imageUrl']);
        prefs.setString('iduser', responseData['imageUrl']);

        prefs.setString('name', responseData['name']);

        prefs.setString('phoneNumber', responseData['phoneNumber']);
        prefs.setString('email', responseData['email']);
        prefs.commit();

        // p.getString("userid")
        users = Users.fromJson(responseData);
        ErrorMessage em = ErrorMessage();
        em.response = true;
        em.message = "";
        em.user = users;

        //int id=responseData["id"];

        // push()

        return em;
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);

        ErrorMessage em = ErrorMessage();
        em.response = false;
        em.message = responseData["message"];

        return em;

        // print(responseData['message']);

      }
    } catch (e) {
      ErrorMessage em = ErrorMessage();
      em.response = false;
      em.message = "error try again";
      return em;
    }

    //return 0;
  }

  static Future<ErrorMessage> updateProfile(File image) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      //   var request = http.Request('GET', Uri.parse(ApiLink.GetAllFriends));

      var respons =
          http.MultipartRequest('POST', Uri.parse(ApiLink.UpdateProfle));
      respons.headers.addAll(headers);

      // open a bytestream
      if (image != null) {
        var stream = new http.ByteStream(image.openRead());
        stream.cast();
        // get file length
        var length = await image.length();

        // string to uri
        //  var uri = Uri.parse("http://ip:8082/composer/predict");

        // create multipart request
        //  var request = new http.MultipartRequest("POST", uri);

        // multipart that takes file
        // var multipartFile = new http.MultipartFile('FormFile', stream, length, filename: basename(image.path));
        // await http.MultipartFile.fromPath('FormFile', image.path);
        // add file to multipart
        respons.files
            .add(await http.MultipartFile.fromPath('FormFile', image.path));

        // send
        //var response = await respons.send();
        //print(response.statusCode);

        // listen for response

      }
      http.StreamedResponse responses = await respons.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        // prefs.setString("token", responseData['token']);
        prefs.setString('imageUrl', responseData['imageUrl']);

        // users = Users.fromJson(responseData);
        ErrorMessage em = ErrorMessage();
        em.response = true;
        em.message = responseData['imageUrl'];

        return em;
      } else {
        // Map<String, dynamic> responseData = json.decode(response.body);

        ErrorMessage em = ErrorMessage();
        em.response = false;
        em.message = "error try again ";

        return em;
      }
    } catch (e) {
      print(e);
      ErrorMessage em = ErrorMessage();
      em.response = false;
      em.message = "error try again later from service";
      return em;
    }
  }

  static Future<bool> forgetPassword(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var request = http.MultipartRequest('POST', Uri.parse('https://caterme.azurewebsites.net/api/Accounts/ForgetPassword'));
    request.fields.addAll({
      'identifier': email
    });
    // var request =
    // http.MultipartRequest('POST', Uri.parse(ApiLink.ForgotPassword));
    // request.fields.addAll({
    //   'identifier':email
    // });
    var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());
      return true;
    } else {
      // print(response.reasonPhrase);
      return false;
    }
  }

}
