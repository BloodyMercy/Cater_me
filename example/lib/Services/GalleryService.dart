import 'dart:convert';

import 'package:CaterMe/model/GaleryModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';
class GalleryService{
  Future<List> getimageshomepage() async {
    List<GalleryModel> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.gethomepageimage));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        responseData.forEach((element) {
          l.add(GalleryModel.fromJson(element));
        });
        return l;
      }
      else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }

  }  Future<List> getimageseeall() async {
    List<GalleryModel> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.getseeall));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        responseData.forEach((element) {
          l.add(GalleryModel.fromJson(element));
        });
        return l;
      }
      else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }

  }



}