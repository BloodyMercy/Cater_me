import 'dart:async';

import 'package:CaterMe/Providers/user.dart';
import 'package:CaterMe/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'language_picker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    {
 // AnimationController _controller;
getLanguage() async{
  final user=Provider.of<UserProvider>(context,listen:false);
  await user.getLanguage();
}
AssetImage image;
  @override
  void initState() {
    super.initState();
    image=AssetImage("images/animation/CaterMeUpdatedGif.gif");
    getLanguage();
    // _controller = AnimationController(
    //   duration: Duration(seconds: (1)),
    //   vsync: this,
    // );
    chechkdata();
  }
  bool lg=true;


chechkdata() async{
    SharedPreferences sh=await SharedPreferences.getInstance();

    if(sh.getString("locale")==null)
      setState(() {
        lg=false;
      });
}
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context,listen:false);
    Timer(
      Duration(milliseconds: 7000),
      () { if (lg){
if(user.loadinglanguage) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) =>
            appstate(),
      ), (Route<dynamic> route) => false
  );
}
      else {
        print("failed to get data");
      }
      }
       else{
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                LanguagePicker(),
          ), (Route<dynamic> route) => false
        );
      }


      }

    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child:   Image(
            image:image,


         height: MediaQuery.of(context).size.height * 0.60,
         width: MediaQuery.of(context).size.width * 0.7,
      )),
    );
  }

@override
void dispose() {
  image.evict();
  super.dispose();
}

}
