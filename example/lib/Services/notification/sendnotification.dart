import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

sendNotification(String title,String body,String token)async{

  try {
    if(!kIsWeb) {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAATeJZ6do:APA91bHC1vencF3rlI1m8FjJ-WdigOwuJsc40dOIQxdJZOuGAt8LiwXYpIPVU9cpvVSo98gWYkVfcR6K9LagdsRu_88uqW21haU5Mp3YNveFIWGBI7nN_oOTXA_3jjhJ0kveOYGzSp2o',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            //  'type': type,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'body': body,
              'title': title,
            //  'type': type,
            },

            'to': token,
          },
        ),
      );
    }
  } catch (e) {
    print("");
    print(e);
  }
}