import 'dart:async';

import 'package:CaterMe/NavigationBar/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'auth/login_screen.dart';
import 'auth/newlogin/screens/loginScreen.dart';

String finalEmail;

class SplashScreens extends StatefulWidget {
  const SplashScreens({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();

    getValidationData().whenComplete(() async {
      Timer(
        Duration(
          seconds: 3,
        ),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                finalEmail == null ?  LoginScreen() : Navigationbar(0),
          ),
        ),
      );
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
              ),
            ],
          ),
        ));
  }
}
