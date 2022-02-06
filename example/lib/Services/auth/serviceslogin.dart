import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/Users.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLink.dart';

class AuthModelSignin {
  //thread

  // buildcontext        4g ram

  static Future<ErrorMessage> login(String username, String password) async {
    Users users = Users();
    String _username = username;
    String _password = password;
    // var data = {
    //   'Email': username,
    //   'Password': password,
    //   'DeviceToken':deviceToken
    // };
    //map //json.encode
    //json.decode

    try {
      var respons = http.MultipartRequest(
        'POST',
        Uri.parse(ApiLink.login),
      );
      String? token="";
        // await    FirebaseMessaging.instance.getToken().then((value) {
        //   token = value;
        //   print("the token is $value");
        // });

      respons.fields.addAll({
        'Email': username,
        'Password': password,
        'DeviceToken': token!
      });
      // final response = await http.post(Uri.parse("${ApiLink.login}"),///${ApiLink.login}
      //     body: data,
      //     );

      http.StreamedResponse responses = await respons.send();
      var response = await http.Response.fromStream(responses);
      //print(response.statusCode);
      // print("data");
      if (response.statusCode == 200) {
        // print(response);
        //  final respStr = await response.stream.bytesToString();
        //   print(respStr);
        //print(response.body);

        Map<String, dynamic> responseData = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString("token", responseData['token']);
        // p.getString("userid")
        users = Users.fromJson(responseData);
        ErrorMessage em = ErrorMessage();
        em.response = true;
        em.message = "";
        em.user=users;
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
}
