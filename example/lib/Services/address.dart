import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/address/address.dart';
import 'package:CaterMe/model/address/city.dart';
import 'package:CaterMe/model/address/country.dart';
import 'package:CaterMe/model/address/regular.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';

class AddressService{


  Future<bool> getdistance(int id) async {
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.getDistance));
      respons.headers.addAll(headers);
      respons.fields.addAll({
        //    'Id': prefs.getString("token").toString(),
        "AddressId":id.toString(),
      });

      // open a bytestream

      http.StreamedResponse responses = await respons.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);

      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        String  responseData = json.decode(response.body);
        //  SharedPreferences prefs = await SharedPreferences.getInstance();
   if(responseData == true) {
     return true;
   }else{
     return false;
   }

      } else {
        print(response.reasonPhrase);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }


 Future<Address> createAddress({
     String addresstitle,
     String country,
     String city,
     String street,
     String building,
     String floor,
    String longitude,
    String latitude,
}) async {
    Address address=Address();
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.AddAddress));
      respons.headers.addAll(headers);
      respons.fields.addAll({
  //    'Id': prefs.getString("token").toString(),
      'Title': addresstitle,
      'City': city,
      'Street': street,
      'BuildingName': building,
      'FloorNumber': floor,
      'Country': country,
        'longitude':longitude,
        'latitude':latitude,
      });

      // open a bytestream

      http.StreamedResponse responses = await respons.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
      //  SharedPreferences prefs = await SharedPreferences.getInstance();

        address = Address.fromJson(responseData);
return address;

      } else {
        print(response.reasonPhrase);
        return address;
      }
    } catch (e) {
      print(e);
      return address;
    }
  }

 Future<Address> updateAddress({
   int id,
   String addresstitle,
   String country,
   String city,
   String street,
   String building,
   String floor,
   String longitude,
   String latitude,
 }) async {
   Address address=Address();
   try {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var headers = {
       'Authorization': 'Bearer ${prefs.getString("token")}'   };
     var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.UpdateAddress));
     respons.headers.addAll(headers);
     respons.fields.addAll({
       'Id': id.toString(),
       'Title': addresstitle,
       'City': city,
       'Street': street,
       'BuildingName': building,
       'FloorNumber': floor,
       'Country': country,
       'longitude':longitude,
       'latitude':latitude,
     });

     // open a bytestream

     http.StreamedResponse responses = await respons.send();
     // responses.stream.transform(utf8.decoder).listen((value) {
     //   print(value);
     // });
     var response = await http.Response.fromStream(responses);
     print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
     if (response.statusCode == 200) {
       Map<String, dynamic> responseData = json.decode(response.body);
       //  SharedPreferences prefs = await SharedPreferences.getInstance();

       address = Address.fromJson(responseData);
       return address;

     } else {
       print(response.reasonPhrase);
       return address;
     }
   } catch (e) {
     print(e);
     return address;
   }
 }


Future<ErrorMessage> deleteAddress(int id) async{
   ErrorMessage em=ErrorMessage();
   try{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var headers = {
       'Authorization': 'Bearer ${prefs.getString("token")}'   };
     var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.DeleteAddress+"/$id"));
     respons.headers.addAll(headers);
     http.StreamedResponse responses = await respons.send();
     var response = await http.Response.fromStream(responses);
     if(response.statusCode==200){
       em.message="deleted";
       return em;
     }else{
       em.message="cannot delete";
       return em;
     }

   }
   catch(e){
     print("error cannot delete");
   }
   return ErrorMessage();

}
   Future<List<City>> getAllCity(int id) async{
    List<City> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllCity+id.toString()));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

       List<dynamic> responseData = json.decode(response.body);

        // List<City> posts = List<City>.from(responseData.map((model)=> City.fromJson(model)));  //map to list

        for(int i=0;i<responseData.length;i++){
          l.add(City.fromJson(responseData[i]));
        }
        return l;

      }
      else {
        print(response.reasonPhrase);
        return [];
      }



    }catch(e){
print("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee:$e");
      return [];
    }
  }

  Future<List<Country>> getAllCountry() async{

    List<Country> l=[];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllCountry));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssssssssss:${response.statusCode}");
      if (response.statusCode == 200) {

        List<dynamic> responseData = json.decode(response.body);

        // List<City> posts = List<City>.from(responseData.map((model)=> City.fromJson(model)));  //map to list

        for(int i=0;i<responseData.length;i++){
          l.add(Country.fromJson(responseData[i]));
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

  Future<List<Address>> getAllAddress() async{

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllAddress));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
         List<Address> posts = List<Address>.from(responseData.map((model)=> Address.fromJson(model)));  //map to list
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
  Future<Regular> getRegular(String a) async{

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'
      };
      var request = http.Request('GET', Uri.parse(ApiLink.GetOrdersSetting));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        Map<String,dynamic> responseData = json.decode(response.body);
        Regular posts = Regular.fromJson(responseData,a);
        return posts;
      }
      else {
        print(response.reasonPhrase);
        return Regular();
      }
    }catch(e){
      return Regular(); }
  }
}