import 'dart:io';

import 'package:CaterMe/Services/auth/services_signUp.dart';
import 'package:CaterMe/Services/auth/serviceslogin.dart';
import 'package:CaterMe/Services/personal_info_service.dart';
import 'package:CaterMe/model/RestCallAPi.dart';
import 'package:CaterMe/model/personal_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  Authenticated, //inside application
  Unauthenticated,
  walkingpage
}

class UserProvider with ChangeNotifier {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController forgetPassword = TextEditingController();
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
  TextEditingController emailChat = TextEditingController();
  TextEditingController genderselected = TextEditingController();

  TextEditingController loyatlypoint = TextEditingController();
  String _birthDate="";
  String _imageUrl="";
  String _language = "ar";


  String get language => _language;

  set language(String value) {
    _language = value;
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  bool _loading=false;


  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  }




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
    birthday.text= DateFormat("dd-MM-yyyy").format(DateTime.parse(_personalInfo.birthDate));
    imageUrl=_personalInfo.imageUrl;
    notifyListeners();
  }
  String _messagelogin = "";
  String _messageSignUp = "";
  String _forgetpass='';

  String get forgetpass => _forgetpass;

  set forgetpass(String value) {
    _forgetpass = value;
  }

  String _messageUpdateInfo = "";

  String get messagelogin => _messagelogin;

  set messagelogin(String value) => _messagelogin = value;
  String get messageSignUp => _messageSignUp;

  set messageSignUp(String value) => _messageSignUp = value;

  UserProvider.statusfunction() {
getdata();
  }


  getdata() async{
    SharedPreferences sh=await SharedPreferences.getInstance();
    emailChat.text=sh.getString('email');



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

      String token = "";

      _messagelogin = u.message;


      if(u.response){
        getdata();
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      notifyListeners();
      ErrorMessage u = await AuthModelSignUp.SignUp(
        name.text.toString(),
        email.text.toString(),
        phoneNumber.text.toString(),
        password.text.toString(),
        password.text.toString(),
        b,
        genderselected.text.toString(),
        image
      );
      getdata();
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

  Future<String> updateProfile( File image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      //notifyListeners();
      ErrorMessage u = await AuthModelSignin.updateProfile(
          image
      );
imageUrl=u.message;

  //    mess = u.message;

     // notifyListeners();
      return u.message;
    } catch (error) {
      print(error);
      _messageSignUp = "error try again later from provider";

   //  notifyListeners();
      return "";
    }
  }
  Future<bool> forgetpassword( ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      //notifyListeners();
    bool u = await AuthModelSignin.forgetPassword(
          forgetPassword.text
      );
//_forgetpass=u.message;

  //    mess = u.message;

     // notifyListeners();
      return u;
    } catch (error) {
      print(error);
      _forgetpass = "error try again later from provider";

   //  notifyListeners();
      return false;
    }
  }



  Future updateInfo()async{
    try{
      notifyListeners();
      ErrorMessage msg = await PersonalInfoService().updateInfo(
        name.text.toString(),
        email.text.toString(),
        phoneNumber.text.toString(),
        _birthDate
      );
      _messageUpdateInfo = msg.message;
      notifyListeners();
      return msg.response;
    }catch(error){
      print(error);
    }
  }
  Future ResetPassword()async{
    try{
      notifyListeners();
      ErrorMessage msg = await PersonalInfoService().resetPassword(oldPassword.text.toString(), password1.text.toString(), confirmpassword.text.toString());

      notifyListeners();
      return msg.response;
    }catch(error){
      print(error);
    }
  }

  clearAllTextController(){
    oldPassword.clear();
    email.clear();
    insta.clear();
    facebook.clear();
    confirmpassword.clear();
    password.clear();
    password1.clear();
    name.clear();
    phoneNumber.clear();
    birthday.clear();
    gender.clear();
    zipcode.clear();
    cityname.clear();
    apartment.clear();
    street.clear();

    shopnumber.clear();
    buldingname.clear();
    floornumber.clear();
    district.clear();

    shopname.clear();
    specialist.clear();
    bio.clear();

    loyatlypoint.clear();
  }



}
