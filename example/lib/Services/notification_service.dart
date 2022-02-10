import 'dart:convert';

import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/friend_model.dart';
import 'package:CaterMe/model/notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'ApiLink.dart';

class NotificationService {


  Future<notificationModel> createNotification({
     String Title,
     String Body,

  }) async {
    notificationModel NotificationModel=notificationModel();
    try {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.Createnotification));
      respons.headers.addAll(headers);
      respons.fields.addAll({
        //    'Id': prefs.getString("token").toString(),
        'Title': Title,
        'Body': Body,
      });

      // open a bytestream

      http.StreamedResponse responses = await respons.send();
      // responses.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      // });
      var response = await http.Response.fromStream(responses);
      // print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        //  SharedPreferences prefs = await SharedPreferences.getInstance();

        NotificationModel = notificationModel.fromJson(responseData);
        return NotificationModel;

      } else {
        print(response.reasonPhrase);
        return NotificationModel;
      }
    } catch (e) {
      print(e);
      return NotificationModel;
    }
  }

  Future<List<notificationModel>> getAllNotifications() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {'Authorization': 'Bearer ${prefs.getString("token")}'};
      var request = http.Request('GET', Uri.parse(ApiLink.notification));
      request.headers.addAll(headers);
      http.StreamedResponse responses = await request.send();
      var response = await http.Response.fromStream(responses);
      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        List<notificationModel> posts = List<notificationModel>.from(
          responseData.map(
                (model) => notificationModel.fromJson(model),
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
Future markAsRead(int id) async{

    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var headers = {
        'Authorization': 'Bearer ${prefs.getString("token")}'   };
      var respons = http.MultipartRequest('POST', Uri.parse(ApiLink.SeenNotification+"/$id"));
      respons.headers.addAll(headers);
      http.StreamedResponse responses = await respons.send();

      var response = await http.Response.fromStream(responses);
      print("ssssssssssssssssssssssssssssssssss${response.statusCode}");
      if (response.statusCode == 200) {
        return;
      }else{
        return;
      }
      }catch(e){
      print(e);
      return;
    }
}

}


