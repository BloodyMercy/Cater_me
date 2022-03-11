import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';

class OccasionService {
  Future createOccasion({
    int id,
    // bool hasReminder,
    String name,
    int typeId,
    String date,
  }) async {
    Occasion occasion = Occasion();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'};
      var respons = http.MultipartRequest(
          'POST', Uri.parse(ApiLink.CreateOccasions));
      respons.headers.addAll(headers);
      respons.fields.addAll({
        'profileId': id.toString(),
        'Title': name,
        'TypeId': typeId.toString(),
        'date': date,
        // 'HasReminder': "${hasReminder}",
      });

      // open a bytestream

      http.StreamedResponse responses = await respons.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        //  SharedPreferences prefs = await SharedPreferences.getInstance();

        occasion = Occasion.fromJsonadd(responseData);
        return occasion;
      } else {
        print(response.reasonPhrase);
        return occasion;
      }
    } catch (e) {
      print(e);
      return occasion;
    }
  }


  Future<List<OccassionType>> getAllOcasionType(String a) async {
    List<OccassionType> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllOccasionsType));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        // List<City> posts = List<City>.from(responseData.map((model)=> City.fromJson(model)));  //map to list
       l.add( OccassionType(id: -700, name: "Add occasion", image: ''));
        for (int i = 1; i < responseData.length; i++) {
          l.add(OccassionType.fromJson(responseData[i],a));
        }
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

  //newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
  static Future<Map<String, dynamic>> getallnewoccasions() async {
    List<Occasion> l = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();


      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.Getalloccasions));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        print("rifai200");
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      }
      else if (response.statusCode == 401) {
        Map<String, dynamic> responseData = json.decode(response.body);
       // if(responseData.length>0)
        return responseData;

       // print("rifai200");
      }
      else {
        print(response.reasonPhrase);
        return {};
      }
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  update({int id, String name, int typeId, String date }) async {
    Occasion occasion = Occasion();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}','Content-Type': 'application/json'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.Updateoccasions));
      respons.headers.addAll(headers);
      respons.fields.addAll({
        'Id': id.toString(),
        'Title': name,
        'TypeId': typeId.toString(),
        'Date': date,

      });
      http.StreamedResponse responses = await respons.send();

      var response = await http.Response.fromStream(responses);
      print("${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        occasion = Occasion.fromJson(responseData);
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


  Future<ErrorMessage> deleteOcation(int id) async {
    ErrorMessage em = ErrorMessage();
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'};
      var respons = http.MultipartRequest(
          'POST', Uri.parse(ApiLink.Deleteoccasions + "/$id"));
      respons.headers.addAll(headers);
      http.StreamedResponse responses = await respons.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        em.message = "deleted";
        return em;
      } else {
        em.message = "cannot delete";
        return em;
      }
    }
    catch (e) {
      print("error cannot delete");
    }
    return ErrorMessage();
  }
}
