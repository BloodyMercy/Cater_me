import 'dart:async';

import 'package:CaterMe/IntroTest/on_boarding_screen.dart';
import 'package:CaterMe/NavigationBar/navigation_bar.dart';
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
 // print(user.lg[user.language]["Home"]);
//  user.status=Status.Authenticated;
 // user.notifyListeners();

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
 //   chechkdata();
  }
  bool lg=true;


chechkdata() async{
    SharedPreferences sh=await SharedPreferences.getInstance();

    if(sh.getString("locale")==null)
      setState(() {
        lg=false;
      });
}
getdata() async{
  SharedPreferences sh=await SharedPreferences.getInstance();
  final user=Provider.of<UserProvider>(context,listen:false);

  if(sh.getString("locale")==null){

    user.status=Status.language;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>
           LanguagePicker()), (Route<dynamic> route) => false);

  }else if(sh.getBool("logged")??false){
   user.language=sh.getString("locale");
    user.status=Status.Authenticated;
   user.notifyListeners(); Navigator.of(context).pushReplacement(
       MaterialPageRoute(builder: (context) =>
           Navigationbar(0)));

  }

  else if(sh.getBool("wlkdone")==null){
    user.language=sh.getString("locale");

    user.status=Status.walkingpage;
    user.notifyListeners();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) =>
           OnBoardingScreens()), (Route<dynamic> route) => false);


  }
  else{
    user.language=sh.getString("locale");

    user.status=Status.Unauthenticated;
    user.notifyListeners();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>
            Navigationbar(0)));
  }

}
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<UserProvider>(context,listen:true);
Timer(Duration(seconds: 7), (){  getdata(); });


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
