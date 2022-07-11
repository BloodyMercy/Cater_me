import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'IntroTest/on_boarding_screen.dart';
import 'NavigationBar/navigation_bar.dart';
import 'Providers/user.dart';
import 'main.dart';

class LanguagePicker extends StatefulWidget {
  @override
  State<LanguagePicker> createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {


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
    final personalInfo = Provider.of<UserProvider>(context, listen: true);
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    var mediaQueryWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              "images/logo-white.png",
              height: MediaQuery.of(context).size.height * 0.4,
            )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: Text('English'),
                      onPressed: () async {


                        SharedPreferences _prefs =
                            await SharedPreferences.getInstance();
                        _prefs.setString("locale", "en");
                         personalInfo.language = "en";
                         MyApp.setLocale(context, Locale("en", "US"));
                        // Navigator.of(context).pushAndRemoveUntil(
                        //     MaterialPageRoute(
                        //       builder: (context) => appstate(),
                        //     ),
                        //     (Route<dynamic> route) => false);
                        // AppLocalizations.of(context)!.locale.toString()

                        // .language="ar";                                              },
                         getdata();
                  },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryWidth * 0.1,
                            vertical: mediaQueryHeight * 0.02),
                      )),
                  ElevatedButton(
                      onPressed: () async {
                        SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                        _prefs.setString("locale", "ar");
                        personalInfo.language = "ar";
                        MyApp.setLocale(context, Locale("ar", "AE"));
                        getdata();
                      },
                        child: Text('العربية'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            horizontal: mediaQueryWidth * 0.125,
                            vertical: mediaQueryHeight * 0.016),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
