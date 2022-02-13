import 'dart:convert';

import 'package:CaterMe/model/TimeSpanModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ApiLink.dart';

class timeSpanService{

adjustString(String adjust){

  return adjust.replaceAll(RegExp('[^A-Za-z0-9]'), '-', );
}

   Future<timeSpanHours> gettimespan(String id ,String id2) async{
    timeSpanHours value =timeSpanHours();
    try {
id=adjustString(id);
//id2=adjustString(id2);

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Gettimespan +"${id}/${id2}"));

      request.headers.addAll(headers);
    //  request.

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

       Map<String,dynamic> l = json.decode(response.body);

       // for(int i=0;i<l.length;i++)
          value=timeSpanHours.fromJson(l);

        //  List<Package> posts = List<Package>.from(responseData['packages']['items'].map((model)=> Package.fromJson(model)));  //map to list


        return value;

      }

      else {
        print(response.reasonPhrase);
        return timeSpanHours();
      }



    }catch(e){
print(e);
      return value;
    }
  }
}