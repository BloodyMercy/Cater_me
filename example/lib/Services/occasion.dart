import 'dart:convert';

import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ApiLink.dart';

class OccasionService{
  Future createOccasion({
    int id,
    // bool hasReminder,
   String name,
  int typeId,
    String date,
  })async{
    Occasion occasion=Occasion();
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.CreateOccasions));
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


  Future<List<OccassionType>> getAllOcasionType() async{
    List<OccassionType> l=[];
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

        for(int i=0;i<responseData.length;i++){
          l.add(OccassionType.fromJson(responseData[i]));
        }
        return l;

      }
      else {
        print(response.reasonPhrase);
        return [];
      }



    }catch(e){
      return [];
    }
  }

  //newwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
  static Future<Map<String, dynamic>> getallnewoccasions() async{
    List<Occasion> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getalloccasions));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;

      }
      else if (response.statusCode == 401) {
        return {"status":"1"};

      }
      else {
        print(response.reasonPhrase);
        return {};
      }



    }catch(e){

      return {};
    }
  }
  update({String id ,String name , String typeId , String date , bool hasreminder }){


  }
}