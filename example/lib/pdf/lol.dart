import 'dart:io';
import 'package:CaterMe/colors/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'as not;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

String selectedNotificationPayload;

class ReceivedNotification {
  ReceivedNotification({
    @required this.id,
    @required this.title,
    @required this.body,
    @required this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}


int all =0 ;
int reviced =0;
 int percentage = 0;
class alpha extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'BILl CaterMe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationServices().requestIOSPermissions();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorCustom,
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'Download Progress Notification',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showProgressNotification();
        },
        backgroundColor: colorCustom,
        tooltip: 'Download Notification',
        child: Icon(Icons.download_sharp),
      ),
    );
  }

  Future<void> _showProgressNotification() async {
  //  downloadFile();
    const int maxProgress = 5;
    for (int i = 0; reviced <all; i++) {
      await Future<void>.delayed(const Duration(seconds: 1), () async {
        final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('progress channel', 'progress channel',
            channelDescription:  'progress channel description',
            channelShowBadge: false,
            importance: Importance.max,
            priority: Priority.high,
            onlyAlertOnce: true,
            showProgress: true,
            maxProgress: all,
            progress: reviced);
    final iosnotification =   IOSNotificationDetails(
        presentAlert:true,

        );
        final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics , iOS: iosnotification);
        await flutterLocalNotificationsPlugin.show(
            0,
            'Downloading',
            '${percentage} %',
            platformChannelSpecifics,
            payload: 'item x');

      });
    }
  }
  void downloadFile() {
    Dio dio = Dio();
    dio.download("https://yaz.in/assets/flutter/Flutter%20Cheat%20Sheet.pdf", '"a"/"b"',
        onReceiveProgress:  (rec,total) {
      setState(() {
        reviced=rec ;
        all= total;
         percentage = ((rec / total) * 100).floor();
      });
        });
  }
}



class NotificationServices {

//  BuildContext ctx;
  // Singleton pattern
  static final NotificationServices _notificationService =
  NotificationServices._internal();
  factory NotificationServices() {

    return _notificationService;
  }


  NotificationServices._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static final AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    channelId,
    "thecodexhub",
    channelDescription:
    "This channel is responsible for all the local notifications",
    playSound: true,

    // sound: RawResourceAndroidNotificationSound('ringnot'),
    priority: Priority.high,
    importance: Importance.high,
  );

  static final IOSNotificationDetails _iOSNotificationDetails =
  IOSNotificationDetails(sound: "ringnot.wav",
      presentSound: true


  );

  final NotificationDetails notificationDetails = NotificationDetails(
    android: _androidNotificationDetails,
    iOS: _iOSNotificationDetails,
  );

  Future<void> init() async {
    final AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings("@mipmap/launcher_icon",);

    final IOSInitializationSettings iOSInitializationSettings =
    IOSInitializationSettings(

      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: false,
    );

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    // *** Initialize timezone here ***
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }


  Future<void> showNotification(
      int id, String title, String body, String payload) async {



    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,


      payload: payload,

    );
  }

  Future<void> scheduleNotification(int id, String title, String body,
      DateTime eventDate, TimeOfDay eventTime, String payload,
      [DateTimeComponents dateTimeComponents]) async {
    final scheduledTime = eventDate.add(Duration(
      hours: eventTime.hour,
      minutes: eventTime.minute,
    ));
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: payload,
      matchDateTimeComponents: dateTimeComponents,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
  Future<void> onSelectNotification(String payload) async {
    await navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) {



      //   DetailsPage(payload: payload);
    }
    ));



  }
}


