import 'package:CaterMe/Providers/contact_us_provider.dart';
import 'package:CaterMe/Providers/credit_card_provider.dart';
import 'package:CaterMe/Providers/friend.dart';
import 'package:CaterMe/Providers/notification_provider.dart';
import 'package:CaterMe/Providers/order.dart';
import 'package:CaterMe/Providers/orderById_provider.dart';
import 'package:CaterMe/Providers/orderStatus_provider.dart';
import 'package:CaterMe/Providers/order_provider.dart';
import 'package:CaterMe/Providers/personal_info_provider.dart';
import 'package:CaterMe/Screens/auth/newlogin/screens/loginScreen.dart';
import 'package:CaterMe/SplachScreen.dart';
import 'package:CaterMe/colors/colors.dart';
import 'package:CaterMe/widgets/Payment/credit_cards_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Helpers/Constant.dart';
import 'IntroTest/on_boarding_screen.dart';
import 'NavigationBar/navigation_bar.dart';
import 'Providers/address.dart';
import 'Providers/cuisines.dart';
import 'Providers/occasion.dart';
import 'Providers/packages.dart';
import 'Providers/user.dart';
import 'Screens/auth/login_screen.dart';
import 'chat/providers/chat_provider.dart';
import 'colors/colors.dart';
import 'notificaition/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  NotificationServices notificationService = NotificationServices();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
  runApp( MyApp());
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
class appstate extends StatefulWidget {
  const appstate({Key key}) : super(key: key);

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

          if (!true) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("erver down ,, sryyyyy")],
              ),
            );
          } else {
            switch (authProvider.status) {
              case Status.Unauthenticated:
                return Navigationbar(0);

              case Status.walkingpage:
                return OnBoardingScreens();
              case Status.Authenticated:
                return Navigationbar(0);
              default :
                return LoginScreen();
            }


          }
        });
  }
}

class MyApp extends StatefulWidget {
   MyApp({Key key}) : super(key: key);
   static String lang ="en";
   static void setLocale(BuildContext context, Locale newLocale) async {
     _MyAppState state = context.findAncestorStateOfType< _MyAppState>();

     var prefs = await SharedPreferences.getInstance();
     prefs.setString('languageCode', newLocale.languageCode);
     prefs.setString('countryCode', "");

     state?.setState(() {
       state._locale = newLocale;
       state.languageCode=newLocale.languageCode;

       // lang= newLocale.languageCode;
     });

   }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   SharedPreferences prefs;

   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

   FirebaseStorage firebaseStorage = FirebaseStorage.instance;

   Locale _locale = Locale("en", "US");
   String languageCode="";
   @override
   void initState() {
     super.initState();
     this._fetchLocale().then((locale) {
       setState(() {
         this._locale = locale;
         //  languageCode=locale.languageCode;
       });
     });
   }
   Future<Locale> _fetchLocale() async {
     var prefs = await SharedPreferences.getInstance();

     languageCode =  'en';
     String countryCode = prefs.getString('countryCode') ?? '';

     return Locale(languageCode, countryCode);
   }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PersonalInfoProvider()),
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
            prefs: this.prefs,
            firebaseFirestore: this.firebaseFirestore,
            firebaseStorage: this.firebaseStorage,
          ),
        ),
        ChangeNotifierProvider.value(value: OrderStatusProvider()),
        ChangeNotifierProvider.value(value: OrderByIdProvider()),
        ChangeNotifierProvider.value(value: ContactUsProvider()),
        ChangeNotifierProvider.value(value: NotificationProvider()),
        ChangeNotifierProvider.value(value: FriendsProvider()),
        ChangeNotifierProvider.value(value: UserProvider.statusfunction()),
        ChangeNotifierProvider.value(value: PackagesProvider()),
        ChangeNotifierProvider.value(value: AdressProvider()),
        ChangeNotifierProvider.value(value: CuisineProvider()),
        ChangeNotifierProvider.value(value: OccasionProvider()),
        ChangeNotifierProvider.value(value: OrderProvider()),

        ChangeNotifierProvider.value(value: OrderCaterProvider()),
        ChangeNotifierProvider.value(value: CreditCardsProvider()),
        ChangeNotifierProvider.value(value: ContactUsProvider()),
      ],

      child: MaterialApp(
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale("en", "US"), // OR Locale('ar', 'AE') OR Other RTL locales
            Locale('ar', 'AE')
          ],
          locale: _locale,


        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Cater Me',
        theme: ThemeData(
          primarySwatch: colorCustom,
          textTheme: const TextTheme(
            bodyText1:  TextStyle(
                color: Color(0xFF3F5521),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'BerlinSansFB'),
            bodyText2:  TextStyle(
                color: Color(0xFF3F5521),
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'BerlinSansFB'),
            headline1: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'BerlinSansFB'),
            // Style of the appBar text and the buttons
            headline2: TextStyle(
                color: Color(0xFF3F5521),
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
              fontFamily: 'BerlinSansFB',
            ),
            // Style of the pop up texts
            headline6: TextStyle(
                color: Colors.black,
                fontSize: 17,
                // fontWeight: FontWeight.bold,
                fontFamily: 'BerlinSansFB'),
          ),
        ),
        home:SplashScreen()
      ),
    );
  }
}
