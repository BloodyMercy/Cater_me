
import 'package:CaterMe/notificaition/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

NotificationServices notificationService = NotificationServices();
 inAppMessaging(BuildContext context,Widget widget)  async {
 FirebaseMessaging messaging = FirebaseMessaging.instance;
 messaging
     .getToken()
     .then((String token) {
   assert(token != null);
 });

 try{
   print('Got a message whilst in the foreground1!');

 await  FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
   await notificationService.showNotification(
     0,
     message.notification.title,
     message.notification.body,

      // "title": message.data["title"],
       message.data["orderId"].toString()
       //"eventDate": "DateFormat.format(eventDate!",
      // "eventTime": "eventTime!.format(context)",

   );

   });
 //await FirebaseMessaging.onMessageOpenedApp

   // await  FirebaseMessaging?.onBackgroundMessage((message) async{
   //   await notificationService.showNotification(
   //     0,
   //     message.data["title"],
   //     message.data["body"],
   //     jsonEncode({
   //       "title": message.data["title"],
   //       "eventDate": "DateFormat.format(eventDate!",
   //       "eventTime": "eventTime!.format(context)",
   //     }),
   //   );
   //
   //
   // });

 }catch(e){
   print('exception in app messaging Message data: ${e}');
 }
}


