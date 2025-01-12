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

import '../language/language.dart';
import '../model/Users.dart';

enum Status {
  Authenticated, //inside application
  Unauthenticated,
  spalchscreen,
  walkingpage,
  language,
}

class UserProvider with ChangeNotifier {
  AuthModelSignUp userexist =AuthModelSignUp();


  checkingifexist _user = checkingifexist();
  String _error="";

  String get error => _error;

  set error(String value) {
    _error = value;
  }
  ResetPassword() async {
    ErrorMessage a;
    a =await  PersonalInfoService().resetPasswordbyphone(phoneNumber.text, password1otp.text, confirmpasswordotp.text,email.text);
   phoneNumber.clear();
   password1otp.clear();
   confirmpasswordotp.clear();
    return a.response;


  }
  Future<ErrorMessage> ResetPasswordout()async{
    ErrorMessage a;
   a =await  PersonalInfoService().resetPassword(oldPassword.text, password1.text, confirmpassword.text);
  return a;
  }
  // GenerateOTPprovider() async {
  //   _user= await  AuthModelSignUp.GenerateOTPservice(phoneNumber.text) ;
  //   if(!_user.phone){
  //     _error="true";
  //
  //   }else{
  //     _error="phone already exist";
  //
  //   }
  //   notifyListeners();
  // }



  checkingexistprovider() async {
    _user= await  AuthModelSignUp.Checkinguserexist(email.text, phoneNumber.text) ;
    // phoneNumber.text="";
    // email.text="";


    if(!_user.phone||!_user.email){
     _error= !_user.email?"email already exist":"phone already exist";
    }else{
      _error="true";

    }
  notifyListeners();
  }
  Map<String,Map<String,dynamic>> _lg={};


  Map<String, Map<String, dynamic>> get lg => _lg;

  set lg(Map<String, Map<String, dynamic>> value) {
    _lg = value;
    notifyListeners();
  }
bool _loadinglanguage=false;

  bool get loadinglanguage => _loadinglanguage;

  set loadinglanguage(bool value) {
    _loadinglanguage = value;
  }

  getLanguage() async{

    lg= LanguageTr.lg;
    loadinglanguage=true;
    notifyListeners();
  }

  TextEditingController oldPassword = TextEditingController();
  TextEditingController forgetPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController insta = TextEditingController();
  TextEditingController facebook = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController confirmpasswordotp = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password1otp = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController birthdaylan = TextEditingController();
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
    notifyListeners();
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

  Status _status=Status.spalchscreen;


  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }

  PersonalInfoModel _personalInfo=PersonalInfoModel();

  PersonalInfoModel get personalInfo => _personalInfo;

  getPersonalInfo() async{
    _personalInfo=  await PersonalInfoService().getAllInfo();
    name.text=_personalInfo.name;
    email.text=_personalInfo.email;
    phoneNumber.text=_personalInfo.phoneNumber;
    birthDate=_personalInfo.birthDate;
    //birthday.text=_personalInfo.birthDate;
    if(_personalInfo.birthDate!="") {
      birthday.text = DateFormat("yyyy-MM-dd").format(
          DateTime.parse(_personalInfo.birthDate));
      birthdaylan.text = DateFormat("dd-MM-yyyy").format(
          DateTime.parse(_personalInfo.birthDate));
    }
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

  set messagelogin(String value) {

    _messagelogin = value;
    notifyListeners();
  }


  String get messageSignUp => _messageSignUp;

  set messageSignUp(String value) {
    _messageSignUp = value;
  }

  UserProvider.statusfunction() {
//getdata();
  }


  getdata() async{
    SharedPreferences sh=await SharedPreferences.getInstance();
    // emailChat.text=sh.getString('email')??"";

if(sh.getString("locale")==null){

  _status=Status.language;
  notifyListeners();

}else
    if(sh.getBool("logged")??false){
language=sh.getString("locale");
      _status=Status.Authenticated;
      notifyListeners();
    }

   else if(sh.getBool("wlkdone")==null){
      language=sh.getString("locale");

      _status=Status.walkingpage;
      notifyListeners();

    }
   else{
      language=sh.getString("locale");

      _status=Status.Unauthenticated;
      notifyListeners();
    }


  }
  String ToEnglishNumbers(String s)
  {
    return
      s.replaceAll("٠","0").
      replaceAll("۱", "1").
      replaceAll("۲", "2").
      replaceAll("۳", "3").
      replaceAll("٤", "4").
      replaceAll("٥", "5").
      replaceAll("٦", "6").
      replaceAll("٧", "7").
      replaceAll("٨", "8").
      replaceAll("٩", "9");
  }
  static String ConvertDigitsToLatin(String s) {
    var sb = new StringBuffer();
    for (int i = 0; i < s.length; i++) {
      switch (s[i]) {
        case '\u06f0':
          sb.write('0');
          break;
        case '\u06f1':
          sb.write('1');
          break;
        case '\u06f2':
          sb.write('2');
          break;
        case '\u06f3':
          sb.write('3');
          break;
        case '\u06f4':
          sb.write('4');
          break;
        case '\u06f5':
          sb.write('5');
          break;
        case '\u06f6':
          sb.write('6');
          break;
        case '\u06f7':
          sb.write('7');
          break;
        case '\u06f8':
          sb.write('8');
          break;
        case '\u06f9':
          sb.write('9');
          break;
        case '\u0660':
          sb.write('0');
          break;
        case '\u0661':
          sb.write('1');
          break;
        case '\u0662':
          sb.write('2');
          break;
        case '\u0663':
          sb.write('3');
          break;
        case '\u0664':
          sb.write('4');
          break;
        case '\u0665':
          sb.write('5');
          break;
        case '\u0666':
          sb.write('6');
          break;
        case '\u0667':
          sb.write('7');
          break;
        case '\u0668':
          sb.write('8');
          break;
        case '\u0669':
          sb.write('9');
          break;
        default:
          sb.write(s[i]);
          break;
      }
    }
    return sb.toString();
  }
  Future<bool> LogIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      //_status = Status.Authenticating;
      notifyListeners();
      print(ConvertDigitsToLatin(email.text.toString()));
      print( ConvertDigitsToLatin(email.text.toString()));
      print(  password.text.toString());
      ErrorMessage u = await AuthModelSignin.login(
          ConvertDigitsToLatin(email.text.toString()), password.text.toString());

      String token = "";

      messagelogin = u.message;


      if(u.response){
        SharedPreferences sh =
        await SharedPreferences.getInstance();
        sh.setBool("logged", true);
        getdata();
        _status=Status.Authenticated;

      }


      notifyListeners();
      return u.response;
    } catch (error) {
      //_status = Status.Unauthenticated;

      _messagelogin =    '${lg[language]["Camera"]}';

      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp( File image,String b) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
 int i=1;
 if(
 genderselected.text.contains("F")  || genderselected.text.contains("ب") )i=2;

 if(
 genderselected.text.contains("R")  || genderselected.text.contains("ع") )i=3;

    try {
      notifyListeners();
      ErrorMessage u = await AuthModelSignUp.SignUp(
        name.text.toString(),
        email.text.toString(),
          ToEnglishNumbers(phoneNumber.text.toString()),
        password.text.toString(),
        password.text.toString(),
        b.isEmpty  ? DateTime(1996,04,11).toString().split(' ').first : b,
        i.toString(),
        image
      );
    //  getdata();
      _messageSignUp = u.message;
      status=Status.Authenticated;

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
      return u;
    } catch (error) {
      print(error);
      _forgetpass = "error try again later from provider";

      return false;
    }
  }



  Future updateInfo()async{
    try{
      notifyListeners();
      ErrorMessage msg = await PersonalInfoService().updateInfo(
        name.text.toString(),
        email.text.toString(),
          ToEnglishNumbers(phoneNumber.text.toString()),
        birthday.text
      );
      _messageUpdateInfo = msg.message;
      notifyListeners();
      return msg.response;
    }catch(error){
      print(error);
    }
  }
  Future ResetPasswordbymail()async{
    try{
      notifyListeners();
      ErrorMessage msg = await PersonalInfoService().resetPasswordbymail(email.text.toString(), password1.text.toString(), confirmpassword.text.toString());

      notifyListeners();
      return msg.response;
    }catch(error){
      print(error);
    }
  }
  Future ResetPasswordbyphones()async{
    try{
      notifyListeners();
      ErrorMessage msg = await PersonalInfoService().resetPasswordbyphone(phoneNumber.text.toString(), password1.text.toString(), confirmpassword.text.toString(),email.text);

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
