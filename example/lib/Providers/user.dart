import 'dart:io';

import 'package:CaterMe/Services/auth/services_signUp.dart';
import 'package:CaterMe/Services/auth/serviceslogin.dart';
import 'package:CaterMe/Services/personal_info_service.dart';
import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/Users.dart';
import 'package:CaterMe/model/personal_info.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  Authenticated, //inside application
  Unauthenticated,
  walkingpage
}

class UserProvider with ChangeNotifier {
  TextEditingController email = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController zipcode = TextEditingController();
  TextEditingController cityname = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController street = TextEditingController();

  TextEditingController shopnumber = TextEditingController();
  TextEditingController buldingname = TextEditingController();
  TextEditingController floornumber = TextEditingController();
  TextEditingController district = TextEditingController();

  TextEditingController shopname = TextEditingController();
  TextEditingController specialist = TextEditingController();
  TextEditingController bio = TextEditingController();

  TextEditingController loyatlypoint = TextEditingController();
  String _birthDate="";


  String get birthDate => _birthDate;

  set birthDate(String value) {
    _birthDate = value;
  }

  Status _status=Status.walkingpage;


  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  PersonalInfoModel _personalInfo=PersonalInfoModel();

  getPersonalInfo() async{
    _personalInfo=  await PersonalInfoService().getAllInfo();
    name.text=_personalInfo.name;
    email.text=_personalInfo.email;
    phoneNumber.text=_personalInfo.phoneNumber;
    birthDate=_personalInfo.birthDate;

    notifyListeners();
  }
  String _messagelogin = "";
  String _messageSignUp = "";

  String get messagelogin => _messagelogin;

  set messagelogin(String value) => _messagelogin = value;
  String get messageSignUp => _messageSignUp;

  set messageSignUp(String value) => _messageSignUp = value;

  UserProvider.statusfunction() {

getdata();
email.text="patourtohme9@gmail.com";
password.text="Peter69@";





  }


  getdata() async{
    SharedPreferences sh=await SharedPreferences.getInstance();




    if(sh.getBool("logged")??false){

      _status=Status.Authenticated;
      notifyListeners();
    }

   else if(sh.getBool("wlkdone")??false){

      _status=Status.Unauthenticated;
      notifyListeners();

    }


  }

  Future<bool> LogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      //_status = Status.Authenticating;
      notifyListeners();
      ErrorMessage u = await AuthModelSignin.login(
          email.text.toString(), password.text.toString());

      String? token = "";

      _messagelogin = u.message;


      if(u.response){
        _status=Status.Authenticated;
      }


      notifyListeners();
      return u.response;
    } catch (error) {
      //_status = Status.Unauthenticated;

      _messagelogin = "error try again";

      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp( File image,String b) async {
   //  SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      notifyListeners();
      ErrorMessage u = await AuthModelSignUp.SignUp(
        name.text.toString(),
        email.text.toString(),
        phoneNumber.text.toString(),
        password.text.toString(),
        password.text.toString(),
        b,
        gender.text.toString(),
        image
      );

      _messageSignUp = u.message;

      notifyListeners();
      return u.response;
    } catch (error) {
      print(error);
      _messageSignUp = "error try again later from provider";

      notifyListeners();
      return false;
    }
  }
}
