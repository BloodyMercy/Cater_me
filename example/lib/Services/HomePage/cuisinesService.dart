import 'dart:convert';

import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../ApiLink.dart';

class CuisinsService{
  getcuisins() async {

    try{
    SharedPreferences prefs = await SharedPreferences.getInstance();



    var headers = {
      'Authorization': 'Bearer ${prefs.getString("token")}'   };
    var request = http.Request('GET', Uri.parse(ApiLink.GetPackages));

    request.headers.addAll(headers);

    http.StreamedResponse responses = await request.send();
    var response = await http.Response.fromStream(responses);

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      List<Cuisins> posts = List<Cuisins>.from(responseData['cuisine']['categories'].map((model)=> Cuisins.fromJson(model)));  //map to list
      return posts;
    }
    else {
      print(response.reasonPhrase);
      return [];
    }
    }catch(e){
      return [];
    }
  }
  getcuisinsbyid(int id) async {

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.categoryTypeId+"$id"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
     List<dynamic> l = json.decode(response.body);
   List<Cuisins> ld=[];

for(int i=0;i<l.length;i++)
  ld.add(Cuisins.fromJson(l[i]));

       // List<Cuisins> posts = List<Cuisins>.from(responseData['cuisine']['categories'].map((model)=> Cuisins.fromJson(model)));  //map to list
        return ld;
      }
      else {
        print(response.reasonPhrase);
        return [];
      }
    }catch(e){
      return [];
    }
  }
}