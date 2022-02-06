import 'dart:convert';

import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/occasions/occasion.dart';
import 'package:CaterMe/model/occasions/occasiontype.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ApiLink.dart';

class OccasionService{
  Future createOccasion({
    required bool hasReminder,
    required String name,
    required  int typeId,
    required String date,
  })async{
    Occasion occasion=Occasion();
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.CreateOccasions));
      respons.headers.addAll(headers);
      respons.fields.addAll({
        // 'Id': "0",
        'Name': '${name}',
        'TypeId': "${typeId}",
        'Date': '${date}',
        'HasReminder': "${hasReminder}",
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

        occasion = Occasion.fromJson(responseData);
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
}