

import 'dart:convert';

import 'package:CaterMe/Screens/ocassionsScreens/occasions.dart';
import 'package:CaterMe/model/add_on.dart';
import 'package:CaterMe/model/cuisins.dart';
import 'package:CaterMe/model/occasion.dart';
import 'package:CaterMe/model/package.dart';
import 'package:CaterMe/model/packages.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiLink.dart';

class PackageService{


  static Future<Map<String, dynamic>> getPackages() async{
    List<Package> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.GetPackages));

       request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = json.decode(response.body);

      //  List<Package> posts = List<Package>.from(responseData['packages']['items'].map((model)=> Package.fromJson(model)));  //map to list


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
  static Future<List<Package>> getAllFavorite() async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllFavorite));

       request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

       List<dynamic> responseData = json.decode(response.body);

       List<Package> posts = List<Package>.from(responseData.map((model)=> Package.fromJson(model)));  //map to list


        return posts;
      }
      else if (response.statusCode == 401) {
         return [];

      }
      else {
        print(response.reasonPhrase);
        return [];
      }
    }catch(e){

      return [];
    }
  }
  static Future<List<AddOn>> getOnsbyidorder(int id,int idservice,bool a) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request;
      if(a)
      request = http.Request('GET', Uri.parse(ApiLink.GetItemByCuisine+"$id/$idservice"));
      else
         request = http.Request('GET', Uri.parse(ApiLink.GetItemByadd+"$id/$idservice"));
      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        List<dynamic> l = json.decode(response.body);
        List<AddOn> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(AddOn.fromJson(l[i]));

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
  static Future<List<AddOn>> getitemsbycat(int id) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getcusinibyid+"$id"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        List<dynamic> l = json.decode(response.body);
        List<AddOn> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(AddOn.fromJson(l[i]));

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
 static Future<List<AddOn>> getOnsbyid(int id) async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getcusinibyid+"$id"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);

      if (response.statusCode == 200) {
        List<dynamic> l = json.decode(response.body);
        List<AddOn> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(AddOn.fromJson(l[i]));

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
  static Future<List<Package>> getPackagesbyidorder(int idservice,int iditemetybe,int idnumberguest) async{
    List<Package> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.GETALLPACKAGEORDER+"$idservice/$iditemetybe/$idnumberguest"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

        List<dynamic> l = json.decode(response.body);
        List<Package> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(Package.fromJson(l[i]));

        //  List<Package> posts = List<Package>.from(responseData['packages']['items'].map((model)=> Package.fromJson(model)));  //map to list


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

  static Future<List<Package>> getPackagesbyid(int id) async{
    List<Package> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getcusinibyid+"$id"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

        List<dynamic> l = json.decode(response.body);
        List<Package> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(Package.fromJson(l[i]));

        //  List<Package> posts = List<Package>.from(responseData['packages']['items'].map((model)=> Package.fromJson(model)));  //map to list


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
  static Future<List<Cuisins>> getCuisbyid(int id) async{
    List<Package> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getcusinibyid));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

        List<dynamic> l = json.decode(response.body);
        List<Cuisins> ld=[];
        for(int i=0;i<l.length;i++)
          ld.add(Cuisins.fromJson(l[i]));

        //  List<Package> posts = List<Package>.from(responseData['packages']['items'].map((model)=> Package.fromJson(model)));  //map to list


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

  static Future<bool> favoriteitem(int id) async{
    List<Package> l=[];
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();



      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('POST', Uri.parse(ApiLink.favoriteitem+"${id}"));

      request.headers.addAll(headers);

      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {

        Map<String, dynamic> responseData = json.decode(response.body);



        return true;

      }
      else {
        print(response.reasonPhrase);
        return false;
      }



    }catch(e){

      return false;
    }
  }
  static Future<List<Occasion>> AllOccasions() async{

    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();

      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.Request('GET', Uri.parse(ApiLink.Getalloccasions));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var responses =await http.Response.fromStream(response);

      if (responses.statusCode == 200) {
        List<dynamic> responseData = json.decode(responses.body);
        List<Occasion> posts = List<Occasion>.from(
          responseData.map(
                (model) => Occasion.fromJson(model),
          ),
        ); //map to list
        return posts;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }






}