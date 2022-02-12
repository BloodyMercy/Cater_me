


import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));
}
void changeScreenpop(BuildContext context, Widget widget) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) => widget));
}






void changeScreenUntilsignup(BuildContext context) async{
SharedPreferences pref=await SharedPreferences.getInstance();
String roleSharedCust=   pref.getString("welcome",);
String roleSharedProf=   pref.getString("welcome");


  //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    //  AddressFillOutScreen()), (Route<dynamic> route) => false);




}
void changescreenuntill(BuildContext context ,Widget widget){


  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      widget), (Route<dynamic> route) => false);
}