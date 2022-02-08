import 'dart:convert';
import 'dart:io';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/Users.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ApiLink.dart';

class AuthModelSignUp {
  static Future<ErrorMessage> SignUp(
    String name,
    String email,
    String phoneNumber,
    String password,
    String comfirmPassword,
    String birthDate,
    String gendder,
      File image
  ) async {
    try {
      String token="";
      await    FirebaseMessaging.instance.getToken().then((value) {
        token = value.toString();
        print("the token is $value");

        token=token;

      });
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.Register));

      respons.fields.addAll({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber.toString(),
        'password': password,
        'confirmPassword': comfirmPassword,
        'birthDate': "12-10-2000",
        'DeviceToken': token,
        // 'gender': gendder,
      });

        // open a bytestream
      if(image!=null) {
      //  var stream = new http.ByteStream(image.openRead());
     //   stream.cast();
        // get file length
       // var length = await image.length();

        // string to uri
        //  var uri = Uri.parse("http://ip:8082/composer/predict");

        // create multipart request
        //  var request = new http.MultipartRequest("POST", uri);

        // multipart that takes file


        // add file to multipart
        respons.files.add(await http.MultipartFile.fromPath('FormFile', image.path));


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

        prefs.setString("token", responseData['token']);

        SharedPreferences image = await SharedPreferences.getInstance();
        image.setString('imageUrl', responseData['imageUrl']);

        SharedPreferences email = await SharedPreferences.getInstance();
        email.setString('email', responseData['email']);

        // users = Users.fromJson(responseData);
        ErrorMessage em = ErrorMessage();
        em.response = true;
        em.message = "";

        return em;
      } else {
        Map<String, dynamic> responseData = json.decode(response.body);

        ErrorMessage em = ErrorMessage();
        em.response = false;
        em.message = responseData["message"];

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
}
