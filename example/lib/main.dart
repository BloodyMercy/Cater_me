import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';

import 'package:CaterMe/Screens/intro_screen.dart';
import 'package:CaterMe/Screens/order_summery_1.dart';
import 'package:CaterMe/Screens/splash_screen.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'Helpers/Constant.dart';
import 'NavigationBar/navigation_bar.dart';
import 'Providers/address.dart';
import 'Providers/cuisines.dart';
import 'Providers/occasion.dart';
import 'Providers/packages.dart';
import 'Providers/user.dart';


import 'Screens/order_summery_copy.dart';
import 'colors/colors.dart';
import 'package:flutter/material.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //await Firebase.initializeApp();
  //FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   print('User granted permission');
  // } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   print('User granted provisional permission');
  // } else {
  //   print('User declined or has not accepted permission');
  // }

  runApp(const MyApp());
}

class appstate extends StatefulWidget {
  const appstate({Key? key}) : super(key: key);

  @override
  _appstateState createState() => _appstateState();
}

class _appstateState extends State<appstate> {
  @override
  Widget build(BuildContext context) {
    //build context ?
    final authProvider = Provider.of<UserProvider>(context, listen: true);

    return FutureBuilder(
        future: checkservers,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("Server down ,, sryyyyy")],
              ),
            );
          }
   // bool a=snapshot.data as bool;

          if ( !true) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("erver down ,, sryyyyy")],
              ),
            );
          } else {
            switch (authProvider.status) {
              case Status.Unauthenticated:
                return SplashScreen();
              case Status.walkingpage:
                return IntroScreen();
              case Status.Authenticated:
                return Navigationbar(0);
            }

            return Container();
          }
        });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value:OrderStatusProvider()),
           ChangeNotifierProvider.value(value:OrderByIdProvider()),
          ChangeNotifierProvider.value(value: NotificationProvider()),
          ChangeNotifierProvider.value(value: FriendsProvider()),
          ChangeNotifierProvider.value(value: UserProvider.statusfunction()),
          ChangeNotifierProvider.value(value: PackagesProvider()),
          ChangeNotifierProvider.value(value: AdressProvider()),
          ChangeNotifierProvider.value(value: CuisineProvider()),
          ChangeNotifierProvider.value(value: OccasionProvider()),
          ChangeNotifierProvider.value(value: OrderProvider()),
          ChangeNotifierProvider.value(value: OrderCaterProvider()),

        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Cater Me',
          theme: ThemeData(
            primarySwatch: colorCustom,
            textTheme: const TextTheme(
              headline1: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
              // Style of the appBar text and the buttons
              headline2: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
              //Style of the food name, price, packages title, addOns title, add NewAddress, cuisines title,
              //occasion added, ocasion title, succesfully added, order placed
              headline3: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
              //homepage smaller fodd addons... , dashboard titles, drawer
              headline4: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
              // fullname, email.....
              headline5: TextStyle(
                  color: Colors.grey,
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
              // Style of the pop up texts
              headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'BerlinSansFB'),
            ),
          ),
          home:appstate(),
        ));
  }
}
