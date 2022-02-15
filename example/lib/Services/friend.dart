import 'dart:convert';

import 'package:CaterMe/model/friend_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'ApiLink.dart';

class FriendServices {
  Future<List<FriendModel>> getAllFriends() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.GetAllFriends));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<FriendModel> posts = List<FriendModel>.from(
          responseData.map(
            (model) => FriendModel.fromJson(model),
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




 static Future<FriendModel> CreateFriend(
      // int id,
      String Name,
      int phoneNumber,
      String email,
      ) async {
    FriendModel createF=FriendModel();
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var request = http.MultipartRequest('POST', Uri.parse(ApiLink.Createfriends));
      request.headers.addAll(headers);
      request.fields.addAll({
        'Name': Name,
        'PhoneNumber': phoneNumber.toString(),
        'Email': email,
      });


      // open a bytestream

      http.StreamedResponse responses = await request.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        //  SharedPreferences prefs = await SharedPreferences.getInstance();

        createF =   FriendModel.fromJson(responseData);
        return createF;

      } else {
        print(response.reasonPhrase);
        return createF;
      }
    } catch (e) {
      print(e);
      return createF;
    }
  }
}
